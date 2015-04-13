# MySQL操作

## 準備する

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
mysql -uroot -hlocalhost 2015_training_01;
```

## データベース/テーブルを確認する

```sql
SHOW DATABASES;
SHOW TABLES;
```

```sql
SHOW CREATE TABLE users\G
SHOW CREATE TABLE departments\G
```

## SELECT


```sql
SELECT * FROM users;
SELECT * FROM departments;
SELECT name,age,sex FROM uses;
```

### WHERE

```sql
SELECT * FROM users WHERE user_id=1;
SELECT * FROM users WHERE department_id=2;

SELECT * FROM users WHERE department_id<>2;
SELECT * FROM users WHERE department_id!=2;
SELECT * FROM users WHERE age>25;
SELECT * FROM users WHERE sex='FEMALE';
```

### ORDER BY

```sql
SELECT * FROM users ORDER BY age;
SELECT * FROM users ORDER BY age DESC;
SELECT * FROM users ORDER BY age DESC, department_id;
```

### LIMIT OFFSET

```sql
SELECT * FROM users LIMIT 10;
SELECT * FROM users LIMIT 10 OFFSET 10;
```

### 集約

```sql
select AVG(age), COUNT(*) from users;
```

### GROUP BY

```sql
SELECT department_id, AVG(age), COUNT(*) FROM users GROUP BY department_id;
SELECT department_id, AVG(age), COUNT(*) FROM users GROUP BY department_id HAVING AVG(age)>30;
SELECT department_id, AVG(age), COUNT(*) FROM users GROUP BY department_id HAVING COUNT(*)>10;
```

### JOIN

```sql
SELECT users.name, age, sex, departments.name FROM users INNER JOIN departments ON users.department_id=departments.department_id;
SELECT
    departments.name, AVG(users.age), COUNT(*)
    FROM users
    INNER JOIN departments ON users.department_id=departments.department_id
    GROUP BY users.department_id
    HAVING AVG(age)>30
    ;
SELECT
    departments.name, AVG(users.age), COUNT(*)
    FROM users
    INNER JOIN departments ON users.department_id=departments.department_id
    GROUP BY users.department_id
    HAVING COUNT(*)>10
    ;
```

### INNER JOIN / OUTER JOIN

```sql
SELECT users.name, age, sex, departments.name, titles.name
    FROM users
    INNER JOIN departments
        ON users.department_id=departments.department_id
    INNER JOIN user_titles
        ON users.user_id=user_titles.user_id
    INNER JOIN titles
        ON user_titles.title_id=titles.title_id

SELECT users.name, age, sex, departments.name, titles.name
    FROM users
    INNER JOIN departments
        ON users.department_id=departments.department_id
    INNER JOIN user_titles
        ON users.user_id=user_titles.user_id
    RIGHT OUTER JOIN titles
        ON user_titles.title_id=titles.title_id

SELECT users.name, age, sex, departments.name, titles.name
    FROM users
    INNER JOIN departments
        ON users.department_id=departments.department_id
    LEFT OUTER JOIN user_titles
        ON users.user_id=user_titles.user_id
    LEFT OUTER JOIN titles
        ON user_titles.title_id=titles.title_id
```

## UPDATE

```sql
UPDATE users SET name='けんたす' WHERE name='けんたふ';
```

## INSERT

```sql
INSERT INTO users (name, age, sex, department_id) VALUES ('せりざわ',21,'FEMALE',1);
INSERT INTO users (name, age, sex, department_id) VALUES ('くぼた',21,'FEMALE',1), ('わかい',19,'FEMALE',1);
```

## DELETE

```sql
DELETE FROM users; -- Oops!
DELETE FROM users WHERE name='くぼた';
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

