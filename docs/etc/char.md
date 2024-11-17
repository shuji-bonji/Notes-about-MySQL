# 文字コード

## 文字コード

utf8(1〜3バイト)やutf8mb4(1〜4バイト)、cp932など




## 文字コードの確認
```mysql
mysql> show variables like "chara%";
+--------------------------+-------------------------------------------+
| Variable_name            | Value                                     |
+--------------------------+-------------------------------------------+
| character_set_client     | latin1                                    |
| character_set_connection | latin1                                    |
| character_set_database   | utf8mb4                                   |
| character_set_filesystem | binary                                    |
| character_set_results    | latin1                                    |
| character_set_server     | latin1                                    |
| character_set_system     | utf8                                      |
| character_sets_dir       | /rdsdbbin/mysql-5.7.34.R5/share/charsets/ |
+--------------------------+-------------------------------------------+   
```
```mysql
mysql> show variables like '%char%';
+--------------------------+-------------------------------------------+
| Variable_name            | Value                                     |
+--------------------------+-------------------------------------------+
| character_set_client     | utf8mb4                                   |
| character_set_connection | utf8mb4                                   |
| character_set_database   | latin1                                    |
| character_set_filesystem | binary                                    |
| character_set_results    | utf8mb4                                   |
| character_set_server     | utf8mb4                                   |
| character_set_system     | utf8                                      |
| character_sets_dir       | /rdsdbbin/mysql-5.7.34.R5/share/charsets/ |
+--------------------------+-------------------------------------------+
8 rows in set (0.01 sec)

```

## 設定可能な文字コード一覧表示

```mysql
mysql> show character set;
+----------+---------------------------------+---------------------+--------+
| Charset  | Description                     | Default collation   | Maxlen |
+----------+---------------------------------+---------------------+--------+
| big5     | Big5 Traditional Chinese        | big5_chinese_ci     |      2 |
| dec8     | DEC West European               | dec8_swedish_ci     |      1 |
| cp850    | DOS West European               | cp850_general_ci    |      1 |
| hp8      | HP West European                | hp8_english_ci      |      1 |
| koi8r    | KOI8-R Relcom Russian           | koi8r_general_ci    |      1 |
| latin1   | cp1252 West European            | latin1_swedish_ci   |      1 |
| latin2   | ISO 8859-2 Central European     | latin2_general_ci   |      1 |
| swe7     | 7bit Swedish                    | swe7_swedish_ci     |      1 |
| ascii    | US ASCII                        | ascii_general_ci    |      1 |
| ujis     | EUC-JP Japanese                 | ujis_japanese_ci    |      3 |
| sjis     | Shift-JIS Japanese              | sjis_japanese_ci    |      2 |
| hebrew   | ISO 8859-8 Hebrew               | hebrew_general_ci   |      1 |
| tis620   | TIS620 Thai                     | tis620_thai_ci      |      1 |
| euckr    | EUC-KR Korean                   | euckr_korean_ci     |      2 |
| koi8u    | KOI8-U Ukrainian                | koi8u_general_ci    |      1 |
| gb2312   | GB2312 Simplified Chinese       | gb2312_chinese_ci   |      2 |
| greek    | ISO 8859-7 Greek                | greek_general_ci    |      1 |
| cp1250   | Windows Central European        | cp1250_general_ci   |      1 |
| gbk      | GBK Simplified Chinese          | gbk_chinese_ci      |      2 |
| latin5   | ISO 8859-9 Turkish              | latin5_turkish_ci   |      1 |
| armscii8 | ARMSCII-8 Armenian              | armscii8_general_ci |      1 |
| utf8     | UTF-8 Unicode                   | utf8_general_ci     |      3 |
| ucs2     | UCS-2 Unicode                   | ucs2_general_ci     |      2 |
| cp866    | DOS Russian                     | cp866_general_ci    |      1 |
| keybcs2  | DOS Kamenicky Czech-Slovak      | keybcs2_general_ci  |      1 |
| macce    | Mac Central European            | macce_general_ci    |      1 |
| macroman | Mac West European               | macroman_general_ci |      1 |
| cp852    | DOS Central European            | cp852_general_ci    |      1 |
| latin7   | ISO 8859-13 Baltic              | latin7_general_ci   |      1 |
| utf8mb4  | UTF-8 Unicode                   | utf8mb4_general_ci  |      4 |
| cp1251   | Windows Cyrillic                | cp1251_general_ci   |      1 |
| utf16    | UTF-16 Unicode                  | utf16_general_ci    |      4 |
| utf16le  | UTF-16LE Unicode                | utf16le_general_ci  |      4 |
| cp1256   | Windows Arabic                  | cp1256_general_ci   |      1 |
| cp1257   | Windows Baltic                  | cp1257_general_ci   |      1 |
| utf32    | UTF-32 Unicode                  | utf32_general_ci    |      4 |
| binary   | Binary pseudo charset           | binary              |      1 |
| geostd8  | GEOSTD8 Georgian                | geostd8_general_ci  |      1 |
| cp932    | SJIS for Windows Japanese       | cp932_japanese_ci   |      2 |
| eucjpms  | UJIS for Windows Japanese       | eucjpms_japanese_ci |      3 |
| gb18030  | China National Standard GB18030 | gb18030_chinese_ci  |      4 |
+----------+---------------------------------+---------------------+--------+
41 rows in set (0.00 sec)


```

## 文字コード設定

オプションファイルの指定を変更または追加します。

- Windowsの場合・・・「my.ini」
- Linuxの場合・・・「etc/my.cnf」

```mysql

```


## RDS上のMySQLの文字コード設定

1. AWSにログイン > Amazon RDS に移動 > パラメータグループを選択。
2. パラメータグループをクリック。
3. パラメータ一覧が表示されるので、以下のように変更  
```
character_set_client: utf8mb4
character_set_connection: utf8mb4
character_set_database: utf8mb4
character_set_results: utf8mb4
character_set_server: utf8mb4
innodb_large_prefix: 1
innodb_file_format: Barracuda
innodb_file_per_table: 1
skip-character-set-client-handshake: 1
init_connect:SET NAMES utf8mb4
```
4.  データベースの再起動


## テーブルを作るとき

テーブル内のデータをutf8mb4で格納するには、テーブル作成時のオプションで、CHRSETを`utf8mb4`で指定する。

- CHARSET=utf8mb4;

```mysql
mysql> DROP TABLE test;
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE test(
    ->     id INT(5) PRIMARY KEY AUTO_INCREMENT,
    ->     name VARCHAR(255) NOT NULL
    -> ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
Query OK, 0 rows affected (0.02 sec)

mysql> INSERT INTO test VALUES(1, 'はげ 禿げた');
Query OK, 1 row affected (0.01 sec)

mysql> select * from test;
+----+------------------+
| id | name             |
+----+------------------+
|  1 | はげ 禿げた      |
+----+------------------+
1 row in set (0.00 sec)

```


## テーブルの文字コードを確認

```mysql
mysql> show create table test;
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table | Create Table                                                                                                                                                               |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| test  | CREATE TABLE `test` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

```

## テーブルの文字コードを変更
```mysql

mysql> ALTER TABLE test CHARACTER SET utf8mb4;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> show create table test;
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table | Create Table                                                                                                                                                               |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| test  | CREATE TABLE `test` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 |
+-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.01 sec)

```


## データベースの文字コード
```mysql
mysql> show create database ecsite;
+----------+--------------------------------------------------------------------+
| Database | Create Database                                                    |
+----------+--------------------------------------------------------------------+
| ecsite   | CREATE DATABASE `ecsite` /*!40100 DEFAULT CHARACTER SET utf8mb4 */ |
+----------+--------------------------------------------------------------------+
1 row in set (0.01 sec)

```



## データベースの文字コードを変更

```mysql
mysql> show create database personnel_infomation;
+----------------------+---------------------------------------------------------------------------------+
| Database             | Create Database                                                                 |
+----------------------+---------------------------------------------------------------------------------+
| personnel_infomation | CREATE DATABASE `personnel_infomation` /*!40100 DEFAULT CHARACTER SET latin1 */ |
+----------------------+---------------------------------------------------------------------------------+
1 row in set (0.01 sec)

mysql> ALTER DATABASE personnel_infomation CHARACTER SET utf8mb4;
Query OK, 1 row affected (0.01 sec)

mysql> show create database personnel_infomation;
+----------------------+----------------------------------------------------------------------------------+
| Database             | Create Database                                                                  |
+----------------------+----------------------------------------------------------------------------------+
| personnel_infomation | CREATE DATABASE `personnel_infomation` /*!40100 DEFAULT CHARACTER SET utf8mb4 */ |
+----------------------+----------------------------------------------------------------------------------+
1 row in set (0.01 sec)



```