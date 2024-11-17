# データベースの追加

SQLを利用してデータベースやテーブル作成のクエリ操作を学習します。

## データベースの作成
`CREATE DATABASE`文を使ったデーターベースを作成方法


### 文法

```sql

CREATE DATABASE データベース名

```


### 作成例

以下順番に実行し、データベース名:`artdata`というデータベースを作成します。

#### 1. データベースの一覧を表示  

```sql
show databases;
```

```bash
'information_schema'
'innodb'
'mysql'
'performance_schema'
'sys'

```

```mysql
mysql> show tables;
+--------------------------------+
| Tables_in_personnel_infomation |
+--------------------------------+
| employee_information           |
| personnel_evaluation           |
| salary_infomation              |
| test                           |
+--------------------------------+
4 rows in set (0.01 sec)

mysql> show full tables;
+--------------------------------+------------+
| Tables_in_personnel_infomation | Table_type |
+--------------------------------+------------+
| employee_information           | BASE TABLE |
| personnel_evaluation           | BASE TABLE |
| salary_infomation              | BASE TABLE |
| test                           | BASE TABLE |
+--------------------------------+------------+
4 rows in set (0.01 sec)

```


#### 2. デーベースを作成  

```sql
CREATE DATABASE artdata;

```


#### 3. データベース作成済みを確認

```sql
show databases;
```

```
'information_schema'
'artdata'
'innodb'
'mysql'
'performance_schema'
'sys'

```


## データベースにおける基本的なデータ型
数値型、文字型、日付型などの基本的なデータ型について


### データ型とは？

データベースでは、テーブルの列（カラム）毎に型の属性を定めます。

MySQLでは基本的なデータ型を以下3つ定めます。

- 数値型
- 文字列型
- 日付型


### なぜ？データ型を定めなければならないのか？

データの型を指定しすることで、データの統一性に違反するデータを持たないようにするため。


### 数値型

#### 整数型

||データ型|値の範囲|UNSIGNED|ZEROFILL|
|:---:|:---:|---:|---:|---:|
|TYVYINT(m)|整数型<br>(1バイト)|-128〜127|0〜255|000〜255|
|SMALLINT(m)|整数型<br>(2バイト)|-32768〜32767|0〜65536|00000〜65736|
|MEDIUMINT(m)|整数型<br>(3バイト)|-8388608〜8388607|0〜16777215|00000000〜16777215|
|INT(m)|整数型<br>(4バイト)|-2147483648<br>〜<br>21473647|0<br>〜<br>4294967295|0000000000<br>〜<br>4294967295|
|BIGINT(m)|整数型<br>(8バイト)|-9223372036854775808<br>〜<br>9223372036854775807|0<br>〜<br>18446744073709551615|00000000000000000000<br>〜<br>18446744073709551615|

#### 浮動小数点型

||データ型|値の範囲|
|:---:|:---|---:|
|FLOAT|単精度浮動小数点型|-3.402823466E+38 〜 3.402823466E+308|
|DOUBLE|倍精度浮動小数点型|-1.7976931348623157E+308 〜 1.7976931348623157E+308|
|FLOAT(m,d)|単精度浮動小数点型|m: 1〜255桁<br>n: 0〜30桁まで指定可能|
|DOUBLE(m,d)|倍精度浮動小数点型|m: 1〜255桁<br>n: 0〜30桁まで指定可能|


### 文字列型

||データ型|値の範囲|
|:---:|:---|---:|
|CHAR(m)|固定帳文字型|m（文字数指定）: 0〜255文字|
|VARCHAR(m)|可変帳文字型|m（バイト数指定）: 0〜65535バイト|
|TYNYTEXTT|テキスト型|0〜255バイト（固定）|
|TEXT|テキスト型| 0〜65535バイト（固定）|
|MEDIUMTEXT|テキスト型|0〜16777215バイト（固定）|
|LONGTEXT|テキスト型|0〜4294967295バイト（固定）|


### 日付型

||データ型|値の範囲|備考|
|:---:|:---|---:||
|DATE|日付型|'YYY-MM-DD'||
|DATETIME|日付時刻型|'YYY-MM-DD HH:MM:SS'||
|TIMESTAMP|日付時刻型|'YYY-MM-DD HH:MM:SS'||
|TIME|時刻型|'HH:MM:SS'||
|YEAR[4]|日付型（4桁年）|'YYYY'|1901〜2155または、<br>0000が設定可能|
|YEAR[2]|日付型（2桁年）|'YY'|70〜69が設定可能<br>（1970〜2069）|


## テーブルの追加
`CREATE TABLE`文を使ったテーブルの作成方法


### 新規テーブルの作成

#### 文法

```sql

```

#### 1. 対象のデータベースに切り替える

```sql
use artdata;

```

#### 2. テーブルの一覧表示

```sql
show tables;

```

#### 3. テーブルの作成

```sql
CREATE TABLE artist(id int not null auto_increment primary key, name varchar(255) not null, category varchar(255));

```
#### 4. テーブル作成の成功を確認

```sql
show tables;

```

```
artist

```


## データベースの構造確認
テーブルの構造確認します。

```sql
show columns from artist;

```
```
Field		Type			Null	Key		Default		Extra
id			int(11)			NO		PRI		NULL		auto_increment
name		varchar(255)	NO				NULL
category	varchar(255)	YES				NULL

```


## テーブルの削除
`DROP TABEL`文を使ったテーブルの削除方法

### 文法

```sql
DROP TABLE テーブル名;

```

### 実行例


#### 1. テーブル一覧を表示

テーブル一覧を表示して対象のテーブルの存在を確認する

```sql
show tables;

```

#### 2. テーブルの削除

```sql

DROP TABLE artist;

```


#### 3. テーブル一覧を削除

テーブル一覧を表示して対象のテーブルが削除されていること確認する

```sql
show tables;

```


## データベースの削除

`DROP DATABASE`文を使ったデータベースの削除方法


### 文法


```sql
DROP DATABASE データベース名;

```


### 実行例



#### 1. データベースの一覧を表示

```sql
show databases;

```

```
# Database
artdata
information_schema
innodb
mysql
performance_schema
sys

```

#### 2. データベースの削除

```sql
DROP DATABASE artdata;

```

#### 3. データベース削除の確認

```sql
show databases;

```

データベースが削除されたこと確認します。

```
# Database
information_schema
innodb
mysql
performance_schema
sys

```

## まとめ

以下コマンドを実行方法を学びました。


- データベースの一覧表示

```
show databases;

```

- データベースの作成

```sql
CREATE DATABASE art_data;

```

- データベースの選択

```
use artdata;

```

- テーブルの作成

```sql
CREATE TABLE artist(id int not null auto_increment primary key, name varchar(255) not null, category varchar(255))

```

- テーブル一覧表示

```

show tables;
```

- テーブルのカラム情報を表示

```
show columns from artist;
```

- テーブルの削除

```sql

DROP TABLE artist;

```

- データベースの削除

```sql

DROP DATABASE art_data;

```
