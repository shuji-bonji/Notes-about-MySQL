#  その他 

## トランザクション 

データベースに対して行われる一つ以上の更新処理。トランザクションのおかげで更新処理の確定や取り消しが可能になります。

### 構文

- `START TRANSACTION` でトランザクションが開始
- `COMMIT`で確定
- `ROLLBACK`が取り消し



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

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO M_USERS VALUES(6, 'ハゲ', 'ウスダ', 30, 'M');
Query OK, 1 row affected (0.00 sec)

mysql> select * from M_USERS;
+----+-----------------+-----------------+-----+------+
| no | lname           | fname           | age | sex  |
+----+-----------------+-----------------+-----+------+
|  1 | オダ            | ノブナガ        |  20 | M    |
|  2 | オダ            | ノブユキ          |  19 | M    |
|  3 | シュウカマ      | マサコ          |  40 | F    |
|  4 | キバヤシ        | リョウスケ      |  34 | X    |
|  5 | カナメ          | リン            |  26 | F    |
|  6 | ハゲ            | ウスダ          |  30 | M    |
+----+-----------------+-----------------+-----+------+
6 rows in set (0.00 sec)

mysql> ROLLBACK;
Query OK, 0 rows affected (0.00 sec)

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


```


## 副問合せ 

副問い合わせは** `SELECT`文の結果を別のSQL分で利用すること** です。サブクエリとも呼ばれます。

### 構文


```sql
SELECT フィールド名 FROM(SELECT * FROM テーブル WHERE 条件 ) AS テーブル名 WHERE 条件

```


### 例

```mysql
SELECT field1 FROM table1 
  WHERE field2 = (SELECT field2 FROM table2 WHERE ...);

```

```mysql
INSERT INTO table1 (field1, field2) 
  SELECT field1, field2 FROM table2 WHERE ...);

```

## EXISTS 句 

`EXISTS`句は副問い合わせによって返されたレコードが存在すれば真、存在しなければ偽を返す仕組みです。

`NOT EXISTS` にすると逆の意味になります。

### 構文


```sql
SELECT フィールド名 FROM テーブル名 WHERE EXISTS( SELECT文);

SELECT フィールド名 FROM テーブル名 WHERE NOT EXISTS( SELECT文);
```


### 実例

```mysql

```




## 実行計画（EXPLANIN）


### 構文


```sql

```


### 実例

```mysql

```
