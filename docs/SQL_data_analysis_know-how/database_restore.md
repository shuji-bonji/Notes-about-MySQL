# データベースの復元

今後のSQL操作学習で利用するデータベースを移行用ファイルを利用して作成します。


## データベースのインポート

### インポートデータ（復元）

[sample_data.sql](sample_data.sql)


### RDSのパラメータグループの設定

mysqldumpファイルをインポートできるよう、RDSのパラメータグループ設定を変更します。


#### 1. RDSのパラメータグループの作成
1. AWS コンソールにログインし、Amazon RDSサービスの画面を開く
2. Amazon RDS画面から、左メニューのパラメータグループを選択
3. 「デフォルト」タブを開いて、自動生成されたデフォルトのパラメータグループを確認します。(これを新たに作ったものと差し替えます。)
4. 「カスタム」タブに戻り、「パラメータグループの作成」を押下
5. 以下項目を入力して、「作成」を押下します。
    - パラメータグループファミリー: データベースのDBファミリー
    - グループ名: 任意のわかりやすい名前
    - 説明: わかりやすい説明
6. 作成したパラメータグループを選択
7. パラメータを「変更」ボタンを押下します。
8. パラメータ変更画面から、「検索」にて以下を検索
    - log_bin
8. 検索結果から以下をチェック
    - `log_bin_trust_function_creators`
9. 選択した場所の「値」のプルダウンより`1`を選択し「続行」を推します。
10. 「変更の適用」ボタンを押下します

#### 2. 作成したパラメータグループをデータベースに適用

1. Amazon RDS画面のデータベースを選択
2. 作成したデータベースを選択
3. データベースの各設定画面から、「変更」ボタンを押下
4. 「追加設定」の「データベースの選択肢」で、「DBパラメータグループ」を作成したパラメータグループ名に変更します。
5. 「続行」＞「DBインスタンスの変更」を押下
6. 再び、左のメニューからデータベースを選択し、該当のデータベースが「変更中」から「利用可能」となったら、「再起動」します
7. 再び「利用可能」なったら、パラメータグループが変更されたこと確認します。



### データベースのインポート

#### MySQL WorkBenchよりインポート

#### mysql コマンドよりインポート

```bash
	
mysql -h RDSのエンドポイント -P 3306 -u ユーザー名 -p データベース名 < インポートファイル.sql

```

	
mysql -h データベースエンドポイント -P 3306 -u admin -p ecsite < sample_data.sql


```bash
$ mysql -h RDSエンドポイント -P 3306 -u admin -p
Enter password: RDS作成時のパスワード

```

```mysql
CREATE DATABASE データベース名 DEFAULT CHARACTER SET utf8mb4;

```


##### 実例

###### 1. まず、RDSに接続して


```zsh
mysql --host データベースエンドポイント --user admin -p

```

###### 2. 事前にデータベースを作成

```mysql

mysql> CREATE DATABASE ecsite DEFAULT CHARACTER SET utf8mb4;
Query OK, 1 row affected (0.01 sec)

mysql> use scsite;
ERROR 1049 (42000): Unknown database 'scsite'
mysql> use ecsite;
Database changed

```

###### 3. 以下のコマンドでテーブルとデータをインポートします。

```bash
mysql -h データベースエンドポイント -P 3306 -u admin -p データベース名 < sample_data.sql

```

###### 4. データを確認

```mysql
mysql> show tables;
+----------------------------+
| Tables_in_ecsite           |
+----------------------------+
| order_details              |
| orders                     |
| product_browsing_histories |
| product_review_likes       |
| product_reviews            |
| products                   |
| users                      |
+----------------------------+
7 rows in set (0.01 sec)

mysql> SELECT * FROM order_details;
+-----+----------+------------+--------+----------------------------+----------------------------+
| id  | order_id | product_id | amount | created_at                 | updated_at                 |
+-----+----------+------------+--------+----------------------------+----------------------------+
|   1 |        2 |          1 |      1 | 2020-04-07 04:33:58.679643 | 2020-04-07 04:33:58.679643 |
|   2 |        2 |          2 |      2 | 2020-04-07 04:33:58.683224 | 2020-04-07 04:33:58.683224 |
|   3 |        2 |          3 |      2 | 2020-04-07 04:33:58.686672 | 2020-04-07 04:33:58.686672 |
|   4 |        2 |          4 |      2 | 2020-04-07 04:33:58.690540 | 2020-04-07 04:33:58.690540 |
|   5 |        3 |          5 |      3 | 2020-04-07 04:33:58.707116 | 2020-04-07 04:33:58.707116 |
|   6 |        3 |          6 |      1 | 2020-04-07 04:33:58.709882 | 2020-04-07 04:33:58.709882 |
|   7 |        3 |          7 |      1 | 2020-04-07 04:33:58.713359 | 2020-04-07 04:33:58.713359 |
|   8 |        3 |          8 |      3 | 2020-04-07 04:33:58.717463 | 2020-04-07 04:33:58.717463 |
|   9 |        4 |          9 |      3 | 2020-04-07 04:33:58.726347 | 2020-04-07 04:33:58.726347 |
  .............
| 594 |      297 |          9 |      2 | 2020-04-07 04:34:01.233840 | 2020-04-07 04:34:01.233840 |
| 595 |      298 |          1 |      1 | 2020-04-07 04:34:01.238522 | 2020-04-07 04:34:01.238522 |
| 596 |      298 |          2 |      2 | 2020-04-07 04:34:01.240906 | 2020-04-07 04:34:01.240906 |
| 597 |      299 |          3 |      1 | 2020-04-07 04:34:01.245847 | 2020-04-07 04:34:01.245847 |
| 598 |      299 |          4 |      3 | 2020-04-07 04:34:01.248762 | 2020-04-07 04:34:01.248762 |
| 599 |      300 |          5 |      1 | 2020-04-07 04:34:01.254137 | 2020-04-07 04:34:01.254137 |
| 600 |      300 |          6 |      3 | 2020-04-07 04:34:01.256681 | 2020-04-07 04:34:01.256681 |
| 601 |      300 |          7 |      1 | 2020-04-07 04:34:01.259570 | 2020-04-07 04:34:01.259570 |
| 602 |      300 |          8 |      3 | 2020-04-07 04:34:01.262304 | 2020-04-07 04:34:01.262304 |
+-----+----------+------------+--------+----------------------------+----------------------------+
602 rows in set (0.02 sec)

```

## データベースのエクスポート

!!!note
    データベースのバックアップとしては、RDSのバックアップ機能の方を選択した方が管理・安全面で良いと思います。
    以下は、別のシステムやアプリを用いてデータ分析などの利用目的として、ホットバックアップとしての利用を想定しています。

### WorkBenchからエクスポート


[export_.sql](export_.sql)

### mysqldumpコマンドでのエクスポート

#### コマンド
```bash
$ mysqldump -u ユーザー名 -p -h RDSのエンドポイント データベース名> エクスポート名


```

#### 実例

```bash
bonji@miko ~ % mysqldump -u admin -p -h database-1.cjgdgwwyxrfu.ap-northeast-1.rds.amazonaws.com ecsite> export.sql
Enter password: 
Warning: A partial dump from a server that has GTIDs will by default include the GTIDs of all transactions, even those that changed suppressed parts of the database. If you don't want to restore GTIDs, pass --set-gtid-purged=OFF. To make a complete dump, pass --all-databases --triggers --routines --events. 
mysqldump: Couldn't execute 'SELECT COLUMN_NAME,                       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')                FROM information_schema.COLUMN_STATISTICS                WHERE SCHEMA_NAME = 'ecsite' AND TABLE_NAME = 'order_details';': Unknown table 'COLUMN_STATISTICS' in information_schema (1109)
bonji@miko ~ %
```

[export.sql](export.sql)



## ER図の作成

### MySQLからER図を生成する

#### 1. MySQL Connections からDB接続

#### 2. ER 図作成
MySQL Workbench のメニューから「Database」-「Reverse Engineer Database」を選択します。

設定は下記の順に行って行きます。

1. Connection Option
2. Connection DBMS
3. Select Schemas
4. Retrive Objects
5. Select Objects
6. Revers Engineer
7. Results
8. 「Connection Option」で「Stored Connection」に先ほど設定した接続設定を選びます。接続情報が自動で入りますので、「Continue」で次へ
9. 「Connection DBMS」は問題なければは、そのまま「Continue」で次へ
10. 「Select Schemas」では対象のデータベースを選択して「Continue」で次へ

そのあとは、確認して問題なければ「Continue」で次へ進んで行くと ER図が作成され「EER Diagram」が表示されます。
