#  テーブル操作 

## CREATE TABLE 


### 構文

```sql
CREATE TABLE テーブル名(
  フィールド名1 データ型 制約,
  フィールド名2 データ型 制約,
  フィールド名3 データ型 制約,
  フィールド名4 データ型 制約,
  ・・・
);

```

### 実例

```mysql
mysql> CREATE TABLE M_CARS(
    ->   no INT(3) NOT NULL,
    ->   name VARCHAR(30) NOT NULL,
    ->   manufacturer VARCHAR(30) NOT NULL,
    ->   PRIMARY KEY(no)
    -> );
Query OK, 0 rows affected, 1 warning (0.02 sec)

mysql> show tables;
+------------------+
| Tables_in_testdb |
+------------------+
| M_CARS           |
+------------------+
1 row in set (0.01 sec)

mysql> desc M_CARS;
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| no           | int         | NO   | PRI | NULL    |       |
| name         | varchar(30) | NO   |     | NULL    |       |
| manufacturer | varchar(30) | NO   |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)


```

```mysql
mysql> CREATE TABLE M_USERS(
    ->   no INT(5) PRIMARY KEY AUTO_INCREMENT,
    ->   lname VARCHAR(255) NOT NULL,
    ->   fname VARCHAR(255) NOT NULL,
    ->   age INT(3) NOT NULL,
    ->   sex VARCHAR(1)
    -> );
Query OK, 0 rows affected, 2 warnings (0.02 sec)

mysql> desc M_USERS;
+-------+--------------+------+-----+---------+----------------+
| Field | Type         | Null | Key | Default | Extra          |
+-------+--------------+------+-----+---------+----------------+
| no    | int          | NO   | PRI | NULL    | auto_increment |
| lname | varchar(255) | NO   |     | NULL    |                |
| fname | varchar(255) | NO   |     | NULL    |                |
| age   | int          | NO   |     | NULL    |                |
| sex   | varchar(1)   | YES  |     | NULL    |                |
+-------+--------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)


```


## CREATE INDEX 

### 構文


```sql
CREATE INDEX インデックス名 ON テーブル名（フィールド名1, [フィールド名2, ...]);

```

### 実例

```mysql
mysql> CREATE INDEX name_index on M_CARS(name);
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc M_CARS;
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| no           | int         | NO   | PRI | NULL    |       |
| name         | varchar(30) | NO   | MUL | NULL    |       |
| manufacturer | varchar(30) | NO   |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

```


## CREATE VIEW

### 構文


```sql
CREATE VIEW ビュー名 AS SELECT文

```


### 実例

```mysql
mysql> select * from M_USERS;
+----+-----------------+-----------------+-----+------+
| no | lname           | fname           | age | sex  |
+----+-----------------+-----------------+-----+------+
|  1 | オダ            | ノブナガ        |  20 | M    |
|  2 | オダ            | ノブユキ          |  19 | M    |
|  3 | シュウカマ      | マサコ          |  40 | F    |
|  4 | キバヤシ        | リョウスケ      |  34 | X    |
|  5 | カナメ          | リン            |  26 | F    |
+----+-----------------+-----------------+-----+------+
5 rows in set (0.00 sec)


mysql> CREATE VIEW V_MENS AS SELECT * FROM M_USERS WHERE sex='M';
Query OK, 0 rows affected (0.00 sec)

mysql> select * from V_MENS;
+----+-----------+--------------+-----+------+
| no | lname     | fname        | age | sex  |
+----+-----------+--------------+-----+------+
|  1 | オダ    | ノブナガ     |  20 | M    |
|  2 | オダ    | ノブユキ       |  19 | M    |
+----+-----------+--------------+-----+------+
2 rows in set (0.00 sec)

------------------+
| Tables_in_testdb |
+------------------+
| M_CARS           |
| M_USERS          |
| v_mens           |
+------------------+

mysql> desc V_MENS;
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| no    | int          | NO   |     | 0       |       |
| lname | varchar(255) | NO   |     | NULL    |       |
| fname | varchar(255) | NO   |     | NULL    |       |
| age   | int          | NO   |     | NULL    |       |
| sex   | varchar(1)   | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
5 rows in set (0.01 sec)
```


## DROP TABLE 

### 構文


```sql
DROP TABLE テーブル名
```
消したテーブルは元に戻せないので、慎重に実行してください。

### 実例

```mysql
mysql> show tables;
+------------------+
| Tables_in_testdb |
+------------------+
| M_CARS           |
| M_USERS          |
+------------------+
2 rows in set (0.00 sec)

mysql> DROP TABLE M_USERS;
Query OK, 0 rows affected (0.00 sec)

mysql> show tables;
+------------------+
| Tables_in_testdb |
+------------------+
| M_CARS           |
+------------------+
1 row in set (0.00 sec)

```


## TRUNCATE TABLE 

`TRUNCATE TABLE`文はテーブルの全てのレコードを削除します。  
条件の指定なし`DELETE`文と変わりませんが、この命令で削除したレコードはロールバックできません。

### 構文


```sql
TRUNCATE TABLE テーブル名;

```


### 実例

```mysql
mysql> SELECT * FROM M_USERS;
+----+-----------------+-----------------+-----+------+
| no | lname           | fname           | age | sex  |
+----+-----------------+-----------------+-----+------+
|  1 | オダ            | ノブナガ        |  20 | M    |
|  2 | オダ            | ノブユキ          |  19 | M    |
|  3 | シュウカマ      | マサコ          |  40 | F    |
|  4 | キバヤシ        | リョウスケ      |  34 | X    |
|  5 | カナメ          | リン            |  26 | F    |
+----+-----------------+-----------------+-----+------+
5 rows in set (0.00 sec)

mysql> TRUNCATE TABLE M_USERS;
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT * FROM M_USERS;
Empty set (0.00 sec)


```


## ALTER TABLE RENAME<br>(テーブル名の変更)

テーブルに変更を加えるには`ALTER TABLE`を追加います。テーブル名の変更、フィールドの追加、変更、削除などが行えます。


### 構文


```sql
ALTER TABLE テーブル名 RENAME 新テーブル名

```
### 実例

```mysql
mysql> show tables;
+------------------+
| Tables_in_testdb |
+------------------+
| M_CARS           |
| v_mens           |
| M_USERS          |
+------------------+
3 rows in set (0.00 sec)

mysql> ALTER TABLE M_USERS RENAME Y_USERS;
Query OK, 0 rows affected (0.01 sec)

mysql> show tables;
+------------------+
| Tables_in_testdb |
+------------------+
| M_CARS           |
| v_mens           |
| Y_USERS          |
+------------------+
3 rows in set (0.00 sec)

```


## ALTER TABLE ADD<br><br>(フィールドの追加)

### 構文

```sql
ALTER TABLE テーブル名 ADD フィールド名 データ型

```
### 実例

```mysql
mysql> select * from M_USERS;
+----+-----------------+-----------------+-----+------+
| no | lname           | fname           | age | sex  |
+----+-----------------+-----------------+-----+------+
|  1 | オダ            | ノブナガ        |  20 | M    |
|  2 | オダ            | ノブユキ          |  19 | M    |
|  3 | シュウカマ      | マサコ          |  40 | F    |
|  4 | キバヤシ        | リョウスケ      |  34 | X    |
|  5 | カナメ          | リン            |  26 | F    |
+----+-----------------+-----------------+-----+------+
5 rows in set (0.00 sec)

mysql> ALTER TABLE M_USERS ADD flg INT;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from M_USERS;
+----+-----------------+-----------------+-----+------+------+
| no | lname           | fname           | age | sex  | flg  |
+----+-----------------+-----------------+-----+------+------+
|  1 | オダ            | ノブナガ        |  20 | M    | NULL |
|  2 | オダ            | ノブユキ          |  19 | M    | NULL |
|  3 | シュウカマ      | マサコ          |  40 | F    | NULL |
|  4 | キバヤシ        | リョウスケ      |  34 | X    | NULL |
|  5 | カナメ          | リン            |  26 | F    | NULL |
+----+-----------------+-----------------+-----+------+------+
5 rows in set (0.00 sec)

mysql> desc M_USERS;
+-------+--------------+------+-----+---------+----------------+
| Field | Type         | Null | Key | Default | Extra          |
+-------+--------------+------+-----+---------+----------------+
| no    | int          | NO   | PRI | NULL    | auto_increment |
| lname | varchar(255) | NO   |     | NULL    |                |
| fname | varchar(255) | NO   |     | NULL    |                |
| age   | int          | NO   |     | NULL    |                |
| sex   | varchar(1)   | YES  |     | NULL    |                |
| flg   | int          | YES  |     | NULL    |                |
+-------+--------------+------+-----+---------+----------------+


```

## ALTER TABLE CHANGE<br>(フィールド名の変更)

### 構文

```sql
ALTER TABLE テーブル名 CHANGE フィールド名 新フィールド名

```
### 実例

```mysql
mysql> desc M_USERS;
+-------+--------------+------+-----+---------+----------------+
| Field | Type         | Null | Key | Default | Extra          |
+-------+--------------+------+-----+---------+----------------+
| no    | int          | NO   | PRI | NULL    | auto_increment |
| lname | varchar(255) | NO   |     | NULL    |                |
| fname | varchar(255) | NO   |     | NULL    |                |
| age   | int          | NO   |     | NULL    |                |
| sex   | varchar(1)   | YES  |     | NULL    |                |
| flg   | int          | YES  |     | NULL    |                |
+-------+--------------+------+-----+---------+----------------+

mysql> ALTER TABLE M_USERS CHANGE flg check_flg INT;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc M_USERS;
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| no        | int          | NO   | PRI | NULL    | auto_increment |
| lname     | varchar(255) | NO   |     | NULL    |                |
| fname     | varchar(255) | NO   |     | NULL    |                |
| age       | int          | NO   |     | NULL    |                |
| sex       | varchar(1)   | YES  |     | NULL    |                |
| check_flg | int          | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
6 rows in set (0.00 sec)


```

## ALTER TABLE MODIFY<br>(フィールドの変更)

### 構文

```sql
ALTER TABLE テーブル名 MODIFY フィールド名

```

### 実例

```mysql

mysql> desc M_USERS;
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| no        | int          | NO   | PRI | NULL    | auto_increment |
| lname     | varchar(255) | NO   |     | NULL    |                |
| fname     | varchar(255) | NO   |     | NULL    |                |
| age       | int          | NO   |     | NULL    |                |
| sex       | varchar(1)   | YES  |     | NULL    |                |
| check_flg | int          | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
6 rows in set (0.00 sec)

mysql> ALTER TABLE M_USERS MODIFY check_flg VARCHAR(1);
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> desc M_USERS;
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| no        | int          | NO   | PRI | NULL    | auto_increment |
| lname     | varchar(255) | NO   |     | NULL    |                |
| fname     | varchar(255) | NO   |     | NULL    |                |
| age       | int          | NO   |     | NULL    |                |
| sex       | varchar(1)   | YES  |     | NULL    |                |
| check_flg | varchar(1)   | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
6 rows in set (0.01 sec)


```


## ALTER TABLE DROP<br>(フィールドの削除)

### 構文

```sql
ALTER TABLE テーブル名 DROP フィールド名

```

### 実例

```mysql
mysql> desc M_USERS;
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| no        | int          | NO   | PRI | NULL    | auto_increment |
| lname     | varchar(255) | NO   |     | NULL    |                |
| fname     | varchar(255) | NO   |     | NULL    |                |
| age       | int          | NO   |     | NULL    |                |
| sex       | varchar(1)   | YES  |     | NULL    |                |
| check_flg | varchar(1)   | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+
6 rows in set (0.01 sec)

mysql> ALTER TABLE M_USERS DROP check_flg;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc M_USERS;
+-------+--------------+------+-----+---------+----------------+
| Field | Type         | Null | Key | Default | Extra          |
+-------+--------------+------+-----+---------+----------------+
| no    | int          | NO   | PRI | NULL    | auto_increment |
| lname | varchar(255) | NO   |     | NULL    |                |
| fname | varchar(255) | NO   |     | NULL    |                |
| age   | int          | NO   |     | NULL    |                |
| sex   | varchar(1)   | YES  |     | NULL    |                |
+-------+--------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)


```


