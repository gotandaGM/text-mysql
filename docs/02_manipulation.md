# MySQL操作

## 準備する

```sh
git clone git@github.com:gotandaGM/text-mysql.git
cd text-mysql
script/setup.sh
```

## MySQLに接続する

```sh
mysql -uroot -hlocalhost
USE 2015_training
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


## チューニングに関して


