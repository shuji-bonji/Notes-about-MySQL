# VIEWの活用

複雑なクエリをいつでも呼び出せるように設定して、活用する方法を確認します。

## 単純なVIEW

```mysql
mysql> CREATE VIEW
    ->     user_list AS
    -> SELECT
    ->     *
    -> FROM
    ->     users;
Query OK, 0 rows affected (0.02 sec)

mysql> SELECT * FROM user_list;
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
.......
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

## 結合したテーブルをVIEWとして作成

```mysql
mysql> CREATE VIEW
    ->     order_list AS
    -> SELECT
    ->     users.id,
    ->     users.name,
    ->     users.email,
    ->     users.gender,
    ->     users.birthday,
    ->     SUM(amount * price) AS total_fee,
    ->     SUM(amount * price * 1.1) AS tax_included
    -> FROM
    ->     users
    -> LEFT JOIN
    ->     orders
    -> ON
    ->     users.id = orders.user_id
    -> INNER JOIN
    ->     order_details
    -> ON
    -> orders.id = order_details.order_id
    -> INNER JOIN
    ->     products
    -> ON
    ->     order_details.product_id = products.id
    -> GROUP BY
    ->     users.id;
Query OK, 0 rows affected (0.01 sec)

mysql>     
mysql> SELECT * FROM order_list;
+----+----------------------+--------------------------------------+--------+------------+-----------+--------------+
| id | name                 | email                                | gender | birthday   | total_fee | tax_included |
+----+----------------------+--------------------------------------+--------+------------+-----------+--------------+
|  1 | Erin Casper          | jannie@dach.net                      |      2 | 1976-04-20 |      5058 |       5563.8 |
|  2 | Sudie Waelchi        | louis.price@borer.co                 |      1 | 1999-07-24 |      1458 |       1603.8 |
|  3 | Desire Osinski Sr.   | joaquin.koepp@sawaynschuster.io      |      1 | 2002-03-09 |      2482 |       2730.2 |
|  4 | Roy Yundt Jr.        | michael@grant.org                    |      0 | 1994-06-16 |       154 |        169.4 |
|  5 | Golden Kunde         | fredrick_boyle@goyette.org           |      1 | 1998-05-02 |      2367 |       2603.7 |
|  6 | Thaddeus Ledner      | felipe@nitzsche.name                 |      0 | 1962-07-30 |       306 |        336.6 |
|  7 | Miss Rudy VonRueden  | lesley_mitchell@damore.net           |      0 | 1968-03-08 |      6531 |       7184.1 |
|  8 | Drusilla Larson      | phyli.huel@boyer.co                  |      0 | 1964-11-26 |      4576 |       5033.6 |
|  9 | Kip Raynor Jr.       | dirk.pagac@rosenbaumdaugherty.net    |      1 | 1964-07-20 |      1561 |       1717.1 |
| 10 | Coy Swaniawski       | linwood.vonrueden@hueljones.biz      |      1 | 1978-03-12 |       178 |        195.8 |
..........
| 89 | Dorian Gislason      | rocio@gleichnerschiller.info         |      0 | 2004-04-09 |      1247 |       1371.7 |
| 90 | Annetta Friesen II   | rae.streich@ruecker.org              |      0 | 1979-07-20 |      3694 |       4063.4 |
| 91 | Rickie Littel        | berniece@daugherty.io                |      2 | 1978-11-05 |      2362 |       2598.2 |
| 92 | Truman Rogahn        | galen@wiegandmaggio.biz              |      0 | 1960-05-11 |      2242 |       2466.2 |
| 93 | Soraya Luettgen      | kermit@vonshanahan.biz               |      1 | 1963-11-30 |       221 |        243.1 |
| 94 | Pablo Huels Jr.      | devora.douglas@nolanschowalter.co    |      1 | 1967-08-27 |      1256 |       1381.6 |
| 95 | Leonardo Turner      | weldon@kaulke.name                   |      1 | 2004-11-13 |      3109 |       3419.9 |
| 96 | Augustine Cassin     | merna@steuberreilly.biz              |      1 | 1997-07-08 |      3452 |       3797.2 |
| 97 | Velva Nolan          | yen_dickinson@kuhicdubuque.co        |      1 | 2001-11-26 |       199 |        218.9 |
| 99 | Domingo Herman       | dennis@buckridge.co                  |      0 | 1981-02-28 |      3865 |       4251.5 |
+----+----------------------+--------------------------------------+--------+------------+-----------+--------------+
90 rows in set (0.01 sec)

```

## VIEWの削除

```mysql
mysql> SHOW TABLES;
+----------------------------+
| Tables_in_ecsite           |
+----------------------------+
| case4                      |
| order_details              |
| order_list                 |
| orders                     |
| product_browsing_histories |
| product_review_likes       |
| product_reviews            |
| products                   |
| simpleid                   |
| user_list                  |
| users                      |
+----------------------------+
11 rows in set (0.01 sec)

mysql> DROP VIEW user_list;
Query OK, 0 rows affected (0.00 sec)

mysql> SHOW TABLES;
+----------------------------+
| Tables_in_ecsite           |
+----------------------------+
| case4                      |
| order_details              |
| order_list                 |
| orders                     |
| product_browsing_histories |
| product_review_likes       |
| product_reviews            |
| products                   |
| simpleid                   |
| users                      |
+----------------------------+
10 rows in set (0.00 sec)


```