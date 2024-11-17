# 演習

## 演習1

urlのリストテーブルあり、最低以下３つのカラム情報があります。

|作成日付|URL|ラベル|
|---|---|---|
|date型|varchar(255)|varchar(1024)|


データ量が多く２つのカラム組み合わせでは重複数が多いので、以下のように３つのカラムをインデックスを設定しようしましたが、MySQLのインデックス最大キー長を超えてしまいます。



```mysql
mysql> ALTER TABLE url_list
    -> ADD INDEX index1(create_date, url, label);
ERROR 1071 (42000): Specified key was too long; max key length is 3072 bytes

```

|InnoDBページサイズ|拡張したインデックスの最大キー長|拡張なしのインデックスの最大キー長|
|---|---|---|
|16K|3072バイト|767バイト|
|8k|1536バイト|767バイト|
|4k|768バイト|767バイト|

[上記参照元](https://gihyo.jp/dev/serial/01/mysql-road-construction-news/0032)

基本的には単一カラムインデックスの最大キー長は767バイトまで作成ででき、特定の条件ではインデックスの最大キー長を3072バイトまで拡張することができます。

対象のテーブルのCHARSETはutf8mb4なので、1文字4バイト必要となる。
なので、256文字だと4倍の1024バイト必要なります。

[14.6.7 InnoDB テーブル上の制限](https://dev.mysql.com/doc/refman/5.6/ja/innodb-restrictions.html)

[B-tree](https://www.cs.usfca.edu/~galles/visualization/BTree.html)

### INDEX設定詳細

仮に、一旦レベルのカラムも文字列長を256にして設定してみると、範囲内に収まるので複合INDEXは作成で来ます。

```mysql
mysql> use exercise_db;
Database changed

mysql> show create database exercise_db;
+-------------+---------------------------------------------------------------------------------------------------------------------------------------+
| Database    | Create Database                                                                                                                       |
+-------------+---------------------------------------------------------------------------------------------------------------------------------------+
| exercise_db | CREATE DATABASE `exercise_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */ |
+-------------+---------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)



CREATE TABLE url_list
(
    create_date date PRIMARY KEY NOT NULL,
    url VARCHAR(255) NOT NULL,
    labal VARCHAR(256) NOT NULL
);

mysql> DESC url_list;
+-------------+--------------+------+-----+---------+-------+
| Field       | Type         | Null | Key | Default | Extra |
+-------------+--------------+------+-----+---------+-------+
| create_date | date         | NO   | MUL | NULL    |       |
| url         | varchar(255) | NO   |     | NULL    |       |
| label       | varchar(256) | NO   |     | NULL    |       |
+-------------+--------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> show create table url_list;
+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table    | Create Table                                                                                                                                                                                |
+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| url_list | CREATE TABLE `url_list` (
  `create_date` date NOT NULL,
  `url` varchar(255) NOT NULL,
  `label` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

mysql> ALTER TABLE url_list
    -> ADD INDEX index1(create_date, url, label);
Query OK, 0 rows affected (0.00 sec)
Records: 0  Duplicates: 0  Warnings: 0
 
mysql> SHOW INDEX FROM url_list;
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| url_list |          1 | index1   |            1 | create_date | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| url_list |          1 | index1   |            2 | url         | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| url_list |          1 | index1   |            3 | label       | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.00 sec)
 
mysql> DROP INDEX index1 on url_list;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0
 
mysql> ALTER TABLE url_list MODIFY label VARCHAR(1024) NOT NULL;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> DESC url_list;
+-------------+---------------+------+-----+---------+-------+
| Field       | Type          | Null | Key | Default | Extra |
+-------------+---------------+------+-----+---------+-------+
| create_date | date          | NO   |     | NULL    |       |
| url         | varchar(255)  | NO   |     | NULL    |       |
| label       | varchar(1024) | NO   |     | NULL    |       |
+-------------+---------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

mysql> ALTER TABLE url_list
    -> ADD INDEX index1(create_date, url, label);
ERROR 1071 (42000): Specified key was too long; max key length is 3072 bytes

```
### 模範回答1

1024文字という長いカラム`label`の値をハッシュ化してデータを格納（アプリ側で挿入・更新にデータのハッシュ化して格納、抽出時は条件の文字列をハッシュ化して検索)する別のカラム`label_crc`を設置する。
そして、`label`の代わりに`label_crc`を３つ目のINDEXとして指定する。

```
mysql> ALTER TABLE url_list ADD label_crc BIGINT NOT NULL;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> DESC url_list;
+-------------+---------------+------+-----+---------+-------+
| Field       | Type          | Null | Key | Default | Extra |
+-------------+---------------+------+-----+---------+-------+
| create_date | date          | NO   |     | NULL    |       |
| url         | varchar(255)  | NO   |     | NULL    |       |
| label       | varchar(1024) | NO   |     | NULL    |       |
| label_crc   | bigint        | NO   |     | NULL    |       |
+-------------+---------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> ALTER TABLE url_list ADD INDEX index1(create_date, url, label_crc);
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SHOW INDEX FROM url_list;
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| url_list |          1 | index1   |            1 | create_date | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| url_list |          1 | index1   |            2 | url         | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| url_list |          1 | index1   |            3 | label_crc   | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+

3 rows in set (0.00 sec)mysql> INSERT INTO url_list
    -> (
    ->     create_date,
    ->     url,
    ->     label,
    ->     label_crc
    -> )
    -> VALUES
    ->  ('2021-01-01','https://www.yahoo.co.jp/', 'ポータルサイトの老舗', CRC32('ポータルサイトの老舗')),
    ->  ('2021-01-02','https://www.google.com/search?q=hage', 'hoge検索一覧', CRC32('hoge検索一覧'));
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM url_list;
+-------------+--------------------------------------+--------------------------------+------------+
| create_date | url                                  | label                          | label_crc  |
+-------------+--------------------------------------+--------------------------------+------------+
| 2021-01-01  | https://www.yahoo.co.jp/             | ポータルサイトの老舗           | 1376164120 |
| 2021-01-02  | https://www.google.com/search?q=hage | hoge検索一覧                   | 4243743388 |
+-------------+--------------------------------------+--------------------------------+------------+
2 rows in set (0.00 sec)

mysql> SELECT 
    ->     *
    -> FROM
    ->     url_list
    -> WHERE
    ->     create_date = '2021-01-02'
    -> AND
    ->     url = 'https://www.google.com/search?q=hage'
    -> AND
    ->     label_crc = CRC32('hoge検索一覧');
+-------------+--------------------------------------+------------------+------------+
| create_date | url                                  | label            | label_crc  |
+-------------+--------------------------------------+------------------+------------+
| 2021-01-02  | https://www.google.com/search?q=hage | hoge検索一覧     | 4243743388 |
+-------------+--------------------------------------+------------------+------------+
1 row in set (0.01 sec)

```

### 模範回答2

3つのカラムを合わせてハッシュ化して

```mysql
mysql> ALTER TABLE url_list CHANGE label_crc crc BIGINT;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> DESC url_list;
+-------------+---------------+------+-----+---------+-------+
| Field       | Type          | Null | Key | Default | Extra |
+-------------+---------------+------+-----+---------+-------+
| create_date | date          | NO   | MUL | NULL    |       |
| url         | varchar(255)  | NO   |     | NULL    |       |
| label       | varchar(1024) | NO   |     | NULL    |       |
| crc         | bigint        | YES  |     | NULL    |       |
+-------------+---------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> TRUNCATE TABLE url_list;
Query OK, 0 rows affected (0.02 sec)

mysql> INSERT INTO url_list
    -> (
    ->     create_date,
    ->     url,
    ->     label,
    ->     crc
    -> )
    -> VALUES
    ->  ('2021-01-01','https://www.yahoo.co.jp/', 'ポータルサイトの老舗', CRC32(CONCAT('2021-01-01','https://www.yahoo.co.jp/', 'ポータルサイトの老舗'))),
    ->  ('2021-01-02','https://www.google.com/search?q=hage', 'hoge検索一覧', CRC32(CONCAT('2021-01-02','https://www.google.com/search?q=hage', 'hoge検索一覧')));
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>  
mysql> SELECT * FROM url_list;
+-------------+--------------------------------------+--------------------------------+------------+
| create_date | url                                  | label                          | crc        |
+-------------+--------------------------------------+--------------------------------+------------+
| 2021-01-01  | https://www.yahoo.co.jp/             | ポータルサイトの老舗           | 3328707800 |
| 2021-01-02  | https://www.google.com/search?q=hage | hoge検索一覧                   | 3198148295 |
+-------------+--------------------------------------+--------------------------------+------------+
2 rows in set (0.00 sec)

mysql> SELECT 
    ->     *
    -> FROM
    ->     url_list
    -> WHERE
    ->     crc =  CRC32(CONCAT('2021-01-02','https://www.google.com/search?q=hage', 'hoge検索一覧'));
+-------------+--------------------------------------+------------------+------------+
| create_date | url                                  | label            | crc        |
+-------------+--------------------------------------+------------------+------------+
| 2021-01-02  | https://www.google.com/search?q=hage | hoge検索一覧     | 3198148295 |
+-------------+--------------------------------------+------------------+------------+
1 row in set (0.00 sec)



```


### ペケ回答1

一つの回答としては以下のようにする。

プライマリーキーを使って、ソートして主キーとそれぞれのカラム条件で検索する。



```mysql
+-------------+---------------+------+-----+---------+----------------+
| Field       | Type          | Null | Key | Default | Extra          |
+-------------+---------------+------+-----+---------+----------------+
| id          | int           | NO   | PRI | NULL    | auto_increment |
| create_date | date          | YES  |     | NULL    |                |
| url         | varchar(255)  | NO   |     | NULL    |                |
| comment     | varchar(1024) | NO   |     | NULL    |                |
+-------------+---------------+------+-----+---------+----------------+
```
上記だと、idが分からないと検索できない。

### ペケ回答2

3つの複合インデックスを諦めて、２つので行う。

```mysql
mysql> ALTER TABLE url_list ADD INDEX index1(create_date, url);
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SHOW INDEX url_list;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'url_list' at line 1
mysql> SHOW INDEX FROM url_list;
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| url_list |          1 | index1   |            1 | create_date | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| url_list |          1 | index1   |            2 | url         | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.00 sec)

```

もちろん３つのカラムを組み合わせた条件で検索して該当レコード特定することが目的なので、
完全に一致することができないが


```mysql
SELECT label FROM url_list WHERE create_date = '2021-01-01' AND url > 'https://wwww.google.com?hoge=1'
```

```mysql
SELECT label FROM url_list WHERE url > 'https://wwww.google.com?hoge=1' AND create_date = '2021-01-01'

```
```mysql
SELECT label FROM url_list WHERE url > 'https://wwww.google.com?hoge=1'

```

## 演習2

顧客管理画面でIDと氏名以外は、顧客によって任意の項目が自由に継ぎ足すことができるものとします。
上記を満たすテーブルを作りなさい。

### 各顧客データのカスタムイメージ

#### パターンA

|ID|氏名|email|phone|
|---|---|---|---|
|1|narumi|narumi@hoge.co.jp|08011112222|
|2|ninomiya|ninomiya@hoge.co.jp|08011113333|
|3|sasaki|sasaki@hoge.co.jp|08011113333|

#### パターンB

|ID|氏名|slacks|department|
|---|---|---|---|
|1|narumi|narumi@hoge.co.jp|operation|
|2|ninomiya|ninomiya@hoge.co.jp|fullstack|
|3|sasaki|sasaki@hoge.co.jp|frontend|


### 模範回答

以下の3つのテーブルを基礎とする

#### 1. 顧客テーブル
||||||||
|---|---|---|---|---|---|---|
||||||||

```mysql
mysql> CREATE TABLE customers
    -> (
    ->     id INT PRIMARY KEY AUTO_INCREMENT,
    ->     item1 VARCHAR(255),
    ->     item2 VARCHAR(255),
    ->     item3 VARCHAR(255),
    ->     item4 VARCHAR(255),
    ->     item5 VARCHAR(255),
    ->     item6 VARCHAR(255),
    ->     item7 VARCHAR(255),
    ->     item8 VARCHAR(255),
    ->     item9 VARCHAR(255),
    ->     item10 VARCHAR(255),
    ->     item11 VARCHAR(255),
    ->     item12 VARCHAR(255),
    ->     item13 VARCHAR(255),
    ->     item14 VARCHAR(255)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> DESC customers;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| item1  | varchar(255) | YES  |     | NULL    |                |
| item2  | varchar(255) | YES  |     | NULL    |                |
| item3  | varchar(255) | YES  |     | NULL    |                |
| item4  | varchar(255) | YES  |     | NULL    |                |
| item5  | varchar(255) | YES  |     | NULL    |                |
| item6  | varchar(255) | YES  |     | NULL    |                |
| item7  | varchar(255) | YES  |     | NULL    |                |
| item8  | varchar(255) | YES  |     | NULL    |                |
| item9  | varchar(255) | YES  |     | NULL    |                |
| item10 | varchar(255) | YES  |     | NULL    |                |
| item11 | varchar(255) | YES  |     | NULL    |                |
| item12 | varchar(255) | YES  |     | NULL    |                |
| item13 | varchar(255) | YES  |     | NULL    |                |
| item14 | varchar(255) | YES  |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
15 rows in set (0.00 sec)


mysql> CREATE TABLE customers_index
    -> (
    ->     id INT PRIMARY KEY,
    ->     string VARCHAR(255),
    ->     number BIGINT,
    ->     date DATE,
    ->     double_ DOUBLE
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> DESC customers_index;
+---------+--------------+------+-----+---------+-------+
| Field   | Type         | Null | Key | Default | Extra |
+---------+--------------+------+-----+---------+-------+
| id      | int          | NO   | PRI | NULL    |       |
| string  | varchar(255) | YES  |     | NULL    |       |
| number  | bigint       | YES  |     | NULL    |       |
| date    | date         | YES  |     | NULL    |       |
| double_ | double       | YES  |     | NULL    |       |
+---------+--------------+------+-----+---------+-------+
5 rows in set (0.00 sec)



```

#### 2. カラム情報テーブル

#### 3. 顧客INDEX
