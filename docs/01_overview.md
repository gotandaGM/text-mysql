# データベース概要

## データベースとは何か

特定の目的のためのデータを管理して、検索、更新を容易にしたもの。


## データモデル

データの論理的/物理的な表現方法のこと。

扱うデータの性質によって、向き不向きがあります。

以下のようなデータモデルがある。

- 階層型
- ネットワーク型
- リレーショナル
- オブジェクト
- カード型

今回扱うMySQLはリレーショナルモデルを扱うデータベースです。

## リレーショナルモデル

TODO: 簡単な言及が必要


リレーショナルデータベースとしては以下のものがある。

- MySQL / MariaDB
- PostgreSQL
- MycroSoft SQL Serevr
- Oracle Database
- H2 Database


## SQL(えす･きゅー･える/しーくぇる)

主にリレーショナルデータベースにおいてデータの操作や定義を行うための言語。宣言型プログラミング言語に分類されます。
リレーショナルモデルにある程度基づいた演算体系です。

TODO: 記述が足りない

- データ定義言語(DDL Data Difinition Language)
    - CREATE
    - DROP
    - ALTER
- データ操作言語(DML Data Manipulation Language)
    - INSERT
    - UPDATE
    - DELETE
    - SELECT
- データ制御言語(DCL Data Control Language)
    - GRANT
    - REVOKE
    - SET TRANSACTION
    - BEGIN
    - COMMIT
    - ROLLBACK
    - SAVEPOINT
    - LOCK

## MySQL(まい･えす･きゅー･える)

MySQLはリレーショナルモデルで表現されており、SQL言語によって操作できるデータベースです。
オープンソースであり、GNU GPLと商用ライセンスを採用しています。

開発元はMySQL AB => Sun Microsystems => Oracleと変遷しました。
MySQLのフォークとしてMariaDBというデータベースシステムも存在します。

現在のところWebサービスで広く使われているデータベースシステムです。

### ストレージエンジン

MySQLではストレージエンジンをテーブル毎に用途に合わせて差し替えることが出来ます。
特別な用途がなければ基本的にはInnoDBを使います。

`SHOW ENGIES` で利用できるストレージエンジンが確認できます。

```
> SHOW ENGINES;
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
| Engine             | Support | Comment                                                        | Transactions | XA   | Savepoints |
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
| FEDERATED          | NO      | Federated MySQL storage engine                                 | NULL         | NULL | NULL       |
| MRG_MYISAM         | YES     | Collection of identical MyISAM tables                          | NO           | NO   | NO         |
| MyISAM             | YES     | MyISAM storage engine                                          | NO           | NO   | NO         |
| BLACKHOLE          | YES     | /dev/null storage engine (anything you write to it disappears) | NO           | NO   | NO         |
| CSV                | YES     | CSV storage engine                                             | NO           | NO   | NO         |
| MEMORY             | YES     | Hash based, stored in memory, useful for temporary tables      | NO           | NO   | NO         |
| ARCHIVE            | YES     | Archive storage engine                                         | NO           | NO   | NO         |
| InnoDB             | DEFAULT | Supports transactions, row-level locking, and foreign keys     | YES          | YES  | YES        |
| PERFORMANCE_SCHEMA | YES     | Performance Schema                                             | NO           | NO   | NO         |
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
```

### InnoDBとMyISAM

広く使われているストレージエンジンはInnoDBとMyISAMです。
現在ではInnoDBが基本的に使用されています。
特殊な用途や古いシステム以外ではMyISAMは使われないです。

- InnoDB
    - 5.5以降のデフォルトのストレージエンジン
    - MySQL 5.5からデフォルトのストレージエンジン
    - トランザクション可能
    - 読み込み処理でロックを行わない
    - 行ロックが可能
    - 外部キーをサポート
    - 主キーによるルックアップが高速
- MyISAM
    - MySQL 5.1までのデフォルトのストレージエンジン
    - テーブル全体をロックする
    - トランザクション処理が不可能

## ロックとトランザクション

## 発展

- 各データモデルが有用なユースケースは何だろうか?
- 各データモデルの実装に何があるか調べて見よう
- InnoDBとMyISAMの他にどんなストレージエンジンがあるのか?そしてどういう特徴があるのか?


