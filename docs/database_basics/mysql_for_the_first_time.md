# はじめてのMySQL

AWSを利用したMySQLデータベース構築を実施して、SQL操作を体験


## RDSの構築

1. AWSコーンソール画面より、Amazon RDSサービスへの画面へ遷移する
2. 「Amazon RDB サービス」画面より、「データベースを作成」ボタンを押下
3. 「データベース作成」画面へ移行したら、以下の選択を行います。
    1. データベース作成方法を選択: 標準作成
    2. エンジンのオプション: MySQL
    3. バージョン: MySQL 5.7.34
    4. テンプレート: 無料利用枠
    5. DBインスタンス識別し: MyBD1
    6. マスターユーザ名: admin
    7. パスワード: hage3333
4. 「データベースの作成」ボタンを押下
5. 「データベース」画面で、作成したDBの一覧が表示されますが、作成したDB識別子を確認し、該当するDBが作成中から完了になるまでしばらく待ちます。



## MySQL Workbenchのインストール

```zsh
brew install -y mysqlworkbench

```

## RDSとの接続にてRDBとの接続


### MySQL Workbench

1. 作成したDBを選択すると、データベースの詳細画面並行します。
2. セキュリティ上問題になるが、「パブリックアクセシビリティ」の変更を行います。
    1. 右上の「変更」ボタンを押します。
    2. 「接続」の「追加設定」にて、「パブリックアクセス可能」を選択
    3. 「続行」ボタンを押下
    4. 「すぐに変更」を選択して、「DBインスタンスの変更」を押下
3. セキュリティルール変更します。
    1. 作成したデータベースを選択して「接続とセキュリティ」欄の「セキュリティ」「VPCセキュリティグループ」のリンクを選択
    2. 「セキュリティグループ」画面で、「インバウンドルール」タブを選択し、0.0.0.0/0に変更する
4. データベースへMySQL WorkBenchで接続
    1. データベースのエンドポイントをコピー  
    database-1.cjgdgwwyxrfu.ap-northeast-1.rds.amazonaws.com
    2. MySQL WorkBenchのMySQL Connectionを押下
    3. 以下設定して、接続する
        1. Connection Nameに任意の名前を設定
        2. hostname : RDSのエンドポイント
        3. Port: 3306
        4. User Name: admin
        5. password
    4. 接続したら、Quaryタブのコマンド実行欄で`show databases;`と打って`Command + enter`で実行し、Databaseが表示されていること確認。

### mysqlコマンドにてRDBとの接続


```mysql

mysql --host RDSデータベースのエンドポイント -u ユーザ名 -p
```

```mysql
% mysql --host RDSデータベースのエンドポイント --user admin -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 516
Server version: 5.7.34-log Source distribution

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| innodb             |
| mysql              |
| orders             |
| performance_schema |
| sys                |
+--------------------+
6 rows in set (0.01 sec)

mysql>

```



## ローカルにMySQL構築


### brew でインストール

Amazon RDSを利用して学習は進めますが、通常の利用方法と同じように学習端末のローカルにMySQL をインストールする方法もあります。


MySQLをHOMEBREWでインストーします。

```zsh
% brew intall mysql
```

無事インストールされたこと確認しあmす。

```zsh

% mysql -V     
mysql  Ver 8.0.26 for macos11.3 on x86_64 (Homebrew)% mysql -V
```


HOMEBREWでMySQLのサービスを開始します。

```zsh
% brew services start mysql
```

MySQLに接続します。

```zsh
% mysql -uroot
```

念の為 `root`ユーザのパスワードは変更しておきます。

```mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 8.0.26 Homebrew

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'パスワード';
Query OK, 0 rows affected (0.00 sec)

mysql> quit


```

パスワードを使って接続します。

```mysql
% mysql -uroot -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 12
Server version: 8.0.26 Homebrew

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)
mysql> quit
Bye

```


## MySQL Dcokerイメージでの導入

```mysql
# Docker-hubからMySQLのイメージをインストールする
$ docker pull mysql

# インストールしたイメージから、コンテナを起動･作成する
# MYSQL_ROOT_PASSWORDにログインする際のパスワードを設定する
$ docker run -it --name test-wolrd-mysql -e MYSQL_ROOT_PASSWORD=mysql -d mysql:latest

$ docker exec -it test-wolrd-mysql bash -p

# MySQLのコンテナにログインする
$ mysql -u root -p -h 127.0.0.1

Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 8.0.16 MySQL Community Server - GPL

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

> mysql

```

## Docker ComposeでのMySQLコンテナ起動
