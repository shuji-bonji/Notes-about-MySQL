# データの追加と更新

SQLを利用してテーブルに対するデータの登録・更新・削除操作を学習します。

## データの追加（単数行レコードの追加方法）


### 文法

```sql
INSERT [INTO] table_name [(column_name [, column_name] ...)] { VALUES | VALUE } (value_list) [, value_ilst)] ...
```

または、以下のように記載します。  
こちらの方がわかりやすいです。

```sql
INSERT [INTO] table_name (column_name, column_name, ...)]{ VALUES (value1, value2, ...);
```

カラムの省略して追加する。

```sql
INSERT INTO table_name VALUES(value1, value2, ...);

```

### 実行例

#### 1. データーベースの作成

以下のようにデータベースを先に作成して、デフォルトのデータベースとして利用します。

```sql
CREATE DATABASE sales;

USE sales;

```


#### 2. テーブルの作成

以下を想定したテーブルを作成します。

- Users table
	- id : int (null禁止、自動採番、主キーの設定)
	- name : 20char limit
	- age : int型

|id|name|age|
|---|---|---|
||||
||||
||||


テーブルを作成します。

```sql
CREATE TABLE users(id int not null auto_increment primary key, name varchar(30), age int);

show tables;

```



実行結果（テーブルが作成されたこと確認します。）

```
users

```

念の為、カラム情報も確認します。

```
show columns from users;
```

実行結果

```
# Field	Type		Null	Key		Default	Extra
id		int(11)		NO		PRI				auto_increment
name	varchar(30)	YES			
age		int(11)		YES			


```


#### 3. 単一レコードの追加

以下を想定したレコードを追加します。

|id|name|age|
|---|---|---|
|1|Tkahashi|31|


以下を実行してレコードを追加します。

```sql
INSERT INTO users(id, name, age) VALUES(1, 'takahashi', 31);

```

以下のセレクト文を発行し、テーブルの内容を確認します。

```sql
SELECT * FROM users;

```

実行結果（レコードが追加されていること確認する）

```
# id	name		age
  1		takahashi	31

```

## データの追加（複数行レコードの追加方法）


### 文法

```sql
INSERT INTO table_name (column_name1, column_name2, ...) VALUES (value1, value2, ...), (value1, value2, ...), (value1, value2, ...);

```

カラムを省略した追加方法

```sql
INSERT INTO table_name VALUES (value1, value2, ...), (value1, value2, ...), (value1, value2, ...);

```

### 実行例

#### 1. 複数行レコードの追加

以下の想定にて、複数の行を追加します。

|id|name|age|
|---|---|---|
|1|Tkahashi|31|
|2|Suzki|37|
|3|Sato|21|


以下のコマンドにて実行し、二行のレコードを追加します。

```sql
INSERT INTO users VALUES
	(2, 'suzuki', 37),
	(3, 'sato', 21);

SELECT * FROM users;

```

実行結果（2行のレコードが追加されていること確認します。）

```
1	takahashi	31
2	suzuki		37
3	sato		21


```



### 課題

以下のテーブルを作成し、以下指定したデータを追加しましょう。

- item テーブル
  - id: int (null禁止、自動採番、主キーの設定)
  - item_name: 20char limit
  - price: int型


|id|item_name|price|
|---|---|---|
|1|TV||100,000|
|2|smartphone|8,000|
|3|camera|50,000|


#### 実行例

```sql
show databases;

use sales;

CREATE TABLE item(id int not null auto_increment primary key, item_name varchar(20), price int);

show tables;

```

実行結果

```
item
users


```

```sql
show columns from item;


```

実行結果

```
# Field		Type		Null	Key		Default		Extra
	id		int(11)		NO		PRI					auto_increment
	price	int(11)		YES			
item_name	varchar(20)	YES			
		
```


```sql
INSERT INTO item VALUES (1, 'TV', 100000),(2, 'smartphone', 80000),(3, 'camera', 50000);

SELECT * FROM item;


```

実行結果

```
# id	item_name	price
	1	TV			100000
	2	smartphone	80000
	3	camera		50000


```


## データ追加（カラムの追加）


### 文法


```sql
ALTER TABLE テーブル名 ADD カラム名 属性;

```

### 実行例

Userテーブルを以下のようにカラム（列）を追加します。


#### 更新前

|id|name|age| 
|---|---|---|
|1|Tkahashi|31|
|2|Suzki|37|
|3|Sato|21|

#### 更新後

|id|name|age|frequency|
|---|---|---|---------|
|1|Tkahashi|31|null|
|2|Suzki|37|null|
|3|Sato|21|null|


#### 1. データの確認

```sql
SHOW COLUMS FROM users;


```
実行結果

```
# Field	Type	Null	Key	Default	Extra
id	int(11)	NO	PRI		auto_increment
name	varchar(30)	YES			
age	int(11)	YES			
frequency	varchar(10)	YES			

```


#### 2. カラムの追加

```sql
ALTER TABLE users ADD frequency varchar(10) not null;
```

#### 3. テーブル情報の確認（カラム追加の確認）

```sql
SHOW COLUMS FROM users;

```

以下の`DESC`でも同じように確認できます。（MySQLでは、descはshow columnsと同等の機能のシノニム（別名）です。）

```sql
DESC users;

```

実行結果

```
# Field		Type		Null	Key		Default	Extra
id			int(11)		NO		PRI				auto_increment
name		varchar(30)	YES			
age			int(11)		YES			
frequency	varchar(10)	NO			

```


## データの更新（カラムへの一括更新）


### 文法

```sql
UPDATE テーブル名 SET カラム名 = 値;

```

### 実行例

#### 変更前

|id|name|age|frequency|
|---|---|---|---------|
|1|Tkahashi|31|null|
|2|Suzki|37|null|
|3|Sato|21|null|


#### 変更後

|id|name|age|frequency|
|---|---|---|---------|
|1|Tkahashi|31|stil|
|2|Suzki|37|stil|
|3|Sato|21|stil|


#### 1. データの確認

```sql
SELECT * FROM users;

```

実行結果

```
# id	name	age	frequency
1	takahashi	31	
2	suzuki	37	
3	sato	21	

```
#### 2. カラムの一括データ更新

```sql

UPDATE users SET frequency = stil;

```

!!!note
	```sql
	mysql -u root -p --safe-updates
	```	
	もしくは、`MySQL Workbench`の`Prefarence`>`SQL Editor`>`Safe Updates`のチェックを外して、`MySQL Workbench`から接続し直してください。

#### 3. データの確認（更新後）


```sql
SELECT * FROM users;

```

```
# id	name	age	frequency
1	takahashi	31	stil
2	suzuki	37	stil
3	sato	21	stil



```

## データの更新（条件をして更新）

### 文法

```sql
UPDATE テーブル名 SET カラム名 = 値 WHERE 条件;

```


### 更新例

#### 変更前

|id|name|age|frequency|
|---|---|---|---------|
|1|Tkahashi|31|stil|
|2|Suzki|37|stil|
|3|Sato|21|stil|

#### 変更後

|id|name|age|frequency|
|---|---|---|---------|
|1|Tkahashi|32|stil|
|2|Suzki|37|stil|
|3|Sato|21|stil|



#### 1. テーブルデータの確認（更新前）
```sql
SELECT * FROM users;

```

実行結果

```
# id	name	age	frequency
1	takahashi	31	stil
2	suzuki	37	stil
3	sato	21	stil
```

#### 2. データの更新（条件）

```sql
UPDATE users SET age = 32 WHERE id = 1;

```

#### 3. テーブルデータの確認（更新後）

```sql
SELECT * FROM users;

```

実行結果

```
# id	name	age	frequency
1	takahashi	32	stil
2	suzuki	37	stil
3	sato	21	stil

```


### 課題


#### 変更前

|id|name|age|frequency|
|---|---|---|---------|
|1|Tkahashi|32|stil|
|2|Suzki|37|stil|
|3|Sato|21|stil|

#### 変更後

|id|name|age|frequency|
|---|---|---|---------|
|1|Tkahashi|32|repeater|
|2|Suzki|37|stil|
|3|Sato|21|stil|


#### 実行例

```sql
SELECT * FROM users;

UPDATE users SET frequency = 'repeater' WHERE id = 1;

SELECT * FROM users;

```


## データの削除（テーブルデータの全てを削除）


### 文法

```sql
DELETE FROM テーブル名;

```

### 実行例

#### 変更前

|id|name|age|frequency|
|---|---|---|---------|
|1|Tkahashi|32|stil|
|2|Suzki|37|infrequent|
|3|Sato|21|stil|

#### 変更後

|id|name|age|frequency|
|---|---|---|---------|
|1|Tkahashi|32|repeater|
|3|Sato|21|stil|


#### 1. データの確認（実行前）

```sql
SELECT * FROM users;
```

実行結果

```
# id	name	age	frequency
1	takahashi	32	repeater
2	suzuki	37	infrequent
3	sato	21	stil

```

#### 1. レコードの削除

```sql
UPDATE users SET frequency = 'infrequent' WHERE id = 2;

```

#### 1. データの確認（実行前）

```sql
SELECT * FROM users;

```

実行結果

```
# id	name	age	frequency
1	takahashi	32	repeater
3	sato	21	stil


```




## データの削除（条件に一致した全てのレコードを削除）

### 文法

```sql
DELETE FROM テーブル名 WHERE 条件;

```

### 実行例

#### 変更前


#### 変更後



## データの削除（条件に一致したデータをソートした後に数を指定して削除）

### 文法


```sql
DELETE FROM テーブル名 WHERE 条件 ORDER BY カラム名 [ASC|DESC] limet 数;

```

### 実行例

#### 変更前

#### 変更後


## DROP、TRUNCATE、DELETE

### DROP

テーブルと、デーブル内のオブジェクトを完全に削除

#### 文法

```sql
DROP TALBE テーブル名;

```


### TRUNCATE

テーブル内のレコードを完全に削除する。  
（オートインクリメントはリセットされる。）

#### 文法

```sql
TRUNCATE TABLE テーブル名;
```


### DELETE

テーブル内のデータを全削除または条件に一致したデータを削除する  
（オートインクリメントはリセットされない）

#### 文法

```sql
DELETE FROM テーブル名 WHERE 条件;

```