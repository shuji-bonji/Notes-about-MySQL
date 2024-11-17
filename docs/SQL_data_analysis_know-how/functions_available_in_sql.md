# SQLで利用できる関数

数値計算や合計値の算出などの簡単な演算や統計を実施する方法を学習します。


## 基本的な演算式


### 四則演算

- `+`、`-`、`*`、`/`、`%` の計算
- `DIV`  
  `A DIV B`: AからBで割った整数のみを表示
- `MOD`  
  `A MOD B`: AからBで割った余りを表示`%`と同じ

```mysql
SELECT 1 + 2;
mysql> SELECT 1 + 2;
+-------+
| 1 + 2 |
+-------+
|     3 |
+-------+
1 row in set (0.01 sec)

mysql> SELECT 1 - 2;
+-------+
| 1 - 2 |
+-------+
|    -1 |
+-------+
1 row in set (0.01 sec)

mysql> SELECT 1 * 2;
+-------+
| 1 * 2 |
+-------+
|     2 |
+-------+
1 row in set (0.01 sec)

mysql> SELECT 1 / 2;
+--------+
| 1 / 2  |
+--------+
| 0.5000 |
+--------+
1 row in set (0.01 sec)

mysql> SELECT 1 DIV 2;
+---------+
| 1 DIV 2 |
+---------+
|       0 |
+---------+
1 row in set (0.01 sec)

mysql> SELECT 1 % 2;
+-------+
| 1 % 2 |
+-------+
|     1 |
+-------+
1 row in set (0.01 sec)

mysql> SELECT 1 MOD 2;
+---------+
| 1 MOD 2 |
+---------+
|       1 |
+---------+
1 row in set (0.01 sec)

```

```mysql
mysql> SELECT id, order_id, id + order_id AS sum_id FROM order_details WHERE id = 9;
+----+----------+--------+
| id | order_id | sum_id |
+----+----------+--------+
|  9 |        4 |     13 |
+----+----------+--------+
1 row in set (0.01 sec)

mysql> SELECT id, order_id, id MOD order_id AS sum_id FROM order_details WHERE id = 9;
+----+----------+--------+
| id | order_id | sum_id |
+----+----------+--------+
|  9 |        4 |      1 |
+----+----------+--------+
1 row in set (0.01 sec)

```


### 数値に関する基本関数

- ABS()  
  `ABS(A)`: Aの絶対値を算出する
- ROUND()  
  `ROUND(A)`: Aを四捨五入する
- CEILING  
  `CEILING(A)`: A以上の最小の整数を取得する
- FLOOR  
  `FLOOR(A)`: A以下の最大の整数を取得する
- TRANCATE  
  `TRANCATE(A,2`: Xを小数点2桁の位置で切り捨てた値を取得する

```mysql

mysql> SELECT ABS(-10);
+----------+
| ABS(-10) |
+----------+
|       10 |
+----------+
1 row in set (0.01 sec)

mysql> SELECT ABS(10);
+---------+
| ABS(10) |
+---------+
|      10 |
+---------+
1 row in set (0.00 sec)

mysql> SELECT ROUND(2.4);
+------------+
| ROUND(2.4) |
+------------+
|          2 |
+------------+
1 row in set (0.01 sec)

mysql> SELECT CEILING(2.4);
+--------------+
| CEILING(2.4) |
+--------------+
|            3 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT FLOOR(2.4);
+------------+
| FLOOR(2.4) |
+------------+
|          2 |
+------------+
1 row in set (0.01 sec)

mysql> SELECT TRUNCATE(1.0384, 2);
+---------------------+
| TRUNCATE(1.0384, 2) |
+---------------------+
|                1.03 |
+---------------------+
1 row in set (0.00 sec)


```

## 集計関数

- COUNT  
  `OUCNT(指定列)`: 範囲列内のデータ数を算出
- SUM  
  `SUM(指定列)`: 指定列内データの合計を算出 
- AVG  
  `AVG(指定列)`: 指定列内データの平均を算出
- MIN  
  `MIN(指定列)`: 指定列内データの最小値を算出
- MAX  
  `MAX(指定列)`: 指定列内データの最大値を算出


### COUNT

```mysql
mysql> SELECT * FROM order_details WHERE product_id = 9;
+-----+----------+------------+--------+----------------------------+----------------------------+
| id  | order_id | product_id | amount | created_at                 | updated_at                 |
+-----+----------+------------+--------+----------------------------+----------------------------+
|   9 |        4 |          9 |      3 | 2020-04-07 04:33:58.726347 | 2020-04-07 04:33:58.726347 |
|  18 |        7 |          9 |      2 | 2020-04-07 04:33:58.761660 | 2020-04-07 04:33:58.761660 |
|  27 |       10 |          9 |      2 | 2020-04-07 04:33:58.793428 | 2020-04-07 04:33:58.793428 |
|  36 |       14 |          9 |      1 | 2020-04-07 04:33:58.826522 | 2020-04-07 04:33:58.826522 |
|  45 |       19 |          9 |      3 | 2020-04-07 04:33:58.872849 | 2020-04-07 04:33:58.872849 |
|  54 |       22 |          9 |      2 | 2020-04-07 04:33:58.907436 | 2020-04-07 04:33:58.907436 |
|  63 |       28 |          9 |      3 | 2020-04-07 04:33:58.947244 | 2020-04-07 04:33:58.947244 |
|  72 |       32 |          9 |      3 | 2020-04-07 04:33:58.987965 | 2020-04-07 04:33:58.987965 |
|  81 |       36 |          9 |      1 | 2020-04-07 04:33:59.037903 | 2020-04-07 04:33:59.037903 |
.....
| 522 |      261 |          9 |      2 | 2020-04-07 04:34:00.920988 | 2020-04-07 04:34:00.920988 |
| 531 |      265 |          9 |      1 | 2020-04-07 04:34:00.960367 | 2020-04-07 04:34:00.960367 |
| 540 |      273 |          9 |      1 | 2020-04-07 04:34:01.010080 | 2020-04-07 04:34:01.010080 |
| 549 |      277 |          9 |      3 | 2020-04-07 04:34:01.057458 | 2020-04-07 04:34:01.057458 |
| 558 |      280 |          9 |      1 | 2020-04-07 04:34:01.088610 | 2020-04-07 04:34:01.088610 |
| 567 |      284 |          9 |      2 | 2020-04-07 04:34:01.120321 | 2020-04-07 04:34:01.120321 |
| 576 |      290 |          9 |      3 | 2020-04-07 04:34:01.158766 | 2020-04-07 04:34:01.158766 |
| 585 |      293 |          9 |      3 | 2020-04-07 04:34:01.201492 | 2020-04-07 04:34:01.201492 |
| 594 |      297 |          9 |      2 | 2020-04-07 04:34:01.233840 | 2020-04-07 04:34:01.233840 |
+-----+----------+------------+--------+----------------------------+----------------------------+
66 rows in set (0.01 sec)

mysql> SELECT COUNT(amount) FROM order_details WHERE product_id = 9;
+---------------+
| COUNT(amount) |
+---------------+
|            66 |
+---------------+
1 row in set (0.01 sec)

mysql> SELECT COUNT(DISTINCT amount) FROM order_details WHERE product_id = 9;
+------------------------+
| COUNT(DISTINCT amount) |
+------------------------+
|                      3 |
+------------------------+
1 row in set (0.01 sec)

mysql> SELECT amount FROM order_details WHERE product_id = 9 GROUP BY amount;
+--------+
| amount |
+--------+
|      1 |
|      2 |
|      3 |
+--------+
3 rows in set (0.01 sec)

```

### SUM

```mysql

mysql> SELECT SUM(amount) FROM order_details WHERE product_id = 9;
+-------------+
| SUM(amount) |
+-------------+
|         136 |
+-------------+
1 row in set (0.01 sec)

mysql> SELECT SUM(amount) FROM order_details WHERE product_id = 9 GROUP BY amount;
+-------------+
| SUM(amount) |
+-------------+
|          20 |
|          44 |
|          72 |
+-------------+
3 rows in set (0.00 sec)


```

### AVG

```mysql
mysql> SELECT AVG(amount) FROM order_details WHERE product_id = 9;
+-------------+
| AVG(amount) |
+-------------+
|      2.0606 |
+-------------+
1 row in set (0.01 sec)

mysql> SELECT AVG(amount) AS avg_amount, SUM(amount) AS sum_amount FROM order_details WHERE product_id = 9;
+------------+------------+
| avg_amount | sum_amount |
+------------+------------+
|     2.0606 |        136 |
+------------+------------+
1 row in set (0.01 sec)

mysql> SELECT AVG(amount) AS avg_amount, SUM(amount) AS sum_amount FROM order_details WHERE product_id = 9 GROUP BY amount;
+------------+------------+
| avg_amount | sum_amount |
+------------+------------+
|     1.0000 |         20 |
|     2.0000 |         44 |
|     3.0000 |         72 |
+------------+------------+
3 rows in set (0.00 sec)

```

### MAX

```mysql
mysql> SELECT MAX(price) FROM products;
+------------+
| MAX(price) |
+------------+
|        698 |
+------------+
1 row in set (0.00 sec)

mysql> SELECT id, name, MAX(price) FROM products;
+----+--------------+------------+
| id | name         | MAX(price) |
+----+--------------+------------+
|  1 | Water cooker |        698 |
+----+--------------+------------+
1 row in set (0.01 sec)


mysql> SELECT * FROM products WHERE price = (SELECT MAX(price) FROM products);
+----+--------------+-------+----------------------------+----------------------------+
| id | name         | price | created_at                 | updated_at                 |
+----+--------------+-------+----------------------------+----------------------------+
|  5 | Refrigerator |   698 | 2020-04-07 04:33:58.210542 | 2020-04-07 04:33:58.210542 |
+----+--------------+-------+----------------------------+----------------------------+
1 row in set (0.01 sec)


mysql> SELECT * FROM products ORDER BY price DESC LIMIT 1;
+----+--------------+-------+----------------------------+----------------------------+
| id | name         | price | created_at                 | updated_at                 |
+----+--------------+-------+----------------------------+----------------------------+
|  5 | Refrigerator |   698 | 2020-04-07 04:33:58.210542 | 2020-04-07 04:33:58.210542 |
+----+--------------+-------+----------------------------+----------------------------+
1 row in set (0.01 sec)

```

### MIN

```mysql

mysql> SELECT id, name, MIN(price) FROM products;
+----+--------------+------------+
| id | name         | MIN(price) |
+----+--------------+------------+
|  1 | Water cooker |          5 |
+----+--------------+------------+
1 row in set (0.01 sec)


mysql> SELECT * FROM products WHERE price = (SELECT MIN(price) FROM products);
+----+-----------+-------+----------------------------+----------------------------+
| id | name      | price | created_at                 | updated_at                 |
+----+-----------+-------+----------------------------+----------------------------+
|  8 | Mousetrap |     5 | 2020-04-07 04:33:58.216274 | 2020-04-07 04:33:58.216274 |
+----+-----------+-------+----------------------------+----------------------------+
1 row in set (0.00 sec)

mysql> SELECT * FROM products ORDER BY price LIMIT 1;
+----+-----------+-------+----------------------------+----------------------------+
| id | name      | price | created_at                 | updated_at                 |
+----+-----------+-------+----------------------------+----------------------------+
|  8 | Mousetrap |     5 | 2020-04-07 04:33:58.216274 | 2020-04-07 04:33:58.216274 |
+----+-----------+-------+----------------------------+----------------------------+
1 row in set (0.01 sec)

```


## 文字列に関する関数

- CONCAT  
  `CONCAT('A', 'B')`: 文字列AとBを連結する 
- LOWER  
  `LOWER('AAA')`: 文字列AAAを全て小文字にする
- UPPER  
  `UPPER('aaa')`: 文字列aaaを全て大文字にする
- REPLACE  
  `REPLACE('abc', 'a', 'A')`: 文字列abcのaをAに置き換える 
- INSERT  
  `INSERT('abcde', 1, 2, 'xy')`: 文字列abcdeの1文字から2文字目をxyに置き換える 
- LPAD  
  `LPAD('ab', 6, 'A')`: 文字列abが6文字になるように左側をAで埋める
- RPAD  
  `RPAD('ab', 6, 'A')`: 文字列abが6文字になるように右側をAで埋める
- REPEAT  
  `REPEAT('OK',5)`: 文字列OKを5回繰り返す 
- LEFT  
  `LEFT('aaaa', 3)`: 文字列aaaaの中から指定した3文字だけ左から取得する
- RIGHT  
  `RIGHT('aaaa', 3)`: 文字列aaaaの中から指定した3文字だけ右から取得する
- SUBSTRING  
  `SUBSTRING('aaaa', 2, 3)`: 文字列aaaaの中から、２文字目から3文字を取得する 
- SUBSTRING_INDEX  
  `SUBSTRING_INDEX('ab.cs.html', '.', '2')`: 文字列ab.cd.htmlの中から、. が2番目に出てきた時点から、前の文字を取得する
- TRIM  
  `TRIM(' ABC')`: 文字列' ABC'から空白を除去する
- SPACE  
  `SPACE(5)`: スペースを５バイト分取得する
- LENGTH  
  `LENGTH('A')`: 文字列Aの文字数（バイト数）を数える
- CHAR_LENGTH  
  `CHAR_LENGTH('A')`: 文字列Aの文字数単位で数える

### CONCAT

```mysql
mysql> SELECT CONCAT('A', 'B', 'C');
+-----------------------+
| CONCAT('A', 'B', 'C') |
+-----------------------+
| ABC                   |
+-----------------------+
1 row in set (0.00 sec)


mysql> SELECT CONCAT('A', ' ', 'C');
+-----------------------+
| CONCAT('A', ' ', 'C') |
+-----------------------+
| A C                   |
+-----------------------+
1 row in set (0.01 sec)


mysql> SELECT CONCAT(name,' ', birthday) FROM users;
+---------------------------------+
| CONCAT(name,' ', birthday)      |
+---------------------------------+
| Erin Casper 1976-04-20          |
| Sudie Waelchi 1999-07-24        |
| Desire Osinski Sr. 2002-03-09   |
| Roy Yundt Jr. 1994-06-16        |
| Golden Kunde 1998-05-02         |
....
| Augustine Cassin 1997-07-08     |
| Velva Nolan 2001-11-26          |
| Maurice Koss 1987-03-25         |
| Domingo Herman 1981-02-28       |
| Barton Stracke 1995-03-24       |
+---------------------------------+
100 rows in set (0.01 sec)

```


### LOWER

```mysql

mysql> SELECT LOWER('AAA');
+--------------+
| LOWER('AAA') |
+--------------+
| aaa          |
+--------------+
1 row in set (0.01 sec)

mysql> SELECT LOWER(name) FROM users;
+----------------------+
| LOWER(name)          |
+----------------------+
| erin casper          |
| sudie waelchi        |
| desire osinski sr.   |
......
| pablo huels jr.      |
| leonardo turner      |
| augustine cassin     |
| velva nolan          |
| maurice koss         |
| domingo herman       |
| barton stracke       |
+----------------------+
100 rows in set (0.01 sec)

```


### UPPER

```mysql


mysql> SELECT UPPER('aaa');
+--------------+
| UPPER('aaa') |
+--------------+
| AAA          |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT UPPER(name) FROM users;
+----------------------+
| UPPER(name)          |
+----------------------+
| ERIN CASPER          |
| SUDIE WAELCHI        |
| DESIRE OSINSKI SR.   
|...
| VELVA NOLAN          |
| MAURICE KOSS         |
| DOMINGO HERMAN       |
| BARTON STRACKE       |
+----------------------+
100 rows in set (0.00 sec)


```

### REPRACE

```mysql
mysql> SELECT REPLACE('abc', 'a', 'A');
+--------------------------+
| REPLACE('abc', 'a', 'A') |
+--------------------------+
| Abc                      |
+--------------------------+
1 row in set (0.01 sec)

mysql> SELECT REPLACE(name, 'a', 'A') FROM users;
+-------------------------+
| REPLACE(name, 'a', 'A') |
+-------------------------+
| Erin CAsper             |
| Sudie WAelchi           |
| Desire Osinski Sr.      |
| Roy Yundt Jr.           |
| Golden Kunde            |
| ThAddeus Ledner         |
....
| PAblo Huels Jr.         |
| LeonArdo Turner         |
| Augustine CAssin        |
| VelvA NolAn             |
| MAurice Koss            |
| Domingo HermAn          |
| BArton StrAcke          |
+-------------------------+
100 rows in set (0.01 sec)

```


### INSERT

```mysql
mysql> SELECT INSERT('abcde', 1, 2, 'xy');
+-----------------------------+
| INSERT('abcde', 1, 2, 'xy') |
+-----------------------------+
| xycde                       |
+-----------------------------+
1 row in set (0.01 sec)


mysql> SELECT INSERT(name, 1, 4, 'AAAA') FROM users;
+----------------------------+
| INSERT(name, 1, 4, 'AAAA') |
+----------------------------+
| AAAA Casper                |
| AAAAe Waelchi              |
| AAAAre Osinski Sr.         |
| AAAAYundt Jr.              |
| AAAAen Kunde               |
.......
| AAAAya Luettgen            |
| AAAAo Huels Jr.            |
| AAAAardo Turner            |
| AAAAstine Cassin           |
| AAAAa Nolan                |
| AAAAice Koss               |
| AAAAngo Herman             |
| AAAAon Stracke             |
+----------------------------+
100 rows in set (0.00 sec)


```


### LPAD

```mysql
mysql> SELECT LPAD('ab', 6, 'A');
+--------------------+
| LPAD('ab', 6, 'A') |
+--------------------+
| AAAAab             |
+--------------------+
1 row in set (0.01 sec)


mysql> SELECT LPAD(name, 30, 'A') FROM users;
+--------------------------------+
| LPAD(name, 30, 'A')            |
+--------------------------------+
| AAAAAAAAAAAAAAAAAAAErin Casper |
| AAAAAAAAAAAAAAAAASudie Waelchi |
| AAAAAAAAAAAADesire Osinski Sr. |
| AAAAAAAAAAAAAAAAARoy Yundt Jr. |
| AAAAAAAAAAAAAAAAAAGolden Kunde |
| AAAAAAAAAAAAAAAThaddeus Ledner |
......
| AAAAAAAAAAAAAAALeonardo Turner |
| AAAAAAAAAAAAAAAugustine Cassin |
| AAAAAAAAAAAAAAAAAAAVelva Nolan |
| AAAAAAAAAAAAAAAAAAMaurice Koss |
| AAAAAAAAAAAAAAAADomingo Herman |
| AAAAAAAAAAAAAAAABarton Stracke |
+--------------------------------+
100 rows in set (0.01 sec)

```

#### RPAD
```mysql
mysql> SELECT RPAD('ab', 6, 'A');
+--------------------+
| RPAD('ab', 6, 'A') |
+--------------------+
| abAAAA             |
+--------------------+
1 row in set (0.00 sec)

ysql> SELECT RPAD(name, 30, 'A') FROM users;
+--------------------------------+
| RPAD(name, 30, 'A')            |
+--------------------------------+
| Erin CasperAAAAAAAAAAAAAAAAAAA |
| Sudie WaelchiAAAAAAAAAAAAAAAAA |
| Desire Osinski Sr.AAAAAAAAAAAA |
| Roy Yundt Jr.AAAAAAAAAAAAAAAAA |
| Golden KundeAAAAAAAAAAAAAAAAAA |
| Thaddeus LednerAAAAAAAAAAAAAAA |
.....
| Soraya LuettgenAAAAAAAAAAAAAAA |
| Pablo Huels Jr.AAAAAAAAAAAAAAA |
| Leonardo TurnerAAAAAAAAAAAAAAA |
| Augustine CassinAAAAAAAAAAAAAA |
| Velva NolanAAAAAAAAAAAAAAAAAAA |
| Maurice KossAAAAAAAAAAAAAAAAAA |
| Domingo HermanAAAAAAAAAAAAAAAA |
| Barton StrackeAAAAAAAAAAAAAAAA |
+--------------------------------+
100 rows in set (0.00 sec)

```

### SELECT REPEAT

```mysql
mysql> SELECT REPEAT('OK', 3);
+-----------------+
| REPEAT('OK', 3) |
+-----------------+
| OKOKOK          |
+-----------------+
1 row in set (0.01 sec)

mysql> SELECT REPEAT(name, 2) FROM users;
+------------------------------------------+
| REPEAT(name, 2)                          |
+------------------------------------------+
| Erin CasperErin Casper                   |
| Sudie WaelchiSudie Waelchi               |
| Desire Osinski Sr.Desire Osinski Sr.     |
| Roy Yundt Jr.Roy Yundt Jr.               |
| Golden KundeGolden Kunde                 |
| Thaddeus LednerThaddeus Ledner           |
| Miss Rudy VonRuedenMiss Rudy VonRueden   |
......
| Augustine CassinAugustine Cassin         |
| Velva NolanVelva Nolan                   |
| Maurice KossMaurice Koss                 |
| Domingo HermanDomingo Herman             |
| Barton StrackeBarton Stracke             |
+------------------------------------------+
100 rows in set (0.01 sec)


```

### LENGTH

```mysql
mysql> SELECT LENGTH('abcd');
+----------------+
| LENGTH('abcd') |
+----------------+
|              4 |
+----------------+
1 row in set (0.01 sec)

mysql> SELECT LENGTH('日本語');
+---------------------+
| LENGTH('日本語')    |
+---------------------+
|                   9 |
+---------------------+
1 row in set (0.00 sec)

mysql> SELECT name, LENGTH(name) FROM users;
+----------------------+--------------+
| name                 | LENGTH(name) |
+----------------------+--------------+
| Erin Casper          |           11 |
| Sudie Waelchi        |           13 |
| Desire Osinski Sr.   |           18 |
| Roy Yundt Jr.        |           13 |
| Golden Kunde         |           12 |
........
| Soraya Luettgen      |           15 |
| Pablo Huels Jr.      |           15 |
| Leonardo Turner      |           15 |
| Augustine Cassin     |           16 |
| Velva Nolan          |           11 |
| Maurice Koss         |           12 |
| Domingo Herman       |           14 |
| Barton Stracke       |           14 |
+----------------------+--------------+

```

### CHAR_LENGTH

```mysql
mysql> SELECT CHAR_LENGTH('abcd');
+---------------------+
| CHAR_LENGTH('abcd') |
+---------------------+
|                   4 |
+---------------------+
1 row in set (0.01 sec)

mysql> SELECT CHAR_LENGTH('日本語');
+--------------------------+
| CHAR_LENGTH('日本語')    |
+--------------------------+
|                        3 |
+--------------------------+
1 row in set (0.01 sec)

mysql> SELECT name, CHAR_LENGTH(name) FROM users;
+----------------------+-------------------+
| name                 | CHAR_LENGTH(name) |
+----------------------+-------------------+
| Erin Casper          |                11 |
| Sudie Waelchi        |                13 |
| Desire Osinski Sr.   |                18 |
| Roy Yundt Jr.        |                13 |
.....
| Pablo Huels Jr.      |                15 |
| Leonardo Turner      |                15 |
| Augustine Cassin     |                16 |
| Velva Nolan          |                11 |
| Maurice Koss         |                12 |
| Domingo Herman       |                14 |
| Barton Stracke       |                14 |
+----------------------+-------------------+
100 rows in set (0.01 sec)

```


## 日付と時刻に関する関数

```mysql
mysql> SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();
+----------------+----------------+---------------------+
| CURRENT_DATE() | CURRENT_TIME() | CURRENT_TIMESTAMP() |
+----------------+----------------+---------------------+
| 2021-08-05     | 02:35:54       | 2021-08-05 02:35:54 |
+----------------+----------------+---------------------+
1 row in set (0.00 sec)

```

```mysql
mysql> CREATE TABLE simpleid(
    ->     id INT(15),
    ->     created_at TIMESTAMP DEFAULT NOW()
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> DESC simpleid;
+------------+-----------+------+-----+-------------------+-------+
| Field      | Type      | Null | Key | Default           | Extra |
+------------+-----------+------+-----+-------------------+-------+
| id         | int(15)   | YES  |     | NULL              |       |
| created_at | timestamp | YES  |     | CURRENT_TIMESTAMP |       |
+------------+-----------+------+-----+-------------------+-------+
2 rows in set (0.01 sec)

mysql> INSERT INTO simpleid(id) VALUES(1);
Query OK, 1 row affected (0.02 sec)

mysql> SELECT * FROM simpleid;
+------+---------------------+
| id   | created_at          |
+------+---------------------+
|    1 | 2021-08-05 02:38:01 |
+------+---------------------+
1 row in set (0.01 sec)

```

### NOW()

```mysql

mysql> SELECT NOW();
+---------------------+
| NOW()               |
+---------------------+
| 2021-08-06 00:21:10 |
+---------------------+
1 row in set (0.01 sec)

```

### DATEDIFF

```mysql
mysql> SELECT DATEDIFF('2020-11-30', '2020-01-20');
+--------------------------------------+
| DATEDIFF('2020-11-30', '2020-01-20') |
+--------------------------------------+
|                                  315 |
+--------------------------------------+
1 row in set (0.01 sec)

```


### DAYNAME

```mysql
mysql> SELECT DAYNAME('2020-10-12');
+-----------------------+
| DAYNAME('2020-10-12') |
+-----------------------+
| Monday                |
+-----------------------+
1 row in set (0.00 sec)
```


### MONTH

```mysql
mysql> SELECT MONTH('2020-10-12');
+---------------------+
| MONTH('2020-10-12') |
+---------------------+
|                  10 |
+---------------------+
1 row in set (0.01 sec)
```


### YEAR

```mysql
mysql> SELECT YEAR('2020-10-12');
+--------------------+
| YEAR('2020-10-12') |
+--------------------+
|               2020 |
+--------------------+
1 row in set (0.01 sec)
```


### DAY

```mysql
mysql> SELECT DAY('2020-10-12');
+-------------------+
| DAY('2020-10-12') |
+-------------------+
|                12 |
+-------------------+
1 row in set (0.00 sec)
```

### WEEK

第何周目か

```mysql
mysql> SELECT WEEK('2020-10-12');
+--------------------+
| WEEK('2020-10-12') |
+--------------------+
|                 41 |
+--------------------+
1 row in set (0.01 sec)
```

### DAYOFMONTH

その月における経過日数

```mysql
mysql> SELECT DAYOFMONTH('2020-10-12');
+--------------------------+
| DAYOFMONTH('2020-10-12') |
+--------------------------+
|                       12 |
+--------------------------+
1 row in set (0.00 sec)

```

### DAYOFYEAR

その年における経過日数

```mysql
mysql> SELECT DAYOFYEAR('2020-10-12');
+-------------------------+
| DAYOFYEAR('2020-10-12') |
+-------------------------+
|                     286 |
+-------------------------+
1 row in set (0.01 sec)

```

### DAYOFWEEK

その週における経過日数

```mysql
mysql> SELECT DAYOFWEEK('2020-10-12');
+-------------------------+
| DAYOFWEEK('2020-10-12') |
+-------------------------+
|                       2 |
+-------------------------+
1 row in set (0.01 sec)

```

### DATE_FORMAT - %a

```mysql
mysql> SELECT DATE_FORMAT('2020-10-12', '%a');
+---------------------------------+
| DATE_FORMAT('2020-10-12', '%a') |
+---------------------------------+
| Mon                             |
+---------------------------------+
1 row in set (0.01 sec)
```

### DATE_FORMAT - %b

```mysql
mysql> SELECT DATE_FORMAT('2020-10-12', '%b');
+---------------------------------+
| DATE_FORMAT('2020-10-12', '%b') |
+---------------------------------+
| Oct                             |
+---------------------------------+
1 row in set (0.01 sec)
```

### DATE_FORMAT - %c

```mysql
mysql> SELECT DATE_FORMAT('2020-10-12', '%c');
+---------------------------------+
| DATE_FORMAT('2020-10-12', '%c') |
+---------------------------------+
| 10                              |
+---------------------------------+
1 row in set (0.01 sec)


```

### DATE_FORMAT - %D

```mysql
mysql> SELECT DATE_FORMAT('2020-10-12', '%d');
+---------------------------------+
| DATE_FORMAT('2020-10-12', '%d') |
+---------------------------------+
| 12                              |
+---------------------------------+
1 row in set (0.01 sec)

```

### CONVERT_TZ

```mysql
mysql> SELECT CONVERT_TZ('2020-10-01 06:34:24', 'asia/Tokyo', 'America/New_York');
+---------------------------------------------------------------------+
| CONVERT_TZ('2020-10-01 06:34:24', 'asia/Tokyo', 'America/New_York') |
+---------------------------------------------------------------------+
| 2020-09-30 17:34:24                                                 |
+---------------------------------------------------------------------+
1 row in set (0.01 sec)

```


## その他の関数

- DATABASE  
  `DATABASE()`: 現在選択しているデフォルトのデータベース名を取得する
- CURRENT_USER  
  `CURRENT_USER()`: MySQLに接続する時に実際に認証が行われたユーザ名とホスト名を取得する
- VERSION  
  `VERSION()`: MySQLのバージョンを取得する
- CHERSET  
  `CHERSET('A')`: 指定した値Aの文字コードを取得する
- COLLATION  
  `COLLATION('A')`: 指定した値Aの文字コードに加えて照合順序を取得する
- DEFAULT  
  `DEFAULT(列名)`: 指定した列に対して、デフォルト値を取得する 
- CAST
  `CAST(now() AS signed`: 指定した値を別のデータ型に変換する
- CONVERT
  `CONVERT(now(), signed)`: 指定した値を別のデータフォーマットに変換する


### DATABASE
現在選択しているデフォルトのデータベース名を取得する

```mysql
mysql> SELECT DATABASE();
+------------+
| DATABASE() |
+------------+
| ecsite     |
+------------+
1 row in set (0.01 sec)


```

### CURRENT_USER  

MySQLに接続する時に実際に認証が行われたユーザ名とホスト名を取得する

```mysql
mysql> SELECT CURRENT_USER();
+----------------+
| CURRENT_USER() |
+----------------+
| admin@%        |
+----------------+
1 row in set (0.01 sec)
```

### VERSION  

MySQLのバージョンを取得する

```mysql
mysql> SELECT VERSION();
+------------+
| VERSION()  |
+------------+
| 5.7.34-log |
+------------+
1 row in set (0.01 sec)
```


### CHERSET  

指定した値Aの文字コードを取得する

```mysql
mysql> SELECT CHARSET('ねこ');
+-------------------+
| CHARSET('ねこ')   |
+-------------------+
| utf8mb4           |
+-------------------+
1 row in set (0.00 sec)

```

### COLLATION  

指定した値Aの
を取得する

```mysql
mysql> SELECT COLLATION('猫');
+--------------------+
| COLLATION('猫')    |
+--------------------+
| utf8mb4_general_ci |
+--------------------+
1 row in set (0.01 sec)

```

### DEFAULT  

指定した列に対して、デフォルト値を取得する 

```mysql
mysql> SELECT DEFAULT(id) FROM users;
+-------------+
| DEFAULT(id) |
+-------------+
|           0 |
|           0 |
|           0 |
|           0 |
......
|           0 |
|           0 |
|           0 |
+-------------+
100 rows in set (0.01 sec)


```

### CAST

指定した値を別のデータ型に変換する

```mysql
mysql> SELECT NOW();
+---------------------+
| NOW()               |
+---------------------+
| 2021-08-06 00:21:10 |
+---------------------+
1 row in set (0.01 sec)

mysql> SELECT CAST(NOW() AS SIGNED);
+-----------------------+
| CAST(NOW() AS SIGNED) |
+-----------------------+
|        20210806002043 |
+-----------------------+
1 row in set (0.01 sec)
```

### CONVERT

指定した値を別のデータフォーマットに変換する


```mysql
mysql> SELECT CONVERT(NOW(),  SIGNED);
+-------------------------+
| CONVERT(NOW(),  SIGNED) |
+-------------------------+
|          20210806002646 |
+-------------------------+
1 row in set (0.00 sec)


```

#### INT型をDECIMAL型に変更
```mysql
mysql> SELECT CONVERT(id, DECIMAL(5, 3)) FROM users;
+----------------------------+
| CONVERT(id, DECIMAL(5, 3)) |
+----------------------------+
|                      1.000 |
|                      2.000 |
|                      3.000 |
|                      4.000 |
|                      5.000 |
.......
|                     95.000 |
|                     96.000 |
|                     97.000 |
|                     98.000 |
|                     99.000 |
|                     99.999 |
+----------------------------+
100 rows in set, 1 warning (0.01 sec)

```

## 演習

### 演習1


#### 要件
- product_idと合計発注量を表示する
- 合計発注量はsum_amountと列名として表示する
- リストは売れ筋順に並べる

#### 確認

```mysql
mysql> SELECT * FROM order_details ORDER BY id LIMIT 1;
+----+----------+------------+--------+----------------------------+----------------------------+
| id | order_id | product_id | amount | created_at                 | updated_at                 |
+----+----------+------------+--------+----------------------------+----------------------------+
|  1 |        2 |          1 |      1 | 2020-04-07 04:33:58.679643 | 2020-04-07 04:33:58.679643 |
+----+----------+------------+--------+----------------------------+----------------------------+


```

#### 回答

```mysql
mysql> SELECT product_id, SUM(amount) AS sum_amount FROM order_details GROUP BY product_id ORDER BY sum_amount DESC;
+------------+------------+
| product_id | sum_amount |
+------------+------------+
|          8 |        141 |
|          1 |        139 |
|          5 |        136 |
|          7 |        136 |
|          9 |        136 |
|          2 |        135 |
|          3 |        134 |
|          4 |        132 |
|          6 |        131 |
+------------+------------+
9 rows in set (0.01 sec)



mysql> SELECT product_id, SUM(amount) AS sum_amount FROM order_details GROUP BY product_id ORDER BY SUM(amount) DESC;
+------------+------------+
| product_id | sum_amount |
+------------+------------+
|          8 |        141 |
|          1 |        139 |
|          7 |        136 |
|          9 |        136 |
|          5 |        136 |
|          2 |        135 |
|          3 |        134 |
|          4 |        132 |
|          6 |        131 |
+------------+------------+
9 rows in set (0.01 sec)


```

### 演習2

#### 要件
課題1の発注量ランキング表に対して、平均値、最大値、最小値も一緒に表示する

表記文言
- product_id
- sum_amount
- avg_amount
- max_amount
- min_amount

#### 回答

```mysql
mysql> SELECT
    -> product_id,
    ->     SUM(amount) AS sum_amount,
    ->     AVG(amount) AS avg_amount,
    ->     MAX(amount) AS max_amount,
    ->     MIN(amount) AS min_amount
    -> FROM
    -> order_details
    -> GROUP BY product_id
    -> ORDER BY SUM(amount) DESC;
ERROR 2013 (HY000): Lost connection to MySQL server during query
No connection. Trying to reconnect...
Connection id:    369
Current database: ecsite

+------------+------------+------------+------------+------------+
| product_id | sum_amount | avg_amount | max_amount | min_amount |
+------------+------------+------------+------------+------------+
|          8 |        141 |     2.1045 |          3 |          1 |
|          1 |        139 |     2.0746 |          3 |          1 |
|          5 |        136 |     2.0299 |          3 |          1 |
|          7 |        136 |     2.0299 |          3 |          1 |
|          9 |        136 |     2.0606 |          3 |          1 |
|          2 |        135 |     2.0149 |          3 |          1 |
|          3 |        134 |     2.0000 |          3 |          1 |
|          4 |        132 |     1.9701 |          3 |          1 |
|          6 |        131 |     1.9552 |          3 |          1 |
+------------+------------+------------+------------+------------+

```

### 演習3

#### 要件

演習1で作成した表を利用して、以下のように文章で表示させてください。

「製品IDxxの商品の総注文量はxxです。」

使用するのはCONCATによる文字列結合


#### 回答

```mysql
mysql> SELECT
    ->     CAST(
    ->         CONCAT('製品ID', product_id, 'の商品の総注文量は', SUM(amount), 'です')
    ->     AS CHAR)
    ->     AS sum_amount
    -> FROM
    ->     order_details
    -> GROUP BY product_id
    -> ORDER BY SUM(amount) DESC;
+-----------------------------------------------+
| sum_amount                                    |
+-----------------------------------------------+
| 製品ID8の商品の総注文量は141です              |
| 製品ID1の商品の総注文量は139です              |
| 製品ID5の商品の総注文量は136です              |
| 製品ID7の商品の総注文量は136です              |
| 製品ID9の商品の総注文量は136です              |
| 製品ID2の商品の総注文量は135です              |
| 製品ID3の商品の総注文量は134です              |
| 製品ID4の商品の総注文量は132です              |
| 製品ID6の商品の総注文量は131です              |
+-----------------------------------------------+
9 rows in set (0.01 sec)

```


### 演習4

#### 要件

|id|name|created_at|
|---|---|---|
|1|Andy|作成された日時|
|2|Mary|作成された日時|
|3|Sam|作成された日時|


#### 回答

```mysql
mysql> CREATE TABLE case4(
    -> id INT(5) PRIMARY KEY AUTO_INCREMENT,
    ->     name VARCHAR(255) NOT NULL,
    ->     created_at DATE NOT NULL
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> DESC case4
    -> ;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | int(5)       | NO   | PRI | NULL    | auto_increment |
| name       | varchar(255) | NO   |     | NULL    |                |
| created_at | date         | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
3 rows in set (0.01 sec)

mysql> INSERT INTO case4
    -> (
    ->     id, name, created_at
    -> )
    -> VALUES 
    ->     (1, 'Andy', NOW()),
    ->     (2, 'Mary', NOW()),
    ->     (3, 'Sam', NOW());
Query OK, 3 rows affected, 3 warnings (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 3

mysql> SELECT * FROM case4;
+----+------+------------+
| id | name | created_at |
+----+------+------------+
|  1 | Andy | 2021-08-06 |
|  2 | Mary | 2021-08-06 |
|  3 | Sam  | 2021-08-06 |
+----+------+------------+
3 rows in set (0.01 sec)

```

#### ベストな回答

```mysql
mysql> CREATE TABLE case4
    -> (
    -> id INT(5) PRIMARY KEY AUTO_INCREMENT,
    ->     name VARCHAR(255) NOT NULL,
    ->     created_at TIMESTAMP DEFAULT NOW()
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> INSERT INTO case4(
    -> name
    -> ) VALUES 
    -> ('Andy'),
    ->     ('Mary'),
    ->     ('Sam');
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM case4;
+----+------+---------------------+
| id | name | created_at          |
+----+------+---------------------+
|  1 | Andy | 2021-08-06 03:13:59 |
|  2 | Mary | 2021-08-06 03:13:59 |
|  3 | Sam  | 2021-08-06 03:13:59 |
+----+------+---------------------+
3 rows in set (0.01 sec)

```

### 演習5

#### 要件
演習4で作成したcase4テーブルないのデータを下記の条件で抽出

- Andyという名前をMr.Andyに変更した上で、
- 全てを大文字にする

```mysql
mysql> SELECT
    ->     id,
    ->     UPPER(INSERT(name, 1, 1, 'Mr.A')),
    ->     created_at
    -> FROM
    ->     case4
    -> WHERE
    ->     name = 'Andy';
+----+-----------------------------------+---------------------+
| id | UPPER(INSERT(name, 1, 1, 'Mr.A')) | created_at          |
+----+-----------------------------------+---------------------+
|  1 | MR.ANDY                           | 2021-08-06 03:13:59 |
+----+-----------------------------------+---------------------+
1 row in set (0.01 sec)


mysql> SELECT
    ->     id,
    ->     UPPER(REPLACE(name, name, 'Mr.Andy')),
    ->     created_at
    -> FROM
    ->     case4
    -> WHERE
    ->     name = 'Andy';
+----+---------------------------------------+---------------------+
| id | UPPER(REPLACE(name, name, 'Mr.Andy')) | created_at          |
+----+---------------------------------------+---------------------+
|  1 | MR.ANDY                               | 2021-08-06 03:13:59 |
+----+---------------------------------------+---------------------+
1 row in set (0.01 sec)

```

