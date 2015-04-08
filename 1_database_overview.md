# データベース概要

途中。まだまだ書き足すよ。

## データベースとは何か

特定の目的のためのデータを管理して、検索、更新を容易にしたもの。


## データモデル

データの論理的/物理的な表現方法のこと。

以下のようなデータモデルがある。

- 階層型
- ネットワーク型
- リレーショナル
- オブジェクト
- カード型

## リレーショナルモデル

TODO: 簡単な言及が必要

## SQL(えす･きゅー･える/しーくぇる)

主にリレーショナルデータベースにおいてデータの操作や定義を行うための言語。宣言型プログラミング言語に分類される。
リレーショナルモデルにある程度基づいた演算体系である。

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

MySQLはリレーショナルモデルで表現されており、SQL言語によって操作する。データベースである。
オープンソースであり、GNU GPLと商用ライセンスを採用している。

開発元はMySQL AB => Sun Microsystems => Oracleと変遷している。
MySQLのフォークとしてMariaDBというデータベースシステムも存在する。

TODO: 記述が足りない

### ストレージエンジン


TODO: MyISAMのことを書く

TODO: InnoDBのことを書く


## 発展

- 各データモデルが有用なユースケースは何だろうか?
- 各データモデルの実装に何があるか調べて見よう
- InnoDBとMyISAMの他にどんなストレージエンジンがあるのか?そしてどういう特徴があるのか?


