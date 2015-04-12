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
- キーバリュー型

今回扱うMySQLはリレーショナルモデルを扱うデータベースです。

## リレーショナルモデル

リレーショナルモデルは現在のシステム開発に於いて広く使われているデータモデルです。

### リレーショナルモデルの要素

- リレーション(関係)
    - 1つの見出しと0以上の同じドメインのタプルから構成される、**順序づけされてない**集合からなるデータ構造
- タブル(組)
    - 1つ以上のアトリビュート属性の集合からなるデータ構造
- アトリビュート(属性)
    - アトリビュート名とドメインからなるペア
- ドメイン(定義域)
    - データ型と考えて良い
    - あるデータ要素が取り得る一意な値からなる有限集合


社員リレーションの例で考えてみる

    アトリビュート(順不同)
        |
        V
    +---------------+-------------+----------------+
    | 名前:文字列型 | 年齢:整数型 | 部署:文字列型  |   <= 見出し
    +---------------+-------------+----------------+
    | 山田太郎      | 19          | 総務部         |   <= タプル(順不同)
    +---------------+-------------+----------------+
    | 山田花子      | 22          | 開発部         |
    +---------------+-------------+----------------+

便宜上、表で書いてますが、アトリビュートにもタプルにも順序は無いです。

### 正規化

話すとだいぶ長くなるので、概要だけ。#TODO

### リレーショナルモデルの実装

リレーショナルデータベースとしては以下のものがあります。

- [MySQL](http://www.mysql.com/) / [MariaDB](https://mariadb.org/) / [Percona Server](http://www.percona.com/software/percona-server)
- [PostgreSQL](http://www.postgresql.org/)
- [MycroSoft SQL Serevr](http://www.microsoft.com/ja-jp/sqlserver)
- [Oracle Database](http://www.oracle.com/jp/database/overview/)
- [SQLite](https://www.sqlite.org/)
- [H2 Database](http://www.oracle.com/jp/database/overview/)


## SQL(えす･きゅー･える/しーくぇる)

主にリレーショナルデータベースにおいてデータの操作や定義を行うための言語。宣言型プログラミング言語に分類されます。
リレーショナルモデルにある程度基づいた演算体系です。

SQLは大きく分けて3つ区分があります。

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

### SQLとリレーショナルモデルの差異

用語の差異

| リレーショナルモデル | SQL             |
|:---------------------|:----------------|
| リレーション         | table(テーブル) |
| タブル               | row(行)         |
| アトリビュート       | column(列)      |
| ドメイン             | type(型)        |


- rowの順番は主キーに順序づけされてる
- columnの順番はtable定義時に順序づけされている
- NULLの存在
- インデックスの存在


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
- 各データモデルの実装に何があるのか?
- MySQL以外のデータベース製品の特長とユースケースはなんだろうか?
- InnoDBとMyISAMの他にどんなストレージエンジンがあるのか?そしてどういう特徴があるのか?


