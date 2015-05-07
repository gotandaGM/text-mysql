# MySQL操作

この項では、mysqlクライアントの基本的な操作と基本的な構文を学びます。

## 準備する

`script/setup.sh`を実行することで、データをいくらでも作り直すことができます。
データ壊したら作り直してください。

```sh
git clone git@github.com:gotandaGM/text-mysql.git
cd text-mysql
script/setup.sh
```

## MySQLに接続する

`mysql`コマンドでMySQLに接続することができます。
`mysql --help`でオプションが確認出来ます。詳しい使い方については`man mysql`でman pageを引いてみるとよいでしょう。
コマンドの使い方に迷ったときは、基本的にググる前にman pageを引く癖をつけるとよいです。

```sh
mysql -uroot -hlocalhost 2015_training_02;
```

## データベース/テーブルを確認する

どんなデータベースがあるか、どんなテーブルがあるか確認しましょう。
`USE ${DATABASE_NAME}`でデータベースを切り替えることができます。

```sql
SHOW DATABASES;
USE 2015_training_02;
SHOW TABLES;
```

`users`、`departments`の2テーブルがあります。どんなスキーマ構造になっているか確認しましょう。

```sql
SHOW CREATE TABLE users\G
SHOW CREATE TABLE departments\G
```

## SELECT

`SELECT [${COLUMN} ..] FROM ${TABLE_NAME}`の形式でデータが取得出来ます。
`*`を指定すると全てのカラムを取得出来ます。

```sql
SELECT * FROM users;
SELECT * FROM departments;
SELECT name,age,sex FROM uses;
```

### WHERE

WHERE句で検索条件を指定出来ます。

```sql
SELECT * FROM users WHERE user_id=1;
SELECT * FROM users WHERE department_id=2;

SELECT * FROM users WHERE department_id<>2;
SELECT * FROM users WHERE department_id!=2;
SELECT * FROM users WHERE age>25;
SELECT * FROM users WHERE sex='FEMALE';

SELECT * FROM users WHERE department_id IN (1,3);
```

### ORDER BY

順序を指定出来ます。デフォルトでは昇順(ASC)です。

```sql
SELECT * FROM users ORDER BY age;
SELECT * FROM users ORDER BY age DESC;
SELECT * FROM users ORDER BY age DESC, department_id;
```

### LIMIT OFFSET

取得件数を制限出来ます。
アプリケーションで使う時はデータサイズが小さいなど特別な理由が無い限り、`LIMIT`句は必ず付けます。

```sql
SELECT * FROM users LIMIT 10;
SELECT * FROM users LIMIT 10 OFFSET 10;
```

### 集約

集約関数を使用すると、SQLの結果は集合では無く、集約値が返るようになります。

```sql
select AVG(age), COUNT(*) from users;
select MAX(age) from users;
```

集約関数には以下のものがあります。

- SUM() 総和
- COUNT() 総数
- MAX() 最大値
- MIN() 最小値
- AVG() 平均値

### GROUP BY

特定のカラムの値でグループ化して、その値を集約することができます。

```sql
SELECT department_id, AVG(age), COUNT(*) FROM users GROUP BY department_id;
```

### HAVING

集約した結果をフィルター条件にすることができます。
`WHERE`句との違いを意識してください。

```sql
SELECT department_id, AVG(age), COUNT(*) FROM users GROUP BY department_id HAVING AVG(age)>30;
SELECT department_id, AVG(age), COUNT(*) FROM users GROUP BY department_id HAVING COUNT(*)>10;
```

### JOIN

複数テーブルを結合することができます。

```sql
SELECT
    users.name, age, sex, departments.name
    FROM users
    INNER JOIN departments
        ON users.department_id=departments.department_id
    ;

SELECT
    departments.name, AVG(users.age), COUNT(*)
    FROM users
    INNER JOIN departments
        ON users.department_id=departments.department_id
    GROUP BY users.department_id
    HAVING AVG(age)>30
    ;

SELECT
    departments.name, AVG(users.age), COUNT(*)
    FROM users
    INNER JOIN departments
        ON users.department_id=departments.department_id
    GROUP BY users.department_id
    HAVING COUNT(*)>10
    ;

```

### INNER JOIN / OUTER JOIN

`INNER JOIN`は、両テーブルともに結合条件に一致する行を返します。
対して`(RIGHT|LEFT)OUTER JOIN`は片方のテーブルにのみ存在する行でも返します。
データが存在しないテーブルのカラムに関しては`NULL`の値が入ります。

```sql
SELECT users.name, age, sex, departments.name, titles.name
    FROM users
    INNER JOIN departments
        ON users.department_id=departments.department_id
    INNER JOIN user_titles
        ON users.user_id=user_titles.user_id
    INNER JOIN titles
        ON user_titles.title_id=titles.title_id
    ;

SELECT users.name, age, sex, departments.name, titles.name
    FROM users
    INNER JOIN departments
        ON users.department_id=departments.department_id
    INNER JOIN user_titles
        ON users.user_id=user_titles.user_id
    RIGHT OUTER JOIN titles
        ON user_titles.title_id=titles.title_id
    ;

SELECT users.name, age, sex, departments.name, titles.name
    FROM users
    INNER JOIN departments
        ON users.department_id=departments.department_id
    LEFT OUTER JOIN user_titles
        ON users.user_id=user_titles.user_id
    LEFT OUTER JOIN titles
        ON user_titles.title_id=titles.title_id
    ;
```

## UPDATE

データを更新します。

```sql
UPDATE users SET name='けんたす' WHERE name='けんたふ';
```

正しく更新出来たか確認してみましょう。

```sql
SELECT * FROM users WHERE name='けんたす';
SELECT * FROM users WHERE name='けんたふ';
```

ちょっと戯れで、`WHERE`句無しで`UPDATE`してみましょう。

```sql
UPDATE users SET name='ぱぴっくす'; -- Oops!
SELECT * FROM users;
```

これじゃいけませんね。データを戻しましょう。

```sh
script/setup.sh
```

## INSERT

データを追加します。複数行のデータをまとめて追加することも出来ます(`バルクインサート`)。

```sql
INSERT INTO users (name, age, sex, department_id) VALUES ('せりざわ',21,'FEMALE',1);
INSERT INTO users (name, age, sex, department_id) VALUES ('くぼた',21,'FEMALE',1), ('わかい',19,'FEMALE',1);
```

## DELETE

```sql
DELETE FROM users; -- Oops!
```

間違えて全データ消してしまったので、データ作り直しましょう。

```sh
script/setup.sh
```

`UPDATE`と同じで`WHERE`句に注意。

```sql
DELETE FROM users WHERE name='くぼた';
```

## トランザクション

先まで`INSERT`、`UPDATE`、`DELETE`は実行した後即座にデータ反映されていましたが、
これはMySQLのデフォルトの挙動として各処理毎にトランザクションがオートコミットされているためです。

`SET AUTOCOMMIT=0;`するか明示的にトランザクションを始めてあげることでオートコミットを無効にすることができます。
mysqlクライアントから変更処理をするときは明示的にトランザクションを開始するようにするとミスが減るでしょう。

`ROLLBACK`でトランザクション中の変更を元に戻すことが出来ます。

```sql
SELECT COUNT(*) FROM users;

-- トランザクション開始
BEGIN WORK;
DELETE FROM users;
SELECT COUNT(*) FROM users;

-- ロールバック
ROLLBACKE;
SELECT COUNT(*) FROM users;
```

```sql
BEGIN WORK;
DELETE FROM users WHERE name='ゆうき';
COMMIT;
```

## クライアントのちょっとしたTips

### キーバインド

基本的にshellのキーバインドと一緒です。`emacs`のキーバインドに近いので覚えておくとよいでしょう。

| バインド | 内容                 |
|:---------|:---------------------|
| Ctrl + w | 直前の1word削除      |
| Ctrl + h | 直前の1character削除 |
| Ctrl + a | 先頭にカーソル移動   |
| Ctrl + e | 末尾にカーソル移動   |

### edit

mysql client上で`edit`と打つとエディターが立ち上がります。
エディター上で入力内容を編集することが出来ます。

## warningsの有効化

`\W`を打つことでwarningsの出力を有効にできます。デフォルトでは無効になってます。
`\w`で無効に出来ます。

無効になっているときは`SHOW WARNIGS;`で直前の処理のwarningsを表示出来ます。

## コマンドラインの実行取りやめ

`\c`[ENTER]でコマンドラインで打ったコマンドを実行しないで次のコマンドラインに移れます。

## リソース

- Web
    - [MySQLのプロンプトを変更する。](http://nippondanji.blogspot.jp/2009/03/mysql.html)
    - [快適mysqlコマンド★カスタマイズの決定版](http://d.hatena.ne.jp/hirose31/20131225/1387942323)

