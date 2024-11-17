# サブクエリの活用

サブクエリを利用して、複数のクエリを連結して複雑なSQLクエリを作成する方法を学習します。


## FROM句におけるサブクエリ

FROM句におけるサブクエリには`AS`が必須になる。

### 基本型

```mysql
SELECT
    name
FROM
    (
    SELECT
        *
	FROM
        users
	)
	AS
        sub;

```

### 実例1

```mysql
mysql> SELECT
    ->     name
    -> FROM
    ->     (
    ->     SELECT
    ->         *
    ->     FROM
    ->         users
    -> )
    ->     AS
    ->         sub;
+----------------------+
| name                 |
+----------------------+
| Erin Casper          |
| Sudie Waelchi        |
| Desire Osinski Sr.   |
| Roy Yundt Jr.        |
| Golden Kunde         |
| Thaddeus Ledner      |
| Miss Rudy VonRueden  |
| Drusilla Larson      |
| Kip Raynor Jr.       |
| Coy Swaniawski       |
| Hong Wisozk IV       |
.....
| Truman Rogahn        |
| Soraya Luettgen      |
| Pablo Huels Jr.      |
| Leonardo Turner      |
| Augustine Cassin     |
| Velva Nolan          |
| Maurice Koss         |
| Domingo Herman       |
| Barton Stracke       |
+----------------------+
100 rows in set (0.01 sec)
```

### 実例2

```mysql
mysql> SELECT
    ->     gender
    -> FROM
    ->     (
    ->     SELECT
    ->         *
    ->     FROM
    ->         users
    ->     GROUP BY gender
    ->     )
    ->     AS
    ->         Sub;
+--------+
| gender |
+--------+
|      0 |
|      1 |
|      2 |
+--------+
3 rows in set (0.01 sec)
```

### 実例3

```mysql
mysql> SELECT
    ->     *
    -> FROM
    ->     (
    ->     SELECT
    ->         product_id,
    ->         sum(amount) AS amount_sum
    ->     FROM
    ->         order_details
    ->     GROUP BY product_id 
    ->     )
    ->     AS Sub;
+------------+------------+
| product_id | amount_sum |
+------------+------------+
|          1 |        139 |
|          2 |        135 |
|          3 |        134 |
|          4 |        132 |
|          5 |        136 |
|          6 |        131 |
|          7 |        136 |
|          8 |        141 |
|          9 |        136 |
+------------+------------+
9 rows in set (0.01 sec)

```

## SELECT句におけるサブクエリ

```mysql
mysql> SELECT
    ->     product_id,
    ->     SUM(amount) AS PRODUCT_SUM,
    ->     (SELECT SUM(amount) FROM order_details) AS TOTAL_SUM
    -> FROM
    ->     order_details
    -> GROUP BY
    ->     product_id;
+------------+-------------+-----------+
| product_id | PRODUCT_SUM | TOTAL_SUM |
+------------+-------------+-----------+
|          1 |         139 |      1220 |
|          2 |         135 |      1220 |
|          3 |         134 |      1220 |
|          4 |         132 |      1220 |
|          5 |         136 |      1220 |
|          6 |         131 |      1220 |
|          7 |         136 |      1220 |
|          8 |         141 |      1220 |
|          9 |         136 |      1220 |
+------------+-------------+-----------+
9 rows in set (0.01 sec)
```



## WHERE句におけるサブクエリ（IN）

```mysql

mysql> SELECT
    ->     *
    -> FROM
    ->     users
    -> WHERE
    ->     id IN
    ->     (
    ->     SELECT
    ->         id
    ->     FROM
    ->         users
    ->     WHERE
    ->         birthday BETWEEN '1990-01-01' AND '1995-01-01'
    ->     );
+----+-------------------------------+--------------------+--------+------------+----------------------------+----------------------------+
| id | email                         | name               | gender | birthday   | created_at                 | updated_at                 |
+----+-------------------------------+--------------------+--------+------------+----------------------------+----------------------------+
|  4 | michael@grant.org             | Roy Yundt Jr.      |      0 | 1994-06-16 | 2020-04-07 04:33:58.407876 | 2020-04-07 04:33:58.407876 |
| 13 | gregory@sanfordbeier.com      | Zenaida Gorczany I |      1 | 1991-03-27 | 2020-04-07 04:33:58.427887 | 2020-04-07 04:33:58.427887 |
| 16 | jong@bins.biz                 | Darrick Lehner     |      0 | 1993-01-07 | 2020-04-07 04:33:58.434218 | 2020-04-07 04:33:58.434218 |
| 28 | kurtis_fadel@leuschkehills.io | Joshua Block       |      1 | 1994-08-13 | 2020-04-07 04:33:58.461179 | 2020-04-07 04:33:58.461179 |
| 30 | marianna.metz@schuster.co     | Elinor Gleichner   |      0 | 1990-12-10 | 2020-04-07 04:33:58.466191 | 2020-04-07 04:33:58.466191 |
| 41 | dudley.turner@wuckert.biz     | Ms. Bart Lowe      |      2 | 1992-01-14 | 2020-04-07 04:33:58.500957 | 2020-04-07 04:33:58.500957 |
| 48 | rhea.balistreri@connelly.io   | Loyd Gusikowski    |      0 | 1991-08-11 | 2020-04-07 04:33:58.516011 | 2020-04-07 04:33:58.516011 |
| 49 | brain@waterscummerata.name    | Jonathon Armstrong |      0 | 1992-09-06 | 2020-04-07 04:33:58.518593 | 2020-04-07 04:33:58.518593 |
| 57 | sabra_heaney@crona.biz        | Iva Leuschke Jr.   |      1 | 1993-08-26 | 2020-04-07 04:33:58.546846 | 2020-04-07 04:33:58.546846 |
| 66 | macy@daugherty.com            | Randolph Corwin    |      0 | 1994-09-07 | 2020-04-07 04:33:58.576417 | 2020-04-07 04:33:58.576417 |
| 77 | hyman@davis.co                | Ta Jerde I         |      0 | 1994-07-22 | 2020-04-07 04:33:58.607130 | 2020-04-07 04:33:58.607130 |
| 84 | trena.hauck@gottlieb.io       | Lanita Zboncak     |      0 | 1994-05-17 | 2020-04-07 04:33:58.622192 | 2020-04-07 04:33:58.622192 |
+----+-------------------------------+--------------------+--------+------------+----------------------------+----------------------------+
12 rows in set (0.01 sec)


mysql> SELECT
    ->     *
    -> FROM
    ->     users
    -> WHERE
    ->     birthday BETWEEN '1991-01-01' AND '1995-01-01';
+----+-------------------------------+--------------------+--------+------------+----------------------------+----------------------------+
| id | email                         | name               | gender | birthday   | created_at                 | updated_at                 |
+----+-------------------------------+--------------------+--------+------------+----------------------------+----------------------------+
|  4 | michael@grant.org             | Roy Yundt Jr.      |      0 | 1994-06-16 | 2020-04-07 04:33:58.407876 | 2020-04-07 04:33:58.407876 |
| 13 | gregory@sanfordbeier.com      | Zenaida Gorczany I |      1 | 1991-03-27 | 2020-04-07 04:33:58.427887 | 2020-04-07 04:33:58.427887 |
| 16 | jong@bins.biz                 | Darrick Lehner     |      0 | 1993-01-07 | 2020-04-07 04:33:58.434218 | 2020-04-07 04:33:58.434218 |
| 28 | kurtis_fadel@leuschkehills.io | Joshua Block       |      1 | 1994-08-13 | 2020-04-07 04:33:58.461179 | 2020-04-07 04:33:58.461179 |
| 41 | dudley.turner@wuckert.biz     | Ms. Bart Lowe      |      2 | 1992-01-14 | 2020-04-07 04:33:58.500957 | 2020-04-07 04:33:58.500957 |
| 48 | rhea.balistreri@connelly.io   | Loyd Gusikowski    |      0 | 1991-08-11 | 2020-04-07 04:33:58.516011 | 2020-04-07 04:33:58.516011 |
| 49 | brain@waterscummerata.name    | Jonathon Armstrong |      0 | 1992-09-06 | 2020-04-07 04:33:58.518593 | 2020-04-07 04:33:58.518593 |
| 57 | sabra_heaney@crona.biz        | Iva Leuschke Jr.   |      1 | 1993-08-26 | 2020-04-07 04:33:58.546846 | 2020-04-07 04:33:58.546846 |
| 66 | macy@daugherty.com            | Randolph Corwin    |      0 | 1994-09-07 | 2020-04-07 04:33:58.576417 | 2020-04-07 04:33:58.576417 |
| 77 | hyman@davis.co                | Ta Jerde I         |      0 | 1994-07-22 | 2020-04-07 04:33:58.607130 | 2020-04-07 04:33:58.607130 |
| 84 | trena.hauck@gottlieb.io       | Lanita Zboncak     |      0 | 1994-05-17 | 2020-04-07 04:33:58.622192 | 2020-04-07 04:33:58.622192 |
+----+-------------------------------+--------------------+--------+------------+----------------------------+----------------------------+
11 rows in set (0.01 sec)


```

```mysql
mysql> SELECT
    ->     id,
    ->     order_id,
    ->     product_id,
    ->     amount
    -> FROM
    ->     order_details
    -> WHERE
    ->     product_id
    -> IN
    -> (
    ->     SELECT
    ->         id
    -> FROM
    ->         products
    -> WHERE
    ->         price > 40
    -> );
+-----+----------+------------+--------+
| id  | order_id | product_id | amount |
+-----+----------+------------+--------+
|   1 |        2 |          1 |      1 |
|  10 |        4 |          1 |      2 |
|  19 |        7 |          1 |      3 |
|  28 |       10 |          1 |      3 |
|  37 |       14 |          1 |      3 |
|  46 |       19 |          1 |      2 |
|  55 |       24 |          1 |      2 |
|  64 |       29 |          1 |      2 |
|  73 |       32 |          1 |      3 |
|  82 |       36 |          1 |      1 |
..........
| 520 |      261 |          7 |      1 |
| 529 |      265 |          7 |      3 |
| 538 |      272 |          7 |      2 |
| 547 |      275 |          7 |      1 |
| 556 |      279 |          7 |      2 |
| 565 |      283 |          7 |      3 |
| 574 |      289 |          7 |      1 |
| 583 |      292 |          7 |      3 |
| 592 |      296 |          7 |      1 |
| 601 |      300 |          7 |      1 |
+-----+----------+------------+--------+
268 rows in set (0.01 sec)

```

### JOINとの違い

```mysql

mysql> SELECT
    -> order_details.id,
    -> order_details.order_id,
    -> order_details.product_id,
    -> order_details.amount
    -> FROM
    ->     order_details
    -> JOIN
    ->     products
    -> ON
    ->     order_details.product_id = products.id
    -> WHERE
    ->     products.price > 40;
+-----+----------+------------+--------+
| id  | order_id | product_id | amount |
+-----+----------+------------+--------+
|   1 |        2 |          1 |      1 |
|  10 |        4 |          1 |      2 |
|  19 |        7 |          1 |      3 |
|  28 |       10 |          1 |      3 |
|  37 |       14 |          1 |      3 |
|  46 |       19 |          1 |      2 |
|  55 |       24 |          1 |      2 |
|  64 |       29 |          1 |      2 |
.......
| 529 |      265 |          7 |      3 |
| 538 |      272 |          7 |      2 |
| 547 |      275 |          7 |      1 |
| 556 |      279 |          7 |      2 |
| 565 |      283 |          7 |      3 |
| 574 |      289 |          7 |      1 |
| 583 |      292 |          7 |      3 |
| 592 |      296 |          7 |      1 |
| 601 |      300 |          7 |      1 |
+-----+----------+------------+--------+
268 rows in set (0.01 sec)

mysql> SELECT
    -> order_details.id,
    -> order_details.order_id,
    -> order_details.product_id,
    -> order_details.amount,
    ->     products.price
    -> FROM
    ->     order_details
    -> JOIN
    ->     products
    -> ON
    ->     order_details.product_id = products.id
    -> WHERE
    ->     products.price > 40;
+-----+----------+------------+--------+-------+
| id  | order_id | product_id | amount | price |
+-----+----------+------------+--------+-------+
|   1 |        2 |          1 |      1 |    49 |
|  10 |        4 |          1 |      2 |    49 |
|  19 |        7 |          1 |      3 |    49 |
|  28 |       10 |          1 |      3 |    49 |
|  37 |       14 |          1 |      3 |    49 |
|  46 |       19 |          1 |      2 |    49 |
|  55 |       24 |          1 |      2 |    49 |
|  64 |       29 |          1 |      2 |    49 |
|  73 |       32 |          1 |      3 |    49 |
|  82 |       36 |          1 |      1 |    49 |
|  91 |       40 |          1 |      3 |    49 |
| 100 |       47 |          1 |      3 |    49 |
| 109 |       51 |          1 |      1 |    49 |
| 118 |       59 |          1 |      2 |    49 |
| 127 |       67 |          1 |      2 |    49 |
......
| 538 |      272 |          7 |      2 |   598 |
| 547 |      275 |          7 |      1 |   598 |
| 556 |      279 |          7 |      2 |   598 |
| 565 |      283 |          7 |      3 |   598 |
| 574 |      289 |          7 |      1 |   598 |
| 583 |      292 |          7 |      3 |   598 |
| 592 |      296 |          7 |      1 |   598 |
| 601 |      300 |          7 |      1 |   598 |
+-----+----------+------------+--------+-------+
268 rows in set (0.01 sec)
```
## WHERE句におけるサブクエリ（EXISTS）

```mysql
mysql> SELECT
    ->     *
    -> FROM
    ->     users
    -> WHERE EXISTS
    ->     (SELECT * FROM users WHERE id = 1);
+-----+--------------------------------------+----------------------+--------+------------+----------------------------+----------------------------+
| id  | email                                | name                 | gender | birthday   | created_at                 | updated_at                 |
+-----+--------------------------------------+----------------------+--------+------------+----------------------------+----------------------------+
|   1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 | 2020-04-07 04:33:58.399121 | 2020-04-07 04:33:58.399121 |
|   2 | louis.price@borer.co                 | Sudie Waelchi        |      1 | 1999-07-24 | 2020-04-07 04:33:58.402440 | 2020-04-07 04:33:58.402440 |
|   3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 | 2020-04-07 04:33:58.405399 | 2020-04-07 04:33:58.405399 |
|   4 | michael@grant.org                    | Roy Yundt Jr.        |      0 | 1994-06-16 | 2020-04-07 04:33:58.407876 | 2020-04-07 04:33:58.407876 |
|   5 | fredrick_boyle@goyette.org           | Golden Kunde         |      1 | 1998-05-02 | 2020-04-07 04:33:58.410394 | 2020-04-07 04:33:58.410394 |
|   6 | felipe@nitzsche.name                 | Thaddeus Ledner      |      0 | 1962-07-30 | 2020-04-07 04:33:58.412617 | 2020-04-07 04:33:58.412617 |
|   7 | lesley_mitchell@damore.net           | Miss Rudy VonRueden  |      0 | 1968-03-08 | 2020-04-07 04:33:58.414754 | 2020-04-07 04:33:58.414754 |
|   8 | phyli.huel@boyer.co                  | Drusilla Larson      |      0 | 1964-11-26 | 2020-04-07 04:33:58.416812 | 2020-04-07 04:33:58.416812 |
|   9 | dirk.pagac@rosenbaumdaugherty.net    | Kip Raynor Jr.       |      1 | 1964-07-20 | 2020-04-07 04:33:58.418895 | 2020-04-07 04:33:58.418895 |
.........
|  97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 | 2020-04-07 04:33:58.650878 | 2020-04-07 04:33:58.650878 |
|  98 | valery@reilly.org                    | Maurice Koss         |      0 | 1987-03-25 | 2020-04-07 04:33:58.653008 | 2020-04-07 04:33:58.653008 |
|  99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 | 2020-04-07 04:33:58.654985 | 2020-04-07 04:33:58.654985 |
| 100 | hyman.boyer@mayert.name              | Barton Stracke       |      0 | 1995-03-24 | 2020-04-07 04:33:58.656992 | 2020-04-07 04:33:58.656992 |
+-----+--------------------------------------+----------------------+--------+------------+----------------------------+----------------------------+
100 rows in set (0.01 sec)

mysql> 
mysql> 
mysql> SELECT
    ->     *
    -> FROM
    ->     users
    -> WHERE EXISTS
    ->     (SELECT * FROM users WHERE id = 101);
Empty set (0.01 sec)

```

```mysql
mysql> SELECT
    ->     *
    -> FROM
    ->     users
    -> WHERE EXISTS
    ->     (SELECT * FROM orders WHERE orders.user_id = users.id);
+----+--------------------------------------+----------------------+--------+------------+----------------------------+----------------------------+
| id | email                                | name                 | gender | birthday   | created_at                 | updated_at                 |
+----+--------------------------------------+----------------------+--------+------------+----------------------------+----------------------------+
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 | 2020-04-07 04:33:58.399121 | 2020-04-07 04:33:58.399121 |
|  2 | louis.price@borer.co                 | Sudie Waelchi        |      1 | 1999-07-24 | 2020-04-07 04:33:58.402440 | 2020-04-07 04:33:58.402440 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 | 2020-04-07 04:33:58.405399 | 2020-04-07 04:33:58.405399 |
|  4 | michael@grant.org                    | Roy Yundt Jr.        |      0 | 1994-06-16 | 2020-04-07 04:33:58.407876 | 2020-04-07 04:33:58.407876 |
|  5 | fredrick_boyle@goyette.org           | Golden Kunde         |      1 | 1998-05-02 | 2020-04-07 04:33:58.410394 | 2020-04-07 04:33:58.410394 |
|  6 | felipe@nitzsche.name                 | Thaddeus Ledner      |      0 | 1962-07-30 | 2020-04-07 04:33:58.412617 | 2020-04-07 04:33:58.412617 |
|  7 | lesley_mitchell@damore.net           | Miss Rudy VonRueden  |      0 | 1968-03-08 | 2020-04-07 04:33:58.414754 | 2020-04-07 04:33:58.414754 |
|  8 | phyli.huel@boyer.co                  | Drusilla Larson      |      0 | 1964-11-26 | 2020-04-07 04:33:58.416812 | 2020-04-07 04:33:58.416812 |
|  9 | dirk.pagac@rosenbaumdaugherty.net    | Kip Raynor Jr.       |      1 | 1964-07-20 | 2020-04-07 04:33:58.418895 | 2020-04-07 04:33:58.418895 |
| 10 | linwood.vonrueden@hueljones.biz      | Coy Swaniawski       |      1 | 1978-03-12 | 2020-04-07 04:33:58.420987 | 2020-04-07 04:33:58.420987 |
| 11 | sean@labadie.co                      | Hong Wisozk IV       |      2 | 1962-08-03 | 2020-04-07 04:33:58.423240 | 2020-04-07 04:33:58.423240 |
| 12 | kayce_gulgowski@hodkiewicz.info      | Jerold Satterfield   |      0 | 2000-06-26 | 2020-04-07 04:33:58.425603 | 2020-04-07 04:33:58.425603 |
..........
| 90 | rae.streich@ruecker.org              | Annetta Friesen II   |      0 | 1979-07-20 | 2020-04-07 04:33:58.635035 | 2020-04-07 04:33:58.635035 |
| 91 | berniece@daugherty.io                | Rickie Littel        |      2 | 1978-11-05 | 2020-04-07 04:33:58.637453 | 2020-04-07 04:33:58.637453 |
| 92 | galen@wiegandmaggio.biz              | Truman Rogahn        |      0 | 1960-05-11 | 2020-04-07 04:33:58.639826 | 2020-04-07 04:33:58.639826 |
| 93 | kermit@vonshanahan.biz               | Soraya Luettgen      |      1 | 1963-11-30 | 2020-04-07 04:33:58.642277 | 2020-04-07 04:33:58.642277 |
| 94 | devora.douglas@nolanschowalter.co    | Pablo Huels Jr.      |      1 | 1967-08-27 | 2020-04-07 04:33:58.644634 | 2020-04-07 04:33:58.644634 |
| 95 | weldon@kaulke.name                   | Leonardo Turner      |      1 | 2004-11-13 | 2020-04-07 04:33:58.646703 | 2020-04-07 04:33:58.646703 |
| 96 | merna@steuberreilly.biz              | Augustine Cassin     |      1 | 1997-07-08 | 2020-04-07 04:33:58.648822 | 2020-04-07 04:33:58.648822 |
| 97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 | 2020-04-07 04:33:58.650878 | 2020-04-07 04:33:58.650878 |
| 98 | valery@reilly.org                    | Maurice Koss         |      0 | 1987-03-25 | 2020-04-07 04:33:58.653008 | 2020-04-07 04:33:58.653008 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 | 2020-04-07 04:33:58.654985 | 2020-04-07 04:33:58.654985 |
+----+--------------------------------------+----------------------+--------+------------+----------------------------+----------------------------+
98 rows in set (0.01 sec)

```

## HAVING句におけるサブクエリ

```mysql
mysql> SELECT
    ->     product_id,
    ->     SUM(amount) AS amount_sum
    -> FROM
    ->     order_details
    -> GROUP BY
    ->     product_id
    -> HAVING
    ->     SUM(amount) > (SELECT AVG(amount)/9 FROM order_details);
+------------+------------+
| product_id | amount_sum |
+------------+------------+
|          1 |        139 |
|          2 |        135 |
|          3 |        134 |
|          4 |        132 |
|          5 |        136 |
|          6 |        131 |
|          7 |        136 |
|          8 |        141 |
|          9 |        136 |
+------------+------------+
9 rows in set (0.01 sec)
```

## ANY/SOME/ALL

```mysql
mysql> SELECT * FROM products;
+----+------------------------+-------+----------------------------+----------------------------+
| id | name                   | price | created_at                 | updated_at                 |
+----+------------------------+-------+----------------------------+----------------------------+
|  1 | Water cooker           |    49 | 2020-04-07 04:33:58.180995 | 2020-04-07 04:33:58.180995 |
|  2 | Window fan             |    12 | 2020-04-07 04:33:58.189536 | 2020-04-07 04:33:58.189536 |
|  3 | Mangle (machine)       |    40 | 2020-04-07 04:33:58.191450 | 2020-04-07 04:33:58.191450 |
|  4 | Evaporative cooler     |    38 | 2020-04-07 04:33:58.193246 | 2020-04-07 04:33:58.193246 |
|  5 | Refrigerator           |   698 | 2020-04-07 04:33:58.210542 | 2020-04-07 04:33:58.210542 |
|  6 | Central vacuum cleaner |    95 | 2020-04-07 04:33:58.212482 | 2020-04-07 04:33:58.212482 |
|  7 | Drawer dishwasher      |   598 | 2020-04-07 04:33:58.214347 | 2020-04-07 04:33:58.214347 |
|  8 | Mousetrap              |     5 | 2020-04-07 04:33:58.216274 | 2020-04-07 04:33:58.216274 |
|  9 | Futon dryer            |    25 | 2020-04-07 04:33:58.218270 | 2020-04-07 04:33:58.218270 |
+----+------------------------+-------+----------------------------+----------------------------+
9 rows in set (0.00 sec)

mysql> SELECT
    ->     *
    -> FROM
    ->     products
    -> WHERE
    ->     price > ANY
    ->     (
    ->     SELECT
    ->         price
    ->     FROM
    ->         products
    ->     WHERE
    ->         id < 5
    ->     );
+----+------------------------+-------+----------------------------+----------------------------+
| id | name                   | price | created_at                 | updated_at                 |
+----+------------------------+-------+----------------------------+----------------------------+
|  1 | Water cooker           |    49 | 2020-04-07 04:33:58.180995 | 2020-04-07 04:33:58.180995 |
|  3 | Mangle (machine)       |    40 | 2020-04-07 04:33:58.191450 | 2020-04-07 04:33:58.191450 |
|  4 | Evaporative cooler     |    38 | 2020-04-07 04:33:58.193246 | 2020-04-07 04:33:58.193246 |
|  5 | Refrigerator           |   698 | 2020-04-07 04:33:58.210542 | 2020-04-07 04:33:58.210542 |
|  6 | Central vacuum cleaner |    95 | 2020-04-07 04:33:58.212482 | 2020-04-07 04:33:58.212482 |
|  7 | Drawer dishwasher      |   598 | 2020-04-07 04:33:58.214347 | 2020-04-07 04:33:58.214347 |
|  9 | Futon dryer            |    25 | 2020-04-07 04:33:58.218270 | 2020-04-07 04:33:58.218270 |
+----+------------------------+-------+----------------------------+----------------------------+
7 rows in set (0.01 sec)

mysql> 

mysql> SELECT
    ->     *
    -> FROM
    ->     products
    -> WHERE
    ->     price > SOME
    ->     (
    ->     SELECT
    ->         price
    ->     FROM
    ->         products
    ->     WHERE
    ->         id < 5
    ->     );
+----+------------------------+-------+----------------------------+----------------------------+
| id | name                   | price | created_at                 | updated_at                 |
+----+------------------------+-------+----------------------------+----------------------------+
|  1 | Water cooker           |    49 | 2020-04-07 04:33:58.180995 | 2020-04-07 04:33:58.180995 |
|  3 | Mangle (machine)       |    40 | 2020-04-07 04:33:58.191450 | 2020-04-07 04:33:58.191450 |
|  4 | Evaporative cooler     |    38 | 2020-04-07 04:33:58.193246 | 2020-04-07 04:33:58.193246 |
|  5 | Refrigerator           |   698 | 2020-04-07 04:33:58.210542 | 2020-04-07 04:33:58.210542 |
|  6 | Central vacuum cleaner |    95 | 2020-04-07 04:33:58.212482 | 2020-04-07 04:33:58.212482 |
|  7 | Drawer dishwasher      |   598 | 2020-04-07 04:33:58.214347 | 2020-04-07 04:33:58.214347 |
|  9 | Futon dryer            |    25 | 2020-04-07 04:33:58.218270 | 2020-04-07 04:33:58.218270 |
+----+------------------------+-------+----------------------------+----------------------------+
7 rows in set (0.01 sec)

mysql> SELECT
    ->     *
    -> FROM
    ->     products
    -> WHERE
    ->     price > ALL
    ->     (
    ->     SELECT
    ->         price
    ->     FROM
    ->         products
    ->     WHERE
    ->         id < 5
    ->     );
+----+------------------------+-------+----------------------------+----------------------------+
| id | name                   | price | created_at                 | updated_at                 |
+----+------------------------+-------+----------------------------+----------------------------+
|  5 | Refrigerator           |   698 | 2020-04-07 04:33:58.210542 | 2020-04-07 04:33:58.210542 |
|  6 | Central vacuum cleaner |    95 | 2020-04-07 04:33:58.212482 | 2020-04-07 04:33:58.212482 |
|  7 | Drawer dishwasher      |   598 | 2020-04-07 04:33:58.214347 | 2020-04-07 04:33:58.214347 |
+----+------------------------+-------+----------------------------+----------------------------+
3 rows in set (0.01 sec)
```


## 演習


### 演習1

製品ID5の製品へのレビューを実施しているユーザーリストを抽出したい。抽出されるデータとしては、usersテーブルのリストの対象者全データを取得してください。


```mysql
mysql> SELECT
    ->     users.id,
    ->     users.email,
    ->     users.name,
    ->     users.gender,
    ->     users.birthday
    -> FROM
    ->     users
    -> WHERE
    ->     id IN
    ->     (
    ->     SELECT
    ->         user_id
    -> FROM
    ->         product_reviews
    -> WHERE
    ->         product_id = 5)
    -> ORDER BY
    -> users.id;
+----+--------------------------------------+---------------------+--------+------------+
| id | email                                | name                | gender | birthday   |
+----+--------------------------------------+---------------------+--------+------------+
|  1 | jannie@dach.net                      | Erin Casper         |      2 | 1976-04-20 |
|  2 | louis.price@borer.co                 | Sudie Waelchi       |      1 | 1999-07-24 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.  |      1 | 2002-03-09 |
|  5 | fredrick_boyle@goyette.org           | Golden Kunde        |      1 | 1998-05-02 |
|  7 | lesley_mitchell@damore.net           | Miss Rudy VonRueden |      0 | 1968-03-08 |
|  8 | phyli.huel@boyer.co                  | Drusilla Larson     |      0 | 1964-11-26 |
| 13 | gregory@sanfordbeier.com             | Zenaida Gorczany I  |      1 | 1991-03-27 |
| 15 | michel.herzog@beier.biz              | Russ Schoen         |      1 | 1988-12-26 |
| 18 | milan.koch@crooksyundt.info          | Irvin Balistreri    |      1 | 1995-02-16 |
| 19 | jospeh@walker.com                    | Mr. Mira Gleason    |      0 | 1970-01-04 |
| 20 | jude.hahn@feestherzog.org            | Darron Halvorson    |      1 | 2003-06-07 |
| 26 | gustavo_swaniawski@konopelskimoen.co | Parthenia Hettinger |      0 | 1981-11-13 |
| 27 | noble_monahan@roob.org               | Aurelio Jacobson    |      0 | 1969-05-27 |
| 29 | leif.emmerich@toy.co                 | Dominica Harber     |      0 | 1984-12-12 |
| 31 | sherron@rowe.net                     | Tameka Hayes I      |      2 | 1989-01-05 |
| 32 | trent_cartwright@ritchie.com         | Tawnya Witting      |      1 | 1982-12-04 |
| 41 | dudley.turner@wuckert.biz            | Ms. Bart Lowe       |      2 | 1992-01-14 |
| 42 | milagro@buckridge.name               | Mrs. Charity Kohler |      0 | 1984-08-29 |
| 44 | christal@zulauf.org                  | Ross Willms         |      1 | 1965-03-31 |
| 46 | reiko_stamm@ledner.name              | Ty Thompson PhD     |      0 | 1972-07-03 |
| 47 | annamarie@abernathy.co               | Aleida Ruecker      |      0 | 1996-06-26 |
| 48 | rhea.balistreri@connelly.io          | Loyd Gusikowski     |      0 | 1991-08-11 |
| 50 | gerry_balistreri@douglashills.name   | Theron Nolan        |      1 | 1985-03-07 |
| 51 | jacinda.douglas@ortizschmitt.org     | Justin Dickens      |      2 | 1996-09-28 |
| 52 | zella@gutmannvandervort.org          | Dr. Gene Steuber    |      1 | 1967-07-11 |
| 55 | darwin_rice@gerholdhansen.name       | Norris Koss         |      1 | 1968-05-15 |
| 60 | vaughn_brekke@ratkemcclure.info      | Fran Reynolds       |      1 | 1961-03-30 |
| 62 | georgianne.jacobs@koepp.net          | Luis Aufderhar DDS  |      0 | 1978-01-26 |
| 63 | starla_watsica@vonrueden.org         | Otelia Kirlin       |      0 | 2004-06-22 |
| 67 | dennis.blick@kohler.com              | Danette Collins     |      1 | 1965-03-13 |
| 70 | jenna_kemmer@mcclure.co              | Barbara Kozey       |      1 | 1980-05-08 |
| 71 | ismael.waelchi@vonmccullough.com     | Loree Zboncak       |      2 | 1981-07-05 |
| 73 | angle@emardfay.com                   | Clifton Nitzsche    |      1 | 1976-07-26 |
| 74 | clifton_terry@leffler.org            | Lanny Boyer         |      1 | 1988-07-30 |
| 76 | raye.spencer@lowe.io                 | Al Gottlieb         |      1 | 2002-09-13 |
| 77 | hyman@davis.co                       | Ta Jerde I          |      0 | 1994-07-22 |
| 82 | arron@grant.io                       | Elmira White        |      1 | 1999-03-14 |
| 83 | pearl@thompsonmorar.name             | Danyell Price       |      0 | 2004-10-21 |
| 84 | trena.hauck@gottlieb.io              | Lanita Zboncak      |      0 | 1994-05-17 |
| 86 | columbus@vandervortfeest.name        | Shawanda McGlynn    |      1 | 1966-06-08 |
| 89 | rocio@gleichnerschiller.info         | Dorian Gislason     |      0 | 2004-04-09 |
| 90 | rae.streich@ruecker.org              | Annetta Friesen II  |      0 | 1979-07-20 |
| 91 | berniece@daugherty.io                | Rickie Littel       |      2 | 1978-11-05 |
| 92 | galen@wiegandmaggio.biz              | Truman Rogahn       |      0 | 1960-05-11 |
| 94 | devora.douglas@nolanschowalter.co    | Pablo Huels Jr.     |      1 | 1967-08-27 |
| 95 | weldon@kaulke.name                   | Leonardo Turner     |      1 | 2004-11-13 |
| 99 | dennis@buckridge.co                  | Domingo Herman      |      0 | 1981-02-28 |
+----+--------------------------------------+---------------------+--------+------------+
47 rows in set (0.01 sec)

```

```mysql

mysql>     
mysql> SELECT
    ->     users.id,
    ->     users.email,
    ->     users.name,
    ->     users.gender,
    ->     users.birthday,
    ->     product_reviews.body
    -> FROM
    ->     users
    -> INNER JOIN
    ->     product_reviews
    -> ON
    ->     users.id = product_reviews.user_id
    -> WHERE
    ->     product_reviews.product_id = 5
    -> ORDER BY
    -> users.id
    -> ;
+----+--------------------------------------+---------------------+--------+------------+---------------------------------------------+
| id | email                                | name                | gender | birthday   | body                                        |
+----+--------------------------------------+---------------------+--------+------------+---------------------------------------------+
|  1 | jannie@dach.net                      | Erin Casper         |      2 | 1976-04-20 | This product is disappointing.              |
|  1 | jannie@dach.net                      | Erin Casper         |      2 | 1976-04-20 | What I bought is has good cost performance. |
|  2 | louis.price@borer.co                 | Sudie Waelchi       |      1 | 1999-07-24 | What I bought is has good cost performance. |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.  |      1 | 2002-03-09 | What I bought is hard to use.               |
|  5 | fredrick_boyle@goyette.org           | Golden Kunde        |      1 | 1998-05-02 | What I bought is easy to use.               |
|  7 | lesley_mitchell@damore.net           | Miss Rudy VonRueden |      0 | 1968-03-08 | This is disappointing.                      |
|  7 | lesley_mitchell@damore.net           | Miss Rudy VonRueden |      0 | 1968-03-08 | What I bought is disappointing.             |
|  8 | phyli.huel@boyer.co                  | Drusilla Larson     |      0 | 1964-11-26 | What I bought is disappointing.             |
|  8 | phyli.huel@boyer.co                  | Drusilla Larson     |      0 | 1964-11-26 | What I bought is hard to use.               |
| 13 | gregory@sanfordbeier.com             | Zenaida Gorczany I  |      1 | 1991-03-27 | This product is has good cost performance.  |
| 13 | gregory@sanfordbeier.com             | Zenaida Gorczany I  |      1 | 1991-03-27 | This product is has good cost performance.  |
| 15 | michel.herzog@beier.biz              | Russ Schoen         |      1 | 1988-12-26 | This is disappointing.                      |
| 15 | michel.herzog@beier.biz              | Russ Schoen         |      1 | 1988-12-26 | What I bought is has good cost performance. |
| 18 | milan.koch@crooksyundt.info          | Irvin Balistreri    |      1 | 1995-02-16 | What I bought is hard to use.               |
| 19 | jospeh@walker.com                    | Mr. Mira Gleason    |      0 | 1970-01-04 | This product is hard to use.                |
| 20 | jude.hahn@feestherzog.org            | Darron Halvorson    |      1 | 2003-06-07 | This is disappointing.                      |
| 20 | jude.hahn@feestherzog.org            | Darron Halvorson    |      1 | 2003-06-07 | What I bought is hard to use.               |
| 26 | gustavo_swaniawski@konopelskimoen.co | Parthenia Hettinger |      0 | 1981-11-13 | What I bought is easy to use.               |
| 27 | noble_monahan@roob.org               | Aurelio Jacobson    |      0 | 1969-05-27 | This is disappointing.                      |
| 29 | leif.emmerich@toy.co                 | Dominica Harber     |      0 | 1984-12-12 | This is disappointing.                      |
| 31 | sherron@rowe.net                     | Tameka Hayes I      |      2 | 1989-01-05 | What I bought is has good cost performance. |
| 32 | trent_cartwright@ritchie.com         | Tawnya Witting      |      1 | 1982-12-04 | What I bought is disappointing.             |
| 41 | dudley.turner@wuckert.biz            | Ms. Bart Lowe       |      2 | 1992-01-14 | This product is disappointing.              |
| 41 | dudley.turner@wuckert.biz            | Ms. Bart Lowe       |      2 | 1992-01-14 | This is has good cost performance.          |
| 42 | milagro@buckridge.name               | Mrs. Charity Kohler |      0 | 1984-08-29 | What I bought is easy to use.               |
| 44 | christal@zulauf.org                  | Ross Willms         |      1 | 1965-03-31 | This product is disappointing.              |
| 44 | christal@zulauf.org                  | Ross Willms         |      1 | 1965-03-31 | This is has good cost performance.          |
| 46 | reiko_stamm@ledner.name              | Ty Thompson PhD     |      0 | 1972-07-03 | This product is has good cost performance.  |
| 46 | reiko_stamm@ledner.name              | Ty Thompson PhD     |      0 | 1972-07-03 | What I bought is easy to use.               |
| 47 | annamarie@abernathy.co               | Aleida Ruecker      |      0 | 1996-06-26 | What I bought is hard to use.               |
| 48 | rhea.balistreri@connelly.io          | Loyd Gusikowski     |      0 | 1991-08-11 | This is easy to use.                        |
| 50 | gerry_balistreri@douglashills.name   | Theron Nolan        |      1 | 1985-03-07 | What I bought is hard to use.               |
| 51 | jacinda.douglas@ortizschmitt.org     | Justin Dickens      |      2 | 1996-09-28 | This is easy to use.                        |
| 52 | zella@gutmannvandervort.org          | Dr. Gene Steuber    |      1 | 1967-07-11 | This is hard to use.                        |
| 52 | zella@gutmannvandervort.org          | Dr. Gene Steuber    |      1 | 1967-07-11 | This is hard to use.                        |
| 55 | darwin_rice@gerholdhansen.name       | Norris Koss         |      1 | 1968-05-15 | This is has good cost performance.          |
| 60 | vaughn_brekke@ratkemcclure.info      | Fran Reynolds       |      1 | 1961-03-30 | This product is easy to use.                |
| 62 | georgianne.jacobs@koepp.net          | Luis Aufderhar DDS  |      0 | 1978-01-26 | What I bought is easy to use.               |
| 62 | georgianne.jacobs@koepp.net          | Luis Aufderhar DDS  |      0 | 1978-01-26 | This product is hard to use.                |
| 62 | georgianne.jacobs@koepp.net          | Luis Aufderhar DDS  |      0 | 1978-01-26 | What I bought is easy to use.               |
| 63 | starla_watsica@vonrueden.org         | Otelia Kirlin       |      0 | 2004-06-22 | This product is disappointing.              |
| 63 | starla_watsica@vonrueden.org         | Otelia Kirlin       |      0 | 2004-06-22 | This product is hard to use.                |
| 63 | starla_watsica@vonrueden.org         | Otelia Kirlin       |      0 | 2004-06-22 | What I bought is has good cost performance. |
| 67 | dennis.blick@kohler.com              | Danette Collins     |      1 | 1965-03-13 | This product is has good cost performance.  |
| 70 | jenna_kemmer@mcclure.co              | Barbara Kozey       |      1 | 1980-05-08 | What I bought is easy to use.               |
| 71 | ismael.waelchi@vonmccullough.com     | Loree Zboncak       |      2 | 1981-07-05 | What I bought is disappointing.             |
| 71 | ismael.waelchi@vonmccullough.com     | Loree Zboncak       |      2 | 1981-07-05 | What I bought is has good cost performance. |
| 73 | angle@emardfay.com                   | Clifton Nitzsche    |      1 | 1976-07-26 | What I bought is disappointing.             |
| 74 | clifton_terry@leffler.org            | Lanny Boyer         |      1 | 1988-07-30 | This product is disappointing.              |
| 74 | clifton_terry@leffler.org            | Lanny Boyer         |      1 | 1988-07-30 | This is disappointing.                      |
| 76 | raye.spencer@lowe.io                 | Al Gottlieb         |      1 | 2002-09-13 | What I bought is easy to use.               |
| 76 | raye.spencer@lowe.io                 | Al Gottlieb         |      1 | 2002-09-13 | What I bought is hard to use.               |
| 77 | hyman@davis.co                       | Ta Jerde I          |      0 | 1994-07-22 | This product is hard to use.                |
| 82 | arron@grant.io                       | Elmira White        |      1 | 1999-03-14 | What I bought is hard to use.               |
| 83 | pearl@thompsonmorar.name             | Danyell Price       |      0 | 2004-10-21 | This is has good cost performance.          |
| 83 | pearl@thompsonmorar.name             | Danyell Price       |      0 | 2004-10-21 | This product is hard to use.                |
| 84 | trena.hauck@gottlieb.io              | Lanita Zboncak      |      0 | 1994-05-17 | What I bought is easy to use.               |
| 86 | columbus@vandervortfeest.name        | Shawanda McGlynn    |      1 | 1966-06-08 | What I bought is has good cost performance. |
| 89 | rocio@gleichnerschiller.info         | Dorian Gislason     |      0 | 2004-04-09 | What I bought is disappointing.             |
| 90 | rae.streich@ruecker.org              | Annetta Friesen II  |      0 | 1979-07-20 | This product is disappointing.              |
| 90 | rae.streich@ruecker.org              | Annetta Friesen II  |      0 | 1979-07-20 | What I bought is easy to use.               |
| 91 | berniece@daugherty.io                | Rickie Littel       |      2 | 1978-11-05 | What I bought is hard to use.               |
| 92 | galen@wiegandmaggio.biz              | Truman Rogahn       |      0 | 1960-05-11 | This product is easy to use.                |
| 94 | devora.douglas@nolanschowalter.co    | Pablo Huels Jr.     |      1 | 1967-08-27 | This is disappointing.                      |
| 95 | weldon@kaulke.name                   | Leonardo Turner     |      1 | 2004-11-13 | This is has good cost performance.          |
| 99 | dennis@buckridge.co                  | Domingo Herman      |      0 | 1981-02-28 | This product is easy to use.                |
| 99 | dennis@buckridge.co                  | Domingo Herman      |      0 | 1981-02-28 | What I bought is has good cost performance. |
+----+--------------------------------------+---------------------+--------+------------+---------------------------------------------+
67 rows in set (0.01 sec)

```

### 演習2

男性(0)、女性(1)、どちらでもない(2)という性別の値がusersテーブルのgenderカラムに入力されています。それぞれの性別でグループ化をして注文総数(amount)をジェンダー別に合計してください
その上で、さらに平均値、最大、最小に集計結果を分けてデータを抽出してください。

```mysql
mysql> DESC users
    -> ;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | bigint(20)   | NO   | PRI | NULL    | auto_increment |
| email      | varchar(255) | NO   |     | NULL    |                |
| name       | varchar(255) | NO   |     | NULL    |                |
| gender     | tinyint(4)   | NO   |     | NULL    |                |
| birthday   | date         | NO   |     | NULL    |                |
| created_at | datetime(6)  | NO   |     | NULL    |                |
| updated_at | datetime(6)  | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
7 rows in set (0.01 sec)

mysql> DESC order_details;
+------------+------------------+------+-----+---------+----------------+
| Field      | Type             | Null | Key | Default | Extra          |
+------------+------------------+------+-----+---------+----------------+
| id         | bigint(20)       | NO   | PRI | NULL    | auto_increment |
| order_id   | bigint(20)       | NO   | MUL | NULL    |                |
| product_id | bigint(20)       | NO   | MUL | NULL    |                |
| amount     | int(10) unsigned | NO   |     | NULL    |                |
| created_at | datetime(6)      | NO   |     | NULL    |                |
| updated_at | datetime(6)      | NO   |     | NULL    |                |
+------------+------------------+------+-----+---------+----------------+
6 rows in set (0.01 sec)

mysql> DESC orders;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | bigint(20)  | NO   | PRI | NULL    | auto_increment |
| user_id    | bigint(20)  | NO   | MUL | NULL    |                |
| created_at | datetime(6) | NO   |     | NULL    |                |
| updated_at | datetime(6) | NO   |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
4 rows in set (0.01 sec)



```

```mysql
mysql> SELECT
    ->     users.gender,
    ->     SUM(order_details.amount)
    -> FROM    
    ->     users
    -> INNER JOIN
    ->     orders
    -> ON
    ->     users.id = orders.user_id
    -> INNER JOIN
    ->     order_details
    -> ON
    ->     orders.id = order_details.order_id
    -> GROUP BY users.gender;
+--------+---------------------------+
| gender | SUM(order_details.amount) |
+--------+---------------------------+
|      0 |                       536 |
|      1 |                       483 |
|      2 |                       201 |
+--------+---------------------------+


mysql> SELECT
    ->     users.gender,
    ->     SUM(order_details.amount),
    ->     AVG(order_details.amount),
    ->     MIN(order_details.amount),
    ->     MAX(order_details.amount)
    -> FROM    
    ->     users
    -> INNER JOIN
    ->     orders
    -> ON
    ->     users.id = orders.user_id
    -> INNER JOIN
    ->     order_details
    -> ON
    ->     orders.id = order_details.order_id
    -> GROUP BY users.gender;
+--------+---------------------------+---------------------------+---------------------------+---------------------------+
| gender | SUM(order_details.amount) | AVG(order_details.amount) | MIN(order_details.amount) | MAX(order_details.amount) |
+--------+---------------------------+---------------------------+---------------------------+---------------------------+
|      0 |                       536 |                    2.0150 |                         1 |                         3 |
|      1 |                       483 |                    2.0209 |                         1 |                         3 |
|      2 |                       201 |                    2.0722 |                         1 |                         3 |
+--------+---------------------------+---------------------------+---------------------------+---------------------------+
3 rows in set (0.01 sec)


mysql> SELECT
    ->     AVG(Sub.sum),
    ->     MIN(Sub.sum),
    ->     MAX(Sub.sum)
    -> FROM
    ->     (
    ->     SELECT
    ->         SUM(order_details.amount) AS sum
    ->     FROM
    ->         users
    ->     INNER JOIN
    ->         orders
    ->     ON
    ->         users.id = orders.user_id
    ->     INNER JOIN
    ->     order_details
    ->     ON
    ->         orders.id = order_details.order_id
    ->     GROUP BY
    ->         users.gender
    ->     ) AS Sub;
+--------------+--------------+--------------+
| AVG(Sub.sum) | MIN(Sub.sum) | MAX(Sub.sum) |
+--------------+--------------+--------------+
|     406.6667 |          201 |          536 |
+--------------+--------------+--------------+
1 row in set (0.01 sec)
```


### 演習3

悪いレビューを行なっているユーザーをリスト化しようと考えています。
Product_idが7版の製品に対して、disappointingというコメントの有無をEXISTSを利用して確認し、その上でIN区を利用してそのユーザを特定してください。

```mysql
mysql> select * from product_reviews where body like '%disappointing%' && product_id = 7;
+-----+------------+---------+---------------------------------+----------------------------+----------------------------+
| id  | product_id | user_id | body                            | created_at                 | updated_at                 |
+-----+------------+---------+---------------------------------+----------------------------+----------------------------+
|  23 |          7 |      41 | What I bought is disappointing. | 2020-04-07 04:34:19.838863 | 2020-04-07 04:34:19.838863 |
|  35 |          7 |      18 | This product is disappointing.  | 2020-04-07 04:34:19.869946 | 2020-04-07 04:34:19.869946 |
|  53 |          7 |      14 | This product is disappointing.  | 2020-04-07 04:34:19.926729 | 2020-04-07 04:34:19.926729 |
|  59 |          7 |      47 | What I bought is disappointing. | 2020-04-07 04:34:19.940286 | 2020-04-07 04:34:19.940286 |
| 113 |          7 |      24 | This product is disappointing.  | 2020-04-07 04:34:20.062802 | 2020-04-07 04:34:20.062802 |
| 143 |          7 |      31 | This is disappointing.          | 2020-04-07 04:34:20.126227 | 2020-04-07 04:34:20.126227 |
| 221 |          7 |      23 | This is disappointing.          | 2020-04-07 04:34:20.319943 | 2020-04-07 04:34:20.319943 |
| 227 |          7 |      96 | This is disappointing.          | 2020-04-07 04:34:20.333090 | 2020-04-07 04:34:20.333090 |
| 269 |          7 |      25 | This product is disappointing.  | 2020-04-07 04:34:20.413756 | 2020-04-07 04:34:20.413756 |
| 281 |          7 |      51 | What I bought is disappointing. | 2020-04-07 04:34:20.449427 | 2020-04-07 04:34:20.449427 |
| 287 |          7 |      63 | What I bought is disappointing. | 2020-04-07 04:34:20.460593 | 2020-04-07 04:34:20.460593 |
| 317 |          7 |      95 | What I bought is disappointing. | 2020-04-07 04:34:20.525443 | 2020-04-07 04:34:20.525443 |
| 323 |          7 |      96 | This product is disappointing.  | 2020-04-07 04:34:20.537935 | 2020-04-07 04:34:20.537935 |
| 341 |          7 |      69 | What I bought is disappointing. | 2020-04-07 04:34:20.586559 | 2020-04-07 04:34:20.586559 |
| 371 |          7 |       7 | This is disappointing.          | 2020-04-07 04:34:20.647021 | 2020-04-07 04:34:20.647021 |
| 401 |          7 |      63 | What I bought is disappointing. | 2020-04-07 04:34:20.722856 | 2020-04-07 04:34:20.722856 |
+-----+------------+---------+---------------------------------+----------------------------+----------------------------+

```

### 回答
```mysql
mysql> SELECT
    ->     *
    -> FROM
    ->     users
    -> WHERE EXISTS
    ->     (
    ->     SELECT
    ->         user_id
    -> FROM
    ->         product_reviews
    -> WHERE
    ->         product_id = 7
    -> AND
    ->         body
    -> LIKE
    ->         '%disappointing%'
    -> )
    -> ORDER BY
    -> id;
+-----+--------------------------------------+----------------------+--------+------------+----------------------------+----------------------------+
| id  | email                                | name                 | gender | birthday   | created_at                 | updated_at                 |
+-----+--------------------------------------+----------------------+--------+------------+----------------------------+----------------------------+
|   1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 | 2020-04-07 04:33:58.399121 | 2020-04-07 04:33:58.399121 |
|   2 | louis.price@borer.co                 | Sudie Waelchi        |      1 | 1999-07-24 | 2020-04-07 04:33:58.402440 | 2020-04-07 04:33:58.402440 |
|   3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 | 2020-04-07 04:33:58.405399 | 2020-04-07 04:33:58.405399 |
|   4 | michael@grant.org                    | Roy Yundt Jr.        |      0 | 1994-06-16 | 2020-04-07 04:33:58.407876 | 2020-04-07 04:33:58.407876 |
|   5 | fredrick_boyle@goyette.org           | Golden Kunde         |      1 | 1998-05-02 | 2020-04-07 04:33:58.410394 | 2020-04-07 04:33:58.410394 |
|   6 | felipe@nitzsche.name                 | Thaddeus Ledner      |      0 | 1962-07-30 | 2020-04-07 04:33:58.412617 | 2020-04-07 04:33:58.412617 |
|   7 | lesley_mitchell@damore.net           | Miss Rudy VonRueden  |      0 | 1968-03-08 | 2020-04-07 04:33:58.414754 | 2020-04-07 04:33:58.414754 |
|   8 | phyli.huel@boyer.co                  | Drusilla Larson      |      0 | 1964-11-26 | 2020-04-07 04:33:58.416812 | 2020-04-07 04:33:58.416812 |
|   9 | dirk.pagac@rosenbaumdaugherty.net    | Kip Raynor Jr.       |      1 | 1964-07-20 | 2020-04-07 04:33:58.418895 | 2020-04-07 04:33:58.418895 |
|  10 | linwood.vonrueden@hueljones.biz      | Coy Swaniawski       |      1 | 1978-03-12 | 2020-04-07 04:33:58.420987 | 2020-04-07 04:33:58.420987 |
...........
|  86 | columbus@vandervortfeest.name        | Shawanda McGlynn     |      1 | 1966-06-08 | 2020-04-07 04:33:58.626238 | 2020-04-07 04:33:58.626238 |
|  87 | cruz@runte.net                       | Earnest Erdman       |      0 | 1977-07-06 | 2020-04-07 04:33:58.628179 | 2020-04-07 04:33:58.628179 |
|  88 | marion@heel.co                       | Hermina Wiegand      |      0 | 1974-03-03 | 2020-04-07 04:33:58.630342 | 2020-04-07 04:33:58.630342 |
|  89 | rocio@gleichnerschiller.info         | Dorian Gislason      |      0 | 2004-04-09 | 2020-04-07 04:33:58.632453 | 2020-04-07 04:33:58.632453 |
|  90 | rae.streich@ruecker.org              | Annetta Friesen II   |      0 | 1979-07-20 | 2020-04-07 04:33:58.635035 | 2020-04-07 04:33:58.635035 |
|  91 | berniece@daugherty.io                | Rickie Littel        |      2 | 1978-11-05 | 2020-04-07 04:33:58.637453 | 2020-04-07 04:33:58.637453 |
|  92 | galen@wiegandmaggio.biz              | Truman Rogahn        |      0 | 1960-05-11 | 2020-04-07 04:33:58.639826 | 2020-04-07 04:33:58.639826 |
|  93 | kermit@vonshanahan.biz               | Soraya Luettgen      |      1 | 1963-11-30 | 2020-04-07 04:33:58.642277 | 2020-04-07 04:33:58.642277 |
|  94 | devora.douglas@nolanschowalter.co    | Pablo Huels Jr.      |      1 | 1967-08-27 | 2020-04-07 04:33:58.644634 | 2020-04-07 04:33:58.644634 |
|  95 | weldon@kaulke.name                   | Leonardo Turner      |      1 | 2004-11-13 | 2020-04-07 04:33:58.646703 | 2020-04-07 04:33:58.646703 |
|  96 | merna@steuberreilly.biz              | Augustine Cassin     |      1 | 1997-07-08 | 2020-04-07 04:33:58.648822 | 2020-04-07 04:33:58.648822 |
|  97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 | 2020-04-07 04:33:58.650878 | 2020-04-07 04:33:58.650878 |
|  98 | valery@reilly.org                    | Maurice Koss         |      0 | 1987-03-25 | 2020-04-07 04:33:58.653008 | 2020-04-07 04:33:58.653008 |
|  99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 | 2020-04-07 04:33:58.654985 | 2020-04-07 04:33:58.654985 |
| 100 | hyman.boyer@mayert.name              | Barton Stracke       |      0 | 1995-03-24 | 2020-04-07 04:33:58.656992 | 2020-04-07 04:33:58.656992 |
+-----+--------------------------------------+----------------------+--------+------------+----------------------------+----------------------------+
100 rows in set (0.01 sec)

```
```mysql
mysql> SELECT
    ->     *
    -> FROM
    ->     users
    -> WHERE
    ->     id
    -> IN
    ->     (
    ->     SELECT
    ->         user_id
    -> FROM
    ->         product_reviews
    -> WHERE
    ->         product_id = 7
    -> AND
    ->         body
    -> LIKE
    ->         '%disappointing%'
    -> )
    -> ORDER BY
    -> id;
+----+-----------------------------------+---------------------+--------+------------+----------------------------+----------------------------+
| id | email                             | name                | gender | birthday   | created_at                 | updated_at                 |
+----+-----------------------------------+---------------------+--------+------------+----------------------------+----------------------------+
|  7 | lesley_mitchell@damore.net        | Miss Rudy VonRueden |      0 | 1968-03-08 | 2020-04-07 04:33:58.414754 | 2020-04-07 04:33:58.414754 |
| 14 | silva@cremin.org                  | Ivory King          |      0 | 1963-05-10 | 2020-04-07 04:33:58.429979 | 2020-04-07 04:33:58.429979 |
| 18 | milan.koch@crooksyundt.info       | Irvin Balistreri    |      1 | 1995-02-16 | 2020-04-07 04:33:58.438480 | 2020-04-07 04:33:58.438480 |
| 23 | gregg.jacobs@baileyherzog.name    | Andera Torp         |      0 | 1997-11-17 | 2020-04-07 04:33:58.449924 | 2020-04-07 04:33:58.449924 |
| 24 | grover.beatty@gottliebrunolfon.co | Sarina Langworth    |      1 | 1967-02-17 | 2020-04-07 04:33:58.452099 | 2020-04-07 04:33:58.452099 |
| 25 | moses@lebsackharris.co            | Mr. Mckinley West   |      0 | 1966-08-29 | 2020-04-07 04:33:58.454415 | 2020-04-07 04:33:58.454415 |
| 31 | sherron@rowe.net                  | Tameka Hayes I      |      2 | 1989-01-05 | 2020-04-07 04:33:58.468569 | 2020-04-07 04:33:58.468569 |
| 41 | dudley.turner@wuckert.biz         | Ms. Bart Lowe       |      2 | 1992-01-14 | 2020-04-07 04:33:58.500957 | 2020-04-07 04:33:58.500957 |
| 47 | annamarie@abernathy.co            | Aleida Ruecker      |      0 | 1996-06-26 | 2020-04-07 04:33:58.513845 | 2020-04-07 04:33:58.513845 |
| 51 | jacinda.douglas@ortizschmitt.org  | Justin Dickens      |      2 | 1996-09-28 | 2020-04-07 04:33:58.523053 | 2020-04-07 04:33:58.523053 |
| 63 | starla_watsica@vonrueden.org      | Otelia Kirlin       |      0 | 2004-06-22 | 2020-04-07 04:33:58.565941 | 2020-04-07 04:33:58.565941 |
| 69 | quinn@franeckiratke.info          | Kurt Abernathy I    |      1 | 1977-04-11 | 2020-04-07 04:33:58.587654 | 2020-04-07 04:33:58.587654 |
| 95 | weldon@kaulke.name                | Leonardo Turner     |      1 | 2004-11-13 | 2020-04-07 04:33:58.646703 | 2020-04-07 04:33:58.646703 |
| 96 | merna@steuberreilly.biz           | Augustine Cassin    |      1 | 1997-07-08 | 2020-04-07 04:33:58.648822 | 2020-04-07 04:33:58.648822 |
+----+-----------------------------------+---------------------+--------+------------+----------------------------+----------------------------+
14 rows in set (0.01 sec)


```
### 演習4

演習3で実施したリストを活用します。

1. ユーザの注文データを利用して、ユーザーの個人情報と注文した商品の発注数を合わせた注文履歴リストを作成します。その際にusersテーブルから、id、name、email、gender、birthdayの5つを取得し、order_detailsテーブルからproduct_idとamountを取得します。
2. 注文履歴リストに対して、注文した商品名と合計金額（税込み／税別）がわかるようにリストにデータを追加してください。結果はuser_idで昇順で表示されるようにします。
3. ユーザ毎の合計発注金額を抽出してください。その際に、これまでの合計注文数がわかるようにしてください。
4. 最後にユーザ毎の合計発注金額がproductsテーブルにある製品価格(price)の合計金額よりも少ないデータを抽出してください。

#### 1

```mysql
mysql> SELECT
    ->     users.id,
    ->     users.name,
    ->     users.email,
    ->     users.gender,
    ->     users.birthday,
    ->     order_details.product_id,
    ->     order_details.amount
    -> FROM
    ->     users
    -> LEFT JOIN
    ->     orders
    -> ON
    ->     users.id = orders.user_id
    -> INNER JOIN
    ->     order_details
    -> ON
    ->     orders.id = order_details.order_id
    -> ;
+----+----------------------+--------------------------------------+--------+------------+------------+--------+
| id | name                 | email                                | gender | birthday   | product_id | amount |
+----+----------------------+--------------------------------------+--------+------------+------------+--------+
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |          4 |      3 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |          5 |      3 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |          6 |      2 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |          2 |      1 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |          3 |      2 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |          4 |      2 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |          5 |      3 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |          6 |      1 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |          1 |      3 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |          2 |      3 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |          3 |      3 |
|  2 | Sudie Waelchi        | louis.price@borer.co                 |      1 | 1999-07-24 |          4 |      1 |
|  2 | Sudie Waelchi        | louis.price@borer.co                 |      1 | 1999-07-24 |          5 |      2 |
|  2 | Sudie Waelchi        | louis.price@borer.co                 |      1 | 1999-07-24 |          2 |      2 |
.......
| 97 | Velva Nolan          | yen_dickinson@kuhicdubuque.co        |      1 | 2001-11-26 |          9 |      1 |
| 97 | Velva Nolan          | yen_dickinson@kuhicdubuque.co        |      1 | 2001-11-26 |          1 |      2 |
| 97 | Velva Nolan          | yen_dickinson@kuhicdubuque.co        |      1 | 2001-11-26 |          2 |      3 |
| 97 | Velva Nolan          | yen_dickinson@kuhicdubuque.co        |      1 | 2001-11-26 |          3 |      1 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 |          3 |      1 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 |          4 |      1 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 |          5 |      2 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 |          4 |      3 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 |          5 |      3 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 |          1 |      3 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 |          2 |      3 |
+----+----------------------+--------------------------------------+--------+------------+------------+--------+
602 rows in set (0.01 sec
```

#### 2.

```mysql
mysql> SELECT
    ->     users.id,
    ->     users.name,
    ->     users.email,
    ->     users.gender,
    ->     users.birthday,
    ->     products.name AS product_name,
    ->     order_details.amount,
    ->     order_details.amount * products.price AS fee,
    ->     order_details.amount * products.price * 1.1 AS tax_included
    -> FROM
    ->     users
    -> LEFT JOIN
    ->     orders
    -> ON
    ->     users.id = orders.user_id
    -> INNER JOIN
    ->     order_details
    -> ON
    ->     orders.id = order_details.order_id
    -> INNER JOIN
    ->     products
    -> ON
    ->     order_details.product_id = products.id
    -> ORDER BY
    ->     users.id
    -> ;
+----+----------------------+--------------------------------------+--------+------------+------------------------+--------+------+--------------+
| id | name                 | email                                | gender | birthday   | product_name           | amount | fee  | tax_included |
+----+----------------------+--------------------------------------+--------+------------+------------------------+--------+------+--------------+
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Mangle (machine)       |      3 |  120 |        132.0 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Mangle (machine)       |      2 |   80 |         88.0 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Window fan             |      3 |   36 |         39.6 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Window fan             |      1 |   12 |         13.2 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Evaporative cooler     |      2 |   76 |         83.6 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Evaporative cooler     |      3 |  114 |        125.4 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Refrigerator           |      3 | 2094 |       2303.4 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Refrigerator           |      3 | 2094 |       2303.4 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Central vacuum cleaner |      2 |  190 |        209.0 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Central vacuum cleaner |      1 |   95 |        104.5 |
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Water cooker           |      3 |  147 |        161.7 |
|  2 | Sudie Waelchi        | louis.price@borer.co                 |      1 | 1999-07-24 | Evaporative cooler     |      1 |   38 |         41.8 |
|  2 | Sudie Waelchi        | louis.price@borer.co                 |      1 | 1999-07-24 | Refrigerator           |      2 | 1396 |       1535.6 |
|  2 | Sudie Waelchi        | louis.price@borer.co                 |      1 | 1999-07-24 | Window fan             |      2 |   24 |         26.4 |
...........
| 97 | Velva Nolan          | yen_dickinson@kuhicdubuque.co        |      1 | 2001-11-26 | Futon dryer            |      1 |   25 |         27.5 |
| 97 | Velva Nolan          | yen_dickinson@kuhicdubuque.co        |      1 | 2001-11-26 | Window fan             |      3 |   36 |         39.6 |
| 97 | Velva Nolan          | yen_dickinson@kuhicdubuque.co        |      1 | 2001-11-26 | Mangle (machine)       |      1 |   40 |         44.0 |
| 97 | Velva Nolan          | yen_dickinson@kuhicdubuque.co        |      1 | 2001-11-26 | Water cooker           |      2 |   98 |        107.8 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 | Water cooker           |      3 |  147 |        161.7 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 | Evaporative cooler     |      3 |  114 |        125.4 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 | Evaporative cooler     |      1 |   38 |         41.8 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 | Refrigerator           |      2 | 1396 |       1535.6 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 | Refrigerator           |      3 | 2094 |       2303.4 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 | Window fan             |      3 |   36 |         39.6 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 | Mangle (machine)       |      1 |   40 |         44.0 |
+----+----------------------+--------------------------------------+--------+------------+------------------------+--------+------+--------------+
602 rows in set (0.02 sec)


```

#### 3

```mysql
mysql> SELECT
    ->     users.id,
    ->     users.name,
    ->     users.email,
    ->     users.gender,
    ->     users.birthday,
    ->     products.name AS product_name,
    ->     COUNT(orders.id) AS order_count,
    ->     sum(order_details.amount) AS sum_amount,
    ->     SUM(order_details.amount * products.price) AS sum_fee,
    ->     SUM(order_details.amount * products.price * 1.1) AS sum_tax_included
    -> FROM
    ->     users
    -> LEFT JOIN
    ->     orders
    -> ON
    ->     users.id = orders.user_id
    -> INNER JOIN
    ->     order_details
    -> ON
    ->     orders.id = order_details.order_id
    -> INNER JOIN
    ->     products
    -> ON
    ->     order_details.product_id = products.id
    -> GROUP BY
    ->     users.id
    -> ORDER BY
    ->     users.id
    -> ;
+----+----------------------+--------------------------------------+--------+------------+------------------------+-------------+------------+---------+------------------+
| id | name                 | email                                | gender | birthday   | product_name           | order_count | sum_amount | sum_fee | sum_tax_included |
+----+----------------------+--------------------------------------+--------+------------+------------------------+-------------+------------+---------+------------------+
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 | Water cooker           |          11 |         26 |    5058 |           5563.8 |
|  2 | Sudie Waelchi        | louis.price@borer.co                 |      1 | 1999-07-24 | Window fan             |           3 |          5 |    1458 |           1603.8 |
|  3 | Desire Osinski Sr.   | joaquin.koepp@sawaynschuster.io      |      1 | 2002-03-09 | Water cooker           |           9 |         21 |    2482 |           2730.2 |
|  4 | Roy Yundt Jr.        | michael@grant.org                    |      0 | 1994-06-16 | Mangle (machine)       |           2 |          4 |     154 |            169.4 |
|  5 | Golden Kunde         | fredrick_boyle@goyette.org           |      1 | 1998-05-02 | Water cooker           |          16 |         31 |    2367 |           2603.7 |
|  6 | Thaddeus Ledner      | felipe@nitzsche.name                 |      0 | 1962-07-30 | Water cooker           |           5 |         12 |     306 |            336.6 |
|  7 | Miss Rudy VonRueden  | lesley_mitchell@damore.net           |      0 | 1968-03-08 | Window fan             |          11 |         23 |    6531 |           7184.1 |
|  8 | Drusilla Larson      | phyli.huel@boyer.co                  |      0 | 1964-11-26 | Window fan             |           8 |         16 |    4576 |           5033.6 |
|  9 | Kip Raynor Jr.       | dirk.pagac@rosenbaumdaugherty.net    |      1 | 1964-07-20 | Window fan             |           6 |         12 |    1561 |           1717.1 |
| 10 | Coy Swaniawski       | linwood.vonrueden@hueljones.biz      |      1 | 1978-03-12 | Water cooker           |           3 |          6 |     178 |            195.8 |
..........
| 84 | Lanita Zboncak       | trena.hauck@gottlieb.io              |      0 | 1994-05-17 | Window fan             |           6 |         11 |    1032 |           1135.2 |
| 86 | Shawanda McGlynn     | columbus@vandervortfeest.name        |      1 | 1966-06-08 | Refrigerator           |           3 |          6 |    2149 |           2363.9 |
| 88 | Hermina Wiegand      | marion@heel.co                       |      0 | 1974-03-03 | Water cooker           |           6 |         12 |    1112 |           1223.2 |
| 89 | Dorian Gislason      | rocio@gleichnerschiller.info         |      0 | 2004-04-09 | Water cooker           |          13 |         19 |    1247 |           1371.7 |
| 90 | Annetta Friesen II   | rae.streich@ruecker.org              |      0 | 1979-07-20 | Evaporative cooler     |           5 |         10 |    3694 |           4063.4 |
| 91 | Rickie Littel        | berniece@daugherty.io                |      2 | 1978-11-05 | Mangle (machine)       |           4 |         10 |    2362 |           2598.2 |
| 92 | Truman Rogahn        | galen@wiegandmaggio.biz              |      0 | 1960-05-11 | Water cooker           |           3 |          7 |    2242 |           2466.2 |
| 93 | Soraya Luettgen      | kermit@vonshanahan.biz               |      1 | 1963-11-30 | Water cooker           |           5 |         10 |     221 |            243.1 |
| 94 | Pablo Huels Jr.      | devora.douglas@nolanschowalter.co    |      1 | 1967-08-27 | Water cooker           |          10 |         22 |    1256 |           1381.6 |
| 95 | Leonardo Turner      | weldon@kaulke.name                   |      1 | 2004-11-13 | Water cooker           |           8 |         20 |    3109 |           3419.9 |
| 96 | Augustine Cassin     | merna@steuberreilly.biz              |      1 | 1997-07-08 | Water cooker           |           6 |         13 |    3452 |           3797.2 |
| 97 | Velva Nolan          | yen_dickinson@kuhicdubuque.co        |      1 | 2001-11-26 | Water cooker           |           4 |          7 |     199 |            218.9 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 | Water cooker           |           7 |         16 |    3865 |           4251.5 |
+----+----------------------+--------------------------------------+--------+------------+------------------------+-------------+------------+---------+------------------+
90 rows in set (0.01 sec)


```

#### 4

```mysql

mysql> SELECT
    ->     users.id,
    ->     users.name,
    ->     users.email,
    ->     users.gender,
    ->     users.birthday,
    ->     order_details.amount * products.price AS fee,
    ->     order_details.amount * products.price * 1.1 AS tax_included
    -> FROM
    ->     users
    -> INNER JOIN
    ->     orders
    -> ON
    ->     users.id = orders.user_id
    -> INNER JOIN
    ->     order_details
    -> ON
    ->     orders.id = order_details.order_id
    -> INNER JOIN
    ->     products
    -> ON
    ->     order_details.product_id = products.id
    -> GROUP BY
    ->     users.id
    -> HAVING
    ->     SUM(amount * price ) <
    ->     (
    ->     SELECT
    ->         SUM(price)
    -> FROM
    ->         products
    -> )
    -> ORDER BY
    ->     users.id
    -> ;
+----+----------------------+--------------------------------------+--------+------------+------+--------------+
| id | name                 | email                                | gender | birthday   | fee  | tax_included |
+----+----------------------+--------------------------------------+--------+------------+------+--------------+
|  2 | Sudie Waelchi        | louis.price@borer.co                 |      1 | 1999-07-24 |   24 |         26.4 |
|  4 | Roy Yundt Jr.        | michael@grant.org                    |      0 | 1994-06-16 |   40 |         44.0 |
|  6 | Thaddeus Ledner      | felipe@nitzsche.name                 |      0 | 1962-07-30 |  147 |        161.7 |
| 10 | Coy Swaniawski       | linwood.vonrueden@hueljones.biz      |      1 | 1978-03-12 |   98 |        107.8 |
| 21 | Agnes Stehr          | chia@mann.org                        |      2 | 1961-05-01 | 1196 |       1315.6 |
| 23 | Andera Torp          | gregg.jacobs@baileyherzog.name       |      0 | 1997-11-17 |  598 |        657.8 |
| 24 | Sarina Langworth     | grover.beatty@gottliebrunolfon.co    |      1 | 1967-02-17 |   80 |         88.0 |
| 28 | Joshua Block         | kurtis_fadel@leuschkehills.io        |      1 | 1994-08-13 |   12 |         13.2 |
| 30 | Elinor Gleichner     | marianna.metz@schuster.co            |      0 | 1990-12-10 |   49 |         53.9 |
| 33 | Myrtie Ullrich       | normand@whiteoconner.co              |      0 | 2004-04-11 |   98 |        107.8 |
| 34 | Nydia Marquardt IV   | christopher@bergstrom.net            |      1 | 2003-04-03 |  147 |        161.7 |
| 35 | Mrs. Edra Herman     | cecily@blick.org                     |      0 | 1996-07-07 |  120 |        132.0 |
| 39 | Denver Beier         | luz@schimmel.net                     |      0 | 1985-09-30 |   38 |         41.8 |
| 40 | Royal Williamson     | malcom@kohler.org                    |      0 | 1997-09-16 |   24 |         26.4 |
| 43 | Melvina Balistreri   | lanie@purdy.net                      |      0 | 1965-04-26 |   49 |         53.9 |
| 49 | Jonathon Armstrong   | brain@waterscummerata.name           |      0 | 1992-09-06 |   95 |        104.5 |
| 50 | Theron Nolan         | gerry_balistreri@douglashills.name   |      1 | 1985-03-07 |   24 |         26.4 |
| 54 | Farrah Bruen         | karmen@mcclure.info                  |      1 | 1980-12-18 |  147 |        161.7 |
| 55 | Norris Koss          | darwin_rice@gerholdhansen.name       |      1 | 1968-05-15 |   98 |        107.8 |
| 56 | Lyda Dare III        | lilli.buckridge@johnstonkuhlman.co   |      0 | 2003-02-01 |   98 |        107.8 |
| 57 | Iva Leuschke Jr.     | sabra_heaney@crona.biz               |      1 | 1993-08-26 |   98 |        107.8 |
| 58 | Dr. Sunny Marks      | efrain_abbott@jacobsnitzsche.net     |      0 | 1969-01-26 |  147 |        161.7 |
| 59 | Kristopher Rohan     | rosalba@lakinrau.org                 |      0 | 1975-10-14 |  147 |        161.7 |
| 60 | Fran Reynolds        | vaughn_brekke@ratkemcclure.info      |      1 | 1961-03-30 |   38 |         41.8 |
| 64 | Francisca Konopelski | laurence_price@klingblick.io         |      1 | 1973-05-03 |   98 |        107.8 |
| 65 | Dr. Joana Kertzmann  | wallace@blanda.org                   |      0 | 1961-12-19 |   98 |        107.8 |
| 66 | Randolph Corwin      | macy@daugherty.com                   |      0 | 1994-09-07 |   98 |        107.8 |
| 68 | Gerald Farrell       | mimi@hyatt.biz                       |      1 | 1968-03-15 |   10 |         11.0 |
| 72 | Margarette Osinski   | amanda_weinat@boganlueilwitz.com     |      1 | 1964-01-30 |  147 |        161.7 |
| 75 | Junior Auer          | vannesa_homenick@lindgrenhickle.name |      0 | 1984-01-19 |   36 |         39.6 |
| 77 | Ta Jerde I           | hyman@davis.co                       |      0 | 1994-07-22 |   24 |         26.4 |
| 78 | Junior Sawayn        | minerva@barton.info                  |      0 | 1969-08-25 |   49 |         53.9 |
| 79 | Betty Reinger        | leonardo@koeppschumm.info            |      0 | 1962-11-26 |  120 |        132.0 |
| 80 | Jeannetta Labadie    | ernest_haley@whitekautzer.io         |      1 | 1970-04-10 | 1196 |       1315.6 |
| 84 | Lanita Zboncak       | trena.hauck@gottlieb.io              |      0 | 1994-05-17 |   24 |         26.4 |
| 88 | Hermina Wiegand      | marion@heel.co                       |      0 | 1974-03-03 |   49 |         53.9 |
| 89 | Dorian Gislason      | rocio@gleichnerschiller.info         |      0 | 2004-04-09 |   49 |         53.9 |
| 93 | Soraya Luettgen      | kermit@vonshanahan.biz               |      1 | 1963-11-30 |   49 |         53.9 |
| 94 | Pablo Huels Jr.      | devora.douglas@nolanschowalter.co    |      1 | 1967-08-27 |   98 |        107.8 |
| 97 | Velva Nolan          | yen_dickinson@kuhicdubuque.co        |      1 | 2001-11-26 |   98 |        107.8 |
+----+----------------------+--------------------------------------+--------+------------+------+--------------+
40 rows in set (0.01 sec)

```