# テーブル結合

JOINを利用したテーブル間の結合とUNIONを利用したSELECT文の結合を学習します。


## JOIN / UNION

### JOIN

外部キーを利用した結合

### JOINの種類

<table>
	<tr>
		<th colspan="2">JOINのタイプ</th>
		<th>内容</th>
	</tr>
	<tr>
		<td colspan="2">INNER JOIN</td>
		<td>テーブルAとテーブルBで共通のデータを有してるデータのみ抽出する</td>
	</tr>
	<tr>
		<td rowspan="2">OUTHER JOIN</td>
		<td>LEFT JOIN</td>
		<td>共通のデータを有しているデータに加え、左テーブルは無関係なデータを含めて全て抽出する</td>
	</tr>
	<tr>
		<td>RIGHT JOIN</td>
		<td>共通のデータを有しているデータに加え、右テーブルは無関係なデータを含めて全て抽出する</td>
	</tr>
	<tr>
		<td colspan="2">CROSS JOIN</td>
		<td>両テーブルのデータ間の組み合わせを全て抽出する</td>
	</tr>
</table>


### JOIN と UNION

UNIONはSELECT文を結合するコマンドで、縦方向に抽出結果を結合します。

|結合|説明|
|---|----|
|JOIN|テーブルを結合する。<br>他のテーブル／同一のテーブルに事項可能<br>横方向に抽出を都合します。|
|UNION|SELECT文の結果を結合する。<br>他のテーブル／同一テーブルに実行可能<br>縦方向に抽出結果を結合します。|


### 学習用データベースの作成

```mysql
mysql> CREATE DATABASE hr_data;
Query OK, 1 row affected (0.02 sec)

mysql> USE hr_data;
Database changed
mysql> 
mysql> CREATE TABLE employees
    -> (
    ->     employee_id INT(6) PRIMARY KEY,
    ->     last_name VARCHAR(15) NOT NULL,
    ->     first_name VARCHAR(15) NOT NULL,
    ->     sex VARCHAR(1) NOT NULL,
    ->     joining_data DATE NOT NULL,
    ->     age INT(3) NOT NULL,
    ->     department VARCHAR(30) NOT NULL DEFAULT 'unassigned',
    ->     rater INT(5)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> DESE employees;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'DESE employees' at line 1
mysql> DESC employees;
+--------------+-------------+------+-----+------------+-------+
| Field        | Type        | Null | Key | Default    | Extra |
+--------------+-------------+------+-----+------------+-------+
| employee_id  | int(6)      | NO   | PRI | NULL       |       |
| last_name    | varchar(15) | NO   |     | NULL       |       |
| first_name   | varchar(15) | NO   |     | NULL       |       |
| sex          | varchar(1)  | NO   |     | NULL       |       |
| joining_data | date        | NO   |     | NULL       |       |
| age          | int(3)      | NO   |     | NULL       |       |
| department   | varchar(30) | NO   |     | unassigned |       |
| rater        | int(5)      | YES  |     | NULL       |       |
+--------------+-------------+------+-----+------------+-------+
8 rows in set (0.01 sec)

mysql> INSERT INTO employees
    ->     (employee_id, last_name, first_name, sex, joining_data, age, department, rater)
    -> VALUES
    ->     (1001,'Sato','takashi','m',20180401,23,'Sales',1006),
    ->     (1002,'Endo','Maki','w',20160401,24,'HR', 1006),
    ->     (1003,'Kudo','Takaaki','m',20100401,30,'Devlopment', 1005),
    ->     (1004,'Shin','Ando','m',20100401,32,'Devlopment', 1005),
    ->     (1005,'Andy','Bogard','m',20100401,35,'Devlopment',''),
    ->     (1006,'Kow','Murasame','m',20100401,38,'Devlopment','');
Query OK, 6 rows affected, 2 warnings (0.01 sec)
Records: 6  Duplicates: 0  Warnings: 2

mysql> SELECT * FROM employees;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
6 rows in set (0.00 sec)



mysql> INSERT INTO evaluations
    ->     (employee_id, year, rating, explanation)
    -> VALUES
    ->     (1001,2019, 'A','Very good'),
    ->     (1002,2019, 'B','Good'),
    ->     (1003,2019, 'E','Need Training'),
    ->     (1005,2019, 'A','Very good');
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM evaluations;
+----+-------------+------+--------+---------------+
| id | employee_id | year | rating | explanation   |
+----+-------------+------+--------+---------------+
|  1 |        1001 | 2019 | A      | Very good     |
|  2 |        1002 | 2019 | B      | Good          |
|  3 |        1003 | 2019 | E      | Need Training |
|  4 |        1005 | 2019 | A      | Very good     |
+----+-------------+------+--------+---------------+
4 rows in set (0.01 sec)


mysql> CREATE TABLE payrolls
    -> (
    ->     id INT(6) PRIMARY KEY AUTO_INCREMENT,
    ->     employee_id INT(6) NOT NULL,
    ->     position VARCHAR(20) NOT NULL,
    ->     decided_date DATE NOT NULL,
    ->     payroll_rate INT(20) NOT NULL,
    ->     FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> 
mysql> DESC payrolls;
+--------------+-------------+------+-----+---------+----------------+
| Field        | Type        | Null | Key | Default | Extra          |
+--------------+-------------+------+-----+---------+----------------+
| id           | int(6)      | NO   | PRI | NULL    | auto_increment |
| employee_id  | int(6)      | NO   | MUL | NULL    |                |
| position     | varchar(20) | NO   |     | NULL    |                |
| decided_date | date        | NO   |     | NULL    |                |
| payroll_rate | int(20)     | NO   |     | NULL    |                |
+--------------+-------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> INSERT INTO payrolls
    ->     (employee_id, position, decided_date, payroll_rate)
    -> VALUES
    ->     (1001,'Sales staff',20190301,200000),
    ->     (1002,'Leader',20190301,250000),
    ->     (1003,'Manager',20190301,300000),
    ->     (1006,'Manager',20190301,400000);
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM payrolls;
+----+-------------+-------------+--------------+--------------+
| id | employee_id | position    | decided_date | payroll_rate |
+----+-------------+-------------+--------------+--------------+
|  1 |        1001 | Sales staff | 2019-03-01   |       200000 |
|  2 |        1002 | Leader      | 2019-03-01   |       250000 |
|  3 |        1003 | Manager     | 2019-03-01   |       300000 |
|  4 |        1006 | Manager     | 2019-03-01   |       400000 |
+----+-------------+-------------+--------------+--------------+
4 rows in set (0.01 sec)


```

## INNER JOIN

テーブルAとテーブルBの共通のデータを有しているデータのみ抽出する

```mysql
mysql> SELECT * FROM evaluations;
+----+-------------+------+--------+---------------+
| id | employee_id | year | rating | explanation   |
+----+-------------+------+--------+---------------+
|  1 |        1001 | 2019 | A      | Very good     |
|  2 |        1002 | 2019 | B      | Good          |
|  3 |        1003 | 2019 | E      | Need Training |
|  4 |        1005 | 2019 | A      | Very good     |
+----+-------------+------+--------+---------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM employees;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
6 rows in set (0.01 sec)

mysql> SELECT
    ->     *
    -> FROM evaluations
    -> INNER JOIN
    ->     employees ON evaluations.employee_id = employees.employee_id;
+----+-------------+------+--------+---------------+-------------+-----------+------------+-----+--------------+-----+------------+-------+
| id | employee_id | year | rating | explanation   | employee_id | last_name | first_name | sex | joining_data | age | department | rater |
+----+-------------+------+--------+---------------+-------------+-----------+------------+-----+--------------+-----+------------+-------+
|  1 |        1001 | 2019 | A      | Very good     |        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |
|  2 |        1002 | 2019 | B      | Good          |        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |
|  3 |        1003 | 2019 | E      | Need Training |        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |
|  4 |        1005 | 2019 | A      | Very good     |        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |
+----+-------------+------+--------+---------------+-------------+-----------+------------+-----+--------------+-----+------------+-------+
4 rows in set (0.01 sec)


mysql> SELECT
    ->     *
    -> FROM employees
    -> INNER JOIN
    ->     evaluations ON employees.employee_id = evaluations.employee_id;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater | id | employee_id | year | rating | explanation   |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |  1 |        1001 | 2019 | A      | Very good     |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |  2 |        1002 | 2019 | B      | Good          |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |  3 |        1003 | 2019 | E      | Need Training |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |  4 |        1005 | 2019 | A      | Very good     |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+mysql> SELECT
    ->     *
    -> FROM
    ->     employees
    -> INNER JOIN
    ->     evaluations ON employees.employee_id = evaluations.employee_id
    -> WHERE sex = 'm'
    -> ORDER BY  employees.employee_id;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater | id | employee_id | year | rating | explanation   |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |  1 |        1001 | 2019 | A      | Very good     |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |  3 |        1003 | 2019 | E      | Need Training |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |  4 |        1005 | 2019 | A      | Very good     |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+

mysql> SELECT
    ->     *
    -> FROM
    ->     employees
    -> INNER JOIN
    ->     evaluations ON employees.employee_id = evaluations.employee_id
    -> WHERE sex = 'm'
    -> ORDER BY  employees.employee_id DESC;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater | id | employee_id | year | rating | explanation   |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |  4 |        1005 | 2019 | A      | Very good     |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |  3 |        1003 | 2019 | E      | Need Training |
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |  1 |        1001 | 2019 | A      | Very good     |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+
```


## LEFT JOIN

共通のキー値を有しているデータに加えて、左テーブルは無関係なデータも含めて抽出する.  


```mysql
mysql> SELECT * FROM employees;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
6 rows in set (0.00 sec)

mysql> 
mysql> SELECT * FROM evaluations;
+----+-------------+------+--------+---------------+
| id | employee_id | year | rating | explanation   |
+----+-------------+------+--------+---------------+
|  1 |        1001 | 2019 | A      | Very good     |
|  2 |        1002 | 2019 | B      | Good          |
|  3 |        1003 | 2019 | E      | Need Training |
|  4 |        1005 | 2019 | A      | Very good     |
+----+-------------+------+--------+---------------+
4 rows in set (0.01 sec)

mysql> SELECT
    ->     *
    -> FROM
    ->     employees
    -> LEFT JOIN
    ->     evaluations ON employees.employee_id = evaluations.employee_id;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+------+-------------+------+--------+---------------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater | id   | employee_id | year | rating | explanation   |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+------+-------------+------+--------+---------------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |    1 |        1001 | 2019 | A      | Very good     |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |    2 |        1002 | 2019 | B      | Good          |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |    3 |        1003 | 2019 | E      | Need Training |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |    4 |        1005 | 2019 | A      | Very good     |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 | NULL |        NULL | NULL | NULL   | NULL          |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 | NULL |        NULL | NULL | NULL   | NULL          |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+------+-------------+------+--------+---------------+

mysql> SELECT
    ->     *
    -> FROM
    ->     employees
    -> LEFT OUTER JOIN
    ->     evaluations ON employees.employee_id = evaluations.employee_id;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+------+-------------+------+--------+---------------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater | id   | employee_id | year | rating | explanation   |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+------+-------------+------+--------+---------------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |    1 |        1001 | 2019 | A      | Very good     |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |    2 |        1002 | 2019 | B      | Good          |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |    3 |        1003 | 2019 | E      | Need Training |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |    4 |        1005 | 2019 | A      | Very good     |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 | NULL |        NULL | NULL | NULL   | NULL          |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 | NULL |        NULL | NULL | NULL   | NULL          |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+------+-------------+------+--------+---------------+
6 rows in set (0.01 sec)


```

## RIGHT JOIN

共通のキー値を有しているデータに加えて、右テーブルは無関係なデータも含めて抽出する。  

```mysql
mysql> SELECT * FROM employees;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
6 rows in set (0.01 sec)

mysql> 
mysql> SELECT * FROM evaluations;
+----+-------------+------+--------+---------------+
| id | employee_id | year | rating | explanation   |
+----+-------------+------+--------+---------------+
|  1 |        1001 | 2019 | A      | Very good     |
|  2 |        1002 | 2019 | B      | Good          |
|  3 |        1003 | 2019 | E      | Need Training |
|  4 |        1005 | 2019 | A      | Very good     |
+----+-------------+------+--------+---------------+
4 rows in set (0.01 sec)

mysql> SELECT
    ->     *
    -> FROM
    ->     employees
    -> RIGHT OUTER JOIN
    ->     evaluations ON employees.employee_id = evaluations.employee_id;
+-------------+-----------+------------+------+--------------+------+------------+-------+----+-------------+------+--------+---------------+
| employee_id | last_name | first_name | sex  | joining_data | age  | department | rater | id | employee_id | year | rating | explanation   |
+-------------+-----------+------------+------+--------------+------+------------+-------+----+-------------+------+--------+---------------+
|        1001 | Sato      | takashi    | m    | 2018-04-01   |   23 | Sales      |  1006 |  1 |        1001 | 2019 | A      | Very good     |
|        1002 | Endo      | Maki       | w    | 2016-04-01   |   24 | HR         |  1006 |  2 |        1002 | 2019 | B      | Good          |
|        1003 | Kudo      | Takaaki    | m    | 2010-04-01   |   30 | Devlopment |  1005 |  3 |        1003 | 2019 | E      | Need Training |
|        1005 | Andy      | Bogard     | m    | 2010-04-01   |   35 | Devlopment |     0 |  4 |        1005 | 2019 | A      | Very good     |
+-------------+-----------+------------+------+--------------+------+------------+-------+----+-------------+------+--------+---------------+
4 rows in set (0.01 sec)

mysql> SELECT
    ->     *
    -> FROM
    ->     evaluations
    -> RIGHT OUTER JOIN
    ->     employees ON evaluations.employee_id = employees.employee_id;
+------+-------------+------+--------+---------------+-------------+-----------+------------+-----+--------------+-----+------------+-------+
| id   | employee_id | year | rating | explanation   | employee_id | last_name | first_name | sex | joining_data | age | department | rater |
+------+-------------+------+--------+---------------+-------------+-----------+------------+-----+--------------+-----+------------+-------+
|    1 |        1001 | 2019 | A      | Very good     |        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |
|    2 |        1002 | 2019 | B      | Good          |        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |
|    3 |        1003 | 2019 | E      | Need Training |        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |
|    4 |        1005 | 2019 | A      | Very good     |        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |
| NULL |        NULL | NULL | NULL   | NULL          |        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |
| NULL |        NULL | NULL | NULL   | NULL          |        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |
+------+-------------+------+--------+---------------+-------------+-----------+------------+-----+--------------+-----+------------+-------+

```


## FULL JOIN

関連性の有無に関係なく、テーブルAとテーブルBの全てのデータを結合する。

MySQLではエラーとなります

```mysql

SELECT
    *
FROM
    employees
FULL OUTER JOIN
    evaluations ON employees.employee_id = evaluations.employee_id;


```


## CROSS JOIN

テーブルAとテーブルB間で、可能な組み合わせを全て表示する

```mysql
mysql> SELECT * FROM employees CROSS JOIN evaluations;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater | id | employee_id | year | rating | explanation   |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |  1 |        1001 | 2019 | A      | Very good     |
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |  2 |        1002 | 2019 | B      | Good          |
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |  3 |        1003 | 2019 | E      | Need Training |
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |  4 |        1005 | 2019 | A      | Very good     |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |  1 |        1001 | 2019 | A      | Very good     |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |  2 |        1002 | 2019 | B      | Good          |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |  3 |        1003 | 2019 | E      | Need Training |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |  4 |        1005 | 2019 | A      | Very good     |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |  1 |        1001 | 2019 | A      | Very good     |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |  2 |        1002 | 2019 | B      | Good          |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |  3 |        1003 | 2019 | E      | Need Training |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |  4 |        1005 | 2019 | A      | Very good     |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |  1 |        1001 | 2019 | A      | Very good     |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |  2 |        1002 | 2019 | B      | Good          |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |  3 |        1003 | 2019 | E      | Need Training |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |  4 |        1005 | 2019 | A      | Very good     |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |  1 |        1001 | 2019 | A      | Very good     |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |  2 |        1002 | 2019 | B      | Good          |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |  3 |        1003 | 2019 | E      | Need Training |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |  4 |        1005 | 2019 | A      | Very good     |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |  1 |        1001 | 2019 | A      | Very good     |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |  2 |        1002 | 2019 | B      | Good          |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |  3 |        1003 | 2019 | E      | Need Training |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |  4 |        1005 | 2019 | A      | Very good     |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+
24 rows in set (0.01 sec)



```

## SELF JOIN

一つのテーブル　内にあるデータ同士を結合しさせて表示する


```mysql
mysql> SELECT
    ->     *
    -> FROM
    ->     employees AS emp01
    -> JOIN
    ->     employees AS emp02 ON emp02.employee_id = emp01.rater;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+-------------+-----------+------------+-----+--------------+-----+------------+-------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater | employee_id | last_name | first_name | sex | joining_data | age | department | rater |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+-------------+-----------+------------+-----+--------------+-----+------------+-------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+-------------+-----------+------------+-----+--------------+-----+------------+-------+
4 rows in set (0.01 sec)



```

## 3つ以上のテーブルへのJOIN


```mysql
mysql> SELECT * FROM evaluations;
+----+-------------+------+--------+---------------+
| id | employee_id | year | rating | explanation   |
+----+-------------+------+--------+---------------+
|  1 |        1001 | 2019 | A      | Very good     |
|  2 |        1002 | 2019 | B      | Good          |
|  3 |        1003 | 2019 | E      | Need Training |
|  4 |        1005 | 2019 | A      | Very good     |
+----+-------------+------+--------+---------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM payrolls;
+----+-------------+-------------+--------------+--------------+
| id | employee_id | position    | decided_date | payroll_rate |
+----+-------------+-------------+--------------+--------------+
|  1 |        1001 | Sales staff | 2019-03-01   |       200000 |
|  2 |        1002 | Leader      | 2019-03-01   |       250000 |
|  3 |        1003 | Manager     | 2019-03-01   |       300000 |
|  4 |        1006 | Manager     | 2019-03-01   |       400000 |
+----+-------------+-------------+--------------+--------------+
4 rows in set (0.01 sec)

mysql> 
mysql> 
mysql> SELECT
    ->     *
    -> FROM
    ->     employees
    -> INNER JOIN
    ->     evaluations ON evaluations.employee_id = employees.employee_id
    -> INNER JOIN
    ->     payrolls ON payrolls.employee_id = employees.employee_id;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+----+-------------+-------------+--------------+--------------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater | id | employee_id | year | rating | explanation   | id | employee_id | position    | decided_date | payroll_rate |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+----+-------------+-------------+--------------+--------------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |  1 |        1001 | 2019 | A      | Very good     |  1 |        1001 | Sales staff | 2019-03-01   |       200000 |
|        1002 | Endo      | Maki       | w   | 2016-04-01   |  24 | HR         |  1006 |  2 |        1002 | 2019 | B      | Good          |  2 |        1002 | Leader      | 2019-03-01   |       250000 |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |  3 |        1003 | 2019 | E      | Need Training |  3 |        1003 | Manager     | 2019-03-01   |       300000 |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+----+-------------+------+--------+---------------+----+-------------+-------------+--------------+--------------+
3 rows in set (0.01 sec)


mysql> SELECT
    ->     employees.employee_id,
    ->     employees.last_name,
    ->     employees.first_name,
    ->     evaluations.rating,
    ->     payrolls.payroll_rate
    -> FROM
    -> employees
    -> INNER JOIN
    ->     evaluations ON evaluations.employee_id = employees.employee_id
    -> INNER JOIN
    ->     payrolls ON payrolls.employee_id = employees.employee_id;
+-------------+-----------+------------+--------+--------------+
| employee_id | last_name | first_name | rating | payroll_rate |
+-------------+-----------+------------+--------+--------------+
|        1001 | Sato      | takashi    | A      |       200000 |
|        1002 | Endo      | Maki       | B      |       250000 |
|        1003 | Kudo      | Takaaki    | E      |       300000 |
+-------------+-----------+------------+--------+--------------+
3 rows in set (0.01 sec)

```

## UNIONとUNION ALL


```mysql
mysql> SELECT
    ->     *
    -> FROM
    ->     employees
    -> WHERE
    ->     employee_id = 1001
    -> UNION
    -> SELECT
    ->     *
    -> FROM
    ->     employees
    -> WHERE
    ->     sex = 'm';
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+

mysql> SELECT
    ->     *
    -> FROM
    ->     employees
    -> WHERE
    ->     employee_id = 1001
    -> UNION ALL
    -> SELECT
    ->     *
    -> FROM
    ->     employees
    -> WHERE
    ->     sex = 'm';
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
6 rows in set (0.00 sec)

mysql> SELECT
    ->     *
    -> FROM
    ->     employees
    -> WHERE
    ->     employee_id = 1001
    -> UNION
    -> SELECT
    ->     *
    -> FROM
    ->     employees
    -> WHERE
    ->     sex = 'm'
    -> UNION
    -> SELECT
    ->     *
    -> FROM
    ->     employees
    -> WHERE
    -> age >= 30;
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
| employee_id | last_name | first_name | sex | joining_data | age | department | rater |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
|        1001 | Sato      | takashi    | m   | 2018-04-01   |  23 | Sales      |  1006 |
|        1003 | Kudo      | Takaaki    | m   | 2010-04-01   |  30 | Devlopment |  1005 |
|        1004 | Shin      | Ando       | m   | 2010-04-01   |  32 | Devlopment |  1005 |
|        1005 | Andy      | Bogard     | m   | 2010-04-01   |  35 | Devlopment |     0 |
|        1006 | Kow       | Murasame   | m   | 2010-04-01   |  38 | Devlopment |     0 |
+-------------+-----------+------------+-----+--------------+-----+------------+-------+
5 rows in set (0.00 sec)

```

## 演習


### 演習1

ECサイトに注文履歴ページを新規に作成することになり、あなたは利用するデータを準備しています。
ユーザの注文データを利用して、ユーザの個人情報を注文した商品の発注数を合わせてリスト化する必要があります。
その際にはこれまでに注文がないユーザについても抽出して把握できるようにします。


```mysql

mysql> show tables;
+----------------------------+
| Tables_in_ecsite           |
+----------------------------+
| case4                      |
| order_details              |
| orders                     |
| product_browsing_histories |
| product_review_likes       |
| product_reviews            |
| products                   |
| simpleid                   |
| users                      |
+----------------------------+
9 rows in set (0.01 sec)

ysql> DESC users;
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

mysql> SELECT
    ->     users.id,
    ->     users.email,
    ->     users.name,
    ->     users.gender,
    ->     users.birthday,
    ->     orders.id AS order_id,
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
    -> orders.id = order_details.order_id;
+----+--------------------------------------+----------------------+--------+------------+----------+------------+--------+
| id | email                                | name                 | gender | birthday   | order_id | product_id | amount |
+----+--------------------------------------+----------------------+--------+------------+----------+------------+--------+
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      109 |          4 |      3 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      109 |          5 |      3 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      109 |          6 |      2 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      211 |          2 |      1 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      211 |          3 |      2 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      211 |          4 |      2 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      211 |          5 |      3 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      215 |          6 |      1 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      281 |          1 |      3 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      281 |          2 |      3 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      281 |          3 |      3 |
|  2 | louis.price@borer.co                 | Sudie Waelchi        |      1 | 1999-07-24 |      125 |          4 |      1 |
|  2 | louis.price@borer.co                 | Sudie Waelchi        |      1 | 1999-07-24 |      125 |          5 |      2 |
|  2 | louis.price@borer.co                 | Sudie Waelchi        |      1 | 1999-07-24 |      221 |          2 |      2 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      100 |          6 |      2 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      100 |          7 |      2 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      100 |          8 |      1 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      164 |          1 |      3 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      164 |          2 |      3 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      164 |          3 |      3 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      253 |          5 |      1 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      256 |          8 |      3 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      256 |          9 |      3 |
|  4 | michael@grant.org                    | Roy Yundt Jr.        |      0 | 1994-06-16 |      299 |          3 |      1 |
|  4 | michael@grant.org                    | Roy Yundt Jr.        |      0 | 1994-06-16 |      299 |          4 |      3 |
...................
| 97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 |      140 |          9 |      1 |
| 97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 |      140 |          1 |      2 |
| 97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 |      140 |          2 |      3 |
| 97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 |      140 |          3 |      1 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      136 |          3 |      1 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      136 |          4 |      1 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      136 |          5 |      2 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      176 |          4 |      3 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      176 |          5 |      3 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      185 |          1 |      3 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      185 |          2 |      3 |
+----+--------------------------------------+----------------------+--------+------------+----------+------------+--------+
602 rows in set (0.03 sec)



```

### 演習2

演習1で作成したユーザ毎のECサイトでの注文履歴リストに対して、注文した商品名と合計金額（税込／税別）がわかるようにリストにデータを追加してください。
結果はuser_idで昇順表示されるようにします。

```mysql
mysql> DESC products;
+------------+------------------+------+-----+---------+----------------+
| Field      | Type             | Null | Key | Default | Extra          |
+------------+------------------+------+-----+---------+----------------+
| id         | bigint(20)       | NO   | PRI | NULL    | auto_increment |
| name       | varchar(255)     | NO   |     | NULL    |                |
| price      | int(10) unsigned | NO   |     | NULL    |                |
| created_at | datetime(6)      | NO   |     | NULL    |                |
| updated_at | datetime(6)      | NO   |     | NULL    |                |
+------------+------------------+------+-----+---------+----------------+
5 rows in set (0.01 sec)

mysql> SELECT
    ->     users.id,
    ->     users.email,
    ->     users.name,
    ->     users.gender,
    ->     users.birthday,
    ->     orders.id AS order_id,
    ->     order_details.product_id,
    ->     order_details.amount,
    ->     products.price,
    ->     products.price * order_details.amount AS total_fee,
    ->     products.price * order_details.amount * 1.1 AS tax_included
    ->     
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
    -> products
    -> ON order_details.product_id = products.id
    -> ORDER BY users.id;
+----+--------------------------------------+----------------------+--------+------------+----------+------------+--------+-------+-----------+--------------+
| id | email                                | name                 | gender | birthday   | order_id | product_id | amount | price | total_fee | tax_included |
+----+--------------------------------------+----------------------+--------+------------+----------+------------+--------+-------+-----------+--------------+
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      211 |          3 |      2 |    40 |        80 |         88.0 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      211 |          2 |      1 |    12 |        12 |         13.2 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      109 |          5 |      3 |   698 |      2094 |       2303.4 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      211 |          5 |      3 |   698 |      2094 |       2303.4 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      281 |          3 |      3 |    40 |       120 |        132.0 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      211 |          4 |      2 |    38 |        76 |         83.6 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      109 |          4 |      3 |    38 |       114 |        125.4 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      109 |          6 |      2 |    95 |       190 |        209.0 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      281 |          2 |      3 |    12 |        36 |         39.6 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      281 |          1 |      3 |    49 |       147 |        161.7 |
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |      215 |          6 |      1 |    95 |        95 |        104.5 |
|  2 | louis.price@borer.co                 | Sudie Waelchi        |      1 | 1999-07-24 |      125 |          5 |      2 |   698 |      1396 |       1535.6 |
|  2 | louis.price@borer.co                 | Sudie Waelchi        |      1 | 1999-07-24 |      125 |          4 |      1 |    38 |        38 |         41.8 |
|  2 | louis.price@borer.co                 | Sudie Waelchi        |      1 | 1999-07-24 |      221 |          2 |      2 |    12 |        24 |         26.4 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      164 |          1 |      3 |    49 |       147 |        161.7 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      256 |          8 |      3 |     5 |        15 |         16.5 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      253 |          5 |      1 |   698 |       698 |        767.8 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      100 |          6 |      2 |    95 |       190 |        209.0 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      100 |          8 |      1 |     5 |         5 |          5.5 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      164 |          3 |      3 |    40 |       120 |        132.0 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      164 |          2 |      3 |    12 |        36 |         39.6 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      256 |          9 |      3 |    25 |        75 |         82.5 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |      100 |          7 |      2 |   598 |      1196 |       1315.6 |
|  4 | michael@grant.org                    | Roy Yundt Jr.        |      0 | 1994-06-16 |      299 |          3 |      1 |    40 |        40 |         44.0 |
|  4 | michael@grant.org                    | Roy Yundt Jr.        |      0 | 1994-06-16 |      299 |          4 |      3 |    38 |       114 |        125.4 |
...................
| 97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 |      140 |          3 |      1 |    40 |        40 |         44.0 |
| 97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 |      140 |          2 |      3 |    12 |        36 |         39.6 |
| 97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 |      140 |          9 |      1 |    25 |        25 |         27.5 |
| 97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 |      140 |          1 |      2 |    49 |        98 |        107.8 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      136 |          4 |      1 |    38 |        38 |         41.8 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      185 |          1 |      3 |    49 |       147 |        161.7 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      176 |          5 |      3 |   698 |      2094 |       2303.4 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      136 |          3 |      1 |    40 |        40 |         44.0 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      136 |          5 |      2 |   698 |      1396 |       1535.6 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      176 |          4 |      3 |    38 |       114 |        125.4 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |      185 |          2 |      3 |    12 |        36 |         39.6 |
+----+--------------------------------------+----------------------+--------+------------+----------+------------+--------+-------+-----------+--------------+
602 rows in set (0.03 sec)


```

### 演習3

演習2で作成したリストを利用して、ユーザ毎の合計発注金額を抽出してください。その際には、合計注文数がわかるようしてください。

```mysql

mysql> SELECT
    ->     users.id,
    ->     users.email,
    ->     users.name,
    ->     users.gender,
    ->     users.birthday,
    ->     COUNT(order_id) AS order_count,
    ->     SUM(products.price * order_details.amount) AS sum_total_fee,
    ->     SUM(products.price * order_details.amount * 1.1 ) AS tax_included
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
    -> order_details.product_id = products.id
    -> GROUP BY
    ->     users.id
    -> ORDER BY
    ->     users.id;
+----+--------------------------------------+----------------------+--------+------------+-------------+---------------+--------------+
| id | email                                | name                 | gender | birthday   | order_count | sum_total_fee | tax_included |
+----+--------------------------------------+----------------------+--------+------------+-------------+---------------+--------------+
|  1 | jannie@dach.net                      | Erin Casper          |      2 | 1976-04-20 |          11 |          5058 |       5563.8 |
|  2 | louis.price@borer.co                 | Sudie Waelchi        |      1 | 1999-07-24 |           3 |          1458 |       1603.8 |
|  3 | joaquin.koepp@sawaynschuster.io      | Desire Osinski Sr.   |      1 | 2002-03-09 |           9 |          2482 |       2730.2 |
|  4 | michael@grant.org                    | Roy Yundt Jr.        |      0 | 1994-06-16 |           2 |           154 |        169.4 |
|  5 | fredrick_boyle@goyette.org           | Golden Kunde         |      1 | 1998-05-02 |          16 |          2367 |       2603.7 |
|  6 | felipe@nitzsche.name                 | Thaddeus Ledner      |      0 | 1962-07-30 |           5 |           306 |        336.6 |
|  7 | lesley_mitchell@damore.net           | Miss Rudy VonRueden  |      0 | 1968-03-08 |          11 |          6531 |       7184.1 |
|  8 | phyli.huel@boyer.co                  | Drusilla Larson      |      0 | 1964-11-26 |           8 |          4576 |       5033.6 |
|  9 | dirk.pagac@rosenbaumdaugherty.net    | Kip Raynor Jr.       |      1 | 1964-07-20 |           6 |          1561 |       1717.1 |
| 10 | linwood.vonrueden@hueljones.biz      | Coy Swaniawski       |      1 | 1978-03-12 |           3 |           178 |        195.8 |
| 11 | sean@labadie.co                      | Hong Wisozk IV       |      2 | 1962-08-03 |          10 |          4701 |       5171.1 |
| 12 | kayce_gulgowski@hodkiewicz.info      | Jerold Satterfield   |      0 | 2000-06-26 |           8 |          4149 |       4563.9 |
| 13 | gregory@sanfordbeier.com             | Zenaida Gorczany I   |      1 | 1991-03-27 |          15 |          4338 |       4771.8 |
| 14 | silva@cremin.org                     | Ivory King           |      0 | 1963-05-10 |           6 |          2070 |       2277.0 |
........
| 86 | columbus@vandervortfeest.name        | Shawanda McGlynn     |      1 | 1966-06-08 |           3 |          2149 |       2363.9 |
| 88 | marion@heel.co                       | Hermina Wiegand      |      0 | 1974-03-03 |           6 |          1112 |       1223.2 |
| 89 | rocio@gleichnerschiller.info         | Dorian Gislason      |      0 | 2004-04-09 |          13 |          1247 |       1371.7 |
| 90 | rae.streich@ruecker.org              | Annetta Friesen II   |      0 | 1979-07-20 |           5 |          3694 |       4063.4 |
| 91 | berniece@daugherty.io                | Rickie Littel        |      2 | 1978-11-05 |           4 |          2362 |       2598.2 |
| 92 | galen@wiegandmaggio.biz              | Truman Rogahn        |      0 | 1960-05-11 |           3 |          2242 |       2466.2 |
| 93 | kermit@vonshanahan.biz               | Soraya Luettgen      |      1 | 1963-11-30 |           5 |           221 |        243.1 |
| 94 | devora.douglas@nolanschowalter.co    | Pablo Huels Jr.      |      1 | 1967-08-27 |          10 |          1256 |       1381.6 |
| 95 | weldon@kaulke.name                   | Leonardo Turner      |      1 | 2004-11-13 |           8 |          3109 |       3419.9 |
| 96 | merna@steuberreilly.biz              | Augustine Cassin     |      1 | 1997-07-08 |           6 |          3452 |       3797.2 |
| 97 | yen_dickinson@kuhicdubuque.co        | Velva Nolan          |      1 | 2001-11-26 |           4 |           199 |        218.9 |
| 99 | dennis@buckridge.co                  | Domingo Herman       |      0 | 1981-02-28 |           7 |          3865 |       4251.5 |
+----+--------------------------------------+----------------------+--------+------------+-------------+---------------+--------------+
90 rows in set (0.01 sec)



```
### 演習4

製品毎のレビュー内容をリスト化して抽出したい。
製品名に対するレビュー内容と、レビュー内容を投稿したユーザー名がわかるようにリストを作成してください。
その際には、レビュー投稿がされていない製品にはレビューがないことを把握したい


```mysql
mysql> DESC products;
+------------+------------------+------+-----+---------+----------------+
| Field      | Type             | Null | Key | Default | Extra          |
+------------+------------------+------+-----+---------+----------------+
| id         | bigint(20)       | NO   | PRI | NULL    | auto_increment |
| name       | varchar(255)     | NO   |     | NULL    |                |
| price      | int(10) unsigned | NO   |     | NULL    |                |
| created_at | datetime(6)      | NO   |     | NULL    |                |
| updated_at | datetime(6)      | NO   |     | NULL    |                |
+------------+------------------+------+-----+---------+----------------+
5 rows in set (0.01 sec)

mysql> DESC product_reviews;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | bigint(20)  | NO   | PRI | NULL    | auto_increment |
| product_id | bigint(20)  | NO   | MUL | NULL    |                |
| user_id    | bigint(20)  | NO   | MUL | NULL    |                |
| body       | text        | NO   |     | NULL    |                |
| created_at | datetime(6) | NO   |     | NULL    |                |
| updated_at | datetime(6) | NO   |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
6 rows in set (0.01 sec)

mysql> DESC users;
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
7 rows in set (0.00 sec)


mysql> SELECT
    ->     products.id,
    ->     products.name,
    ->     product_reviews.body,
    ->     product_reviews.user_id,
    ->     users.name
    -> FROM
    ->     products
    -> LEFT JOIN
    ->     product_reviews
    -> ON
    ->     products.id = product_reviews.product_id
    -> INNER JOIN
    ->     users
    -> ON
    ->     product_reviews.user_id = users.id;
+----+--------------------+---------------------------------------------+---------+----------------------+
| id | name               | body                                        | user_id | name                 |
+----+--------------------+---------------------------------------------+---------+----------------------+
|  1 | Water cooker       | This is has good cost performance.          |      13 | Zenaida Gorczany I   |
|  1 | Water cooker       | This product is disappointing.              |       5 | Golden Kunde         |
|  1 | Water cooker       | What I bought is hard to use.               |       6 | Thaddeus Ledner      |
|  1 | Water cooker       | What I bought is hard to use.               |      29 | Dominica Harber      |
|  1 | Water cooker       | What I bought is has good cost performance. |      96 | Augustine Cassin     |
|  1 | Water cooker       | What I bought is hard to use.               |      95 | Leonardo Turner      |
|  1 | Water cooker       | This product is hard to use.                |      52 | Dr. Gene Steuber     |
|  1 | Water cooker       | This product is easy to use.                |      61 | Julio Cormier        |
|  1 | Water cooker       | What I bought is has good cost performance. |      46 | Ty Thompson PhD      |
|  1 | Water cooker       | What I bought is has good cost performance. |      14 | Ivory King           |
|  1 | Water cooker       | This product is disappointing.              |      37 | Kenneth Prosacco     |
|  1 | Water cooker       | This is disappointing.                      |      41 | Ms. Bart Lowe        |
|  1 | Water cooker       | This product is disappointing.              |      29 | Dominica Harber      |
|  1 | Water cooker       | This product is hard to use.                |      92 | Truman Rogahn        |
|  1 | Water cooker       | This product is easy to use.                |      56 | Lyda Dare III        |
|  1 | Water cooker       | This is easy to use.                        |       5 | Golden Kunde         |
|  1 | Water cooker       | This product is easy to use.                |      58 | Dr. Sunny Marks      |
|  1 | Water cooker       | This is disappointing.                      |      94 | Pablo Huels Jr.      |
|  1 | Water cooker       | What I bought is hard to use.               |      94 | Pablo Huels Jr.      |
...........
|  8 | Mousetrap          | This product is easy to use.                |      89 | Dorian Gislason      |
|  8 | Mousetrap          | This is has good cost performance.          |       3 | Desire Osinski Sr.   |
|  8 | Mousetrap          | What I bought is has good cost performance. |      57 | Iva Leuschke Jr.     |
|  8 | Mousetrap          | This product is has good cost performance.  |      61 | Julio Cormier        |
|  8 | Mousetrap          | This product is disappointing.              |      31 | Tameka Hayes I       |
|  8 | Mousetrap          | What I bought is easy to use.               |      10 | Coy Swaniawski       |
|  8 | Mousetrap          | This product is hard to use.                |      46 | Ty Thompson PhD      |
|  8 | Mousetrap          | This is has good cost performance.          |      36 | Lawrence Frami       |
|  8 | Mousetrap          | This is easy to use.                        |      46 | Ty Thompson PhD      |
|  8 | Mousetrap          | What I bought is has good cost performance. |      12 | Jerold Satterfield   |
|  8 | Mousetrap          | This is disappointing.                      |      72 | Margarette Osinski   |
|  8 | Mousetrap          | What I bought is hard to use.               |      63 | Otelia Kirlin        |
+----+--------------------+---------------------------------------------+---------+----------------------+
402 rows in set (0.01 sec)


```

### 演習5

演習2と演習3を結合して、個別の注文と合計金額がリスト化されるように、データを抽出してください。
データの抽出結果は以下のリストになります。

ユーザ毎に個別の注文内容がリスト化されて、最後に合計金額が抽出されます。



```mysql
mysql> (
    -> SELECT
    ->     users.id,
    ->     users.name,
    ->     users.email,
    ->     users.gender,
    ->     users.birthday,
    ->     order_details.product_id,
    ->     order_details.amount,
    ->     products.name,
    ->     order_details.amount * price AS total_fee,
    ->     order_details.amount * price * 1.1 AS tax_included
    -> FROM
    ->     users
    -> LEFT JOIN
    ->     orders
    -> ON
    ->     users.id = orders.user_id
    -> INNER JOIN
    ->     order_details
    -> ON
    ->     order_details.order_id = orders.id
    -> INNER JOIN
    ->     products
    -> ON
    ->     order_details.product_id = products.id
    -> ) 
    -> UNION ALL
    -> (
    -> SELECT
    ->     users.id,
    ->     '',
    ->     '',
    ->     '',
    ->     '',
    ->     '',
    ->     '',
    ->     'TOTAL',
    ->     SUM(order_details.amount * price) AS total_fee,
    ->     SUM(order_details.amount * price * 1.1) AS tax_included
    -> FROM
    ->     users
    -> LEFT JOIN
    ->     orders
    -> ON
    ->     users.id = orders.user_id
    -> INNER JOIN
    ->     order_details
    -> ON
    ->     order_details.order_id = orders.id
    -> INNER JOIN
    ->     products
    -> ON
    ->     order_details.product_id = products.id
    -> GROUP BY users.id
    -> )
    -> ORDER BY id, total_fee;
ERROR 2013 (HY000): Lost connection to MySQL server during query
No connection. Trying to reconnect...
Connection id:    1266
Current database: ecsite

+----+----------------------+--------------------------------------+--------+------------+------------+--------+------------------------+-----------+--------------+
| id | name                 | email                                | gender | birthday   | product_id | amount | name                   | total_fee | tax_included |
+----+----------------------+--------------------------------------+--------+------------+------------+--------+------------------------+-----------+--------------+
|  1 | Erin Casper          | jannie@dach.net                      | 2      | 1976-04-20 | 2          | 1      | Window fan             |        12 |         13.2 |
|  1 | Erin Casper          | jannie@dach.net                      | 2      | 1976-04-20 | 2          | 3      | Window fan             |        36 |         39.6 |
|  1 | Erin Casper          | jannie@dach.net                      | 2      | 1976-04-20 | 4          | 2      | Evaporative cooler     |        76 |         83.6 |
|  1 | Erin Casper          | jannie@dach.net                      | 2      | 1976-04-20 | 3          | 2      | Mangle (machine)       |        80 |         88.0 |
|  1 | Erin Casper          | jannie@dach.net                      | 2      | 1976-04-20 | 6          | 1      | Central vacuum cleaner |        95 |        104.5 |
|  1 | Erin Casper          | jannie@dach.net                      | 2      | 1976-04-20 | 4          | 3      | Evaporative cooler     |       114 |        125.4 |
|  1 | Erin Casper          | jannie@dach.net                      | 2      | 1976-04-20 | 3          | 3      | Mangle (machine)       |       120 |        132.0 |
|  1 | Erin Casper          | jannie@dach.net                      | 2      | 1976-04-20 | 1          | 3      | Water cooker           |       147 |        161.7 |
|  1 | Erin Casper          | jannie@dach.net                      | 2      | 1976-04-20 | 6          | 2      | Central vacuum cleaner |       190 |        209.0 |
|  1 | Erin Casper          | jannie@dach.net                      | 2      | 1976-04-20 | 5          | 3      | Refrigerator           |      2094 |       2303.4 |
|  1 | Erin Casper          | jannie@dach.net                      | 2      | 1976-04-20 | 5          | 3      | Refrigerator           |      2094 |       2303.4 |
|  1 |                      |                                      |        |            |            |        | TOTAL                  |      5058 |       5563.8 |
|  2 | Sudie Waelchi        | louis.price@borer.co                 | 1      | 1999-07-24 | 2          | 2      | Window fan             |        24 |         26.4 |
|  2 | Sudie Waelchi        | louis.price@borer.co                 | 1      | 1999-07-24 | 4          | 1      | Evaporative cooler     |        38 |         41.8 |
|  2 | Sudie Waelchi        | louis.price@borer.co                 | 1      | 1999-07-24 | 5          | 2      | Refrigerator           |      1396 |       1535.6 |
|  2 |                      |                                      |        |            |            |        | TOTAL                  |      1458 |       1603.8 |
|  3 | Desire Osinski Sr.   | joaquin.koepp@sawaynschuster.io      | 1      | 2002-03-09 | 8          | 1      | Mousetrap              |         5 |          5.5 |
|  3 | Desire Osinski Sr.   | joaquin.koepp@sawaynschuster.io      | 1      | 2002-03-09 | 8          | 3      | Mousetrap              |        15 |         16.5 |
|  3 | Desire Osinski Sr.   | joaquin.koepp@sawaynschuster.io      | 1      | 2002-03-09 | 2          | 3      | Window fan             |        36 |         39.6 |
|  3 | Desire Osinski Sr.   | joaquin.koepp@sawaynschuster.io      | 1      | 2002-03-09 | 9          | 3      | Futon dryer            |        75 |         82.5 |
|  3 | Desire Osinski Sr.   | joaquin.koepp@sawaynschuster.io      | 1      | 2002-03-09 | 3          | 3      | Mangle (machine)       |       120 |        132.0 |
|  3 | Desire Osinski Sr.   | joaquin.koepp@sawaynschuster.io      | 1      | 2002-03-09 | 1          | 3      | Water cooker           |       147 |        161.7 |
|  3 | Desire Osinski Sr.   | joaquin.koepp@sawaynschuster.io      | 1      | 2002-03-09 | 6          | 2      | Central vacuum cleaner |       190 |        209.0 |
|  3 | Desire Osinski Sr.   | joaquin.koepp@sawaynschuster.io      | 1      | 2002-03-09 | 5          | 1      | Refrigerator           |       698 |        767.8 |
|  3 | Desire Osinski Sr.   | joaquin.koepp@sawaynschuster.io      | 1      | 2002-03-09 | 7          | 2      | Drawer dishwasher      |      1196 |       1315.6 |
|  3 |                      |                                      |        |            |            |        | TOTAL                  |      2482 |       2730.2 |
|  4 | Roy Yundt Jr.        | michael@grant.org                    | 0      | 1994-06-16 | 3          | 1      | Mangle (machine)       |        40 |         44.0 |
|  4 | Roy Yundt Jr.        | michael@grant.org                    | 0      | 1994-06-16 | 4          | 3      | Evaporative cooler     |       114 |        125.4 |
|  4 |                      |                                      |        |            |            |        | TOTAL                  |       154 |        169.4 |
..........
| 99 | Domingo Herman       | dennis@buckridge.co                  | 0      | 1981-02-28 | 2          | 3      | Window fan             |        36 |         39.6 |
| 99 | Domingo Herman       | dennis@buckridge.co                  | 0      | 1981-02-28 | 4          | 1      | Evaporative cooler     |        38 |         41.8 |
| 99 | Domingo Herman       | dennis@buckridge.co                  | 0      | 1981-02-28 | 3          | 1      | Mangle (machine)       |        40 |         44.0 |
| 99 | Domingo Herman       | dennis@buckridge.co                  | 0      | 1981-02-28 | 4          | 3      | Evaporative cooler     |       114 |        125.4 |
| 99 | Domingo Herman       | dennis@buckridge.co                  | 0      | 1981-02-28 | 1          | 3      | Water cooker           |       147 |        161.7 |
| 99 | Domingo Herman       | dennis@buckridge.co                  | 0      | 1981-02-28 | 5          | 2      | Refrigerator           |      1396 |       1535.6 |
| 99 | Domingo Herman       | dennis@buckridge.co                  | 0      | 1981-02-28 | 5          | 3      | Refrigerator           |      2094 |       2303.4 |
| 99 |                      |                                      |        |            |            |        | TOTAL                  |      3865 |       4251.5 |
+----+----------------------+--------------------------------------+--------+------------+------------+--------+------------------------+-----------+--------------+
692 rows in set (0.18 sec)


```