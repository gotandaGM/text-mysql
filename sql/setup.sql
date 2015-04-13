SET GLOBAL sql_mode='TRADITIONAL';

CREATE DATABASE IF NOT EXISTS 2015_training_01;
USE 2015_training_01;

DROP TABLE IF EXISTS user_hit_points;
CREATE TABLE user_hit_points (
    user_name       VARCHAR(255)    NOT NULL PRIMARY KEY,
    hit_point       INT UNSIGNED    NOT NULL,
    max_hit_point   INT UNSIGNED    NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO
    user_hit_points (user_name, hit_point, max_hit_point)
    VALUES
    ('USER_A', 100, 300),
    ('USER_B', 300, 300)
    ;

DROP TABLE IF EXISTS user_balances;
CREATE TABLE user_balances (
    user_name       VARCHAR(255)    NOT NULL PRIMARY KEY,
    balance         INT UNSIGNED    NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO
    user_balances (user_name, balance)
    VALUES
    ('USER_A', 100000),
    ('USER_B', 300000)
    ;

CREATE DATABASE IF NOT EXISTS 2015_training_02;
USE 2015_training_02;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id         INT UNSIGNED    NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department_id   INT UNSIGNED    NOT NULL,
    name            VARCHAR(255)    NOT NULL,
    age             INT UNSIGNED    NOT NULL,
    sex             ENUM('FEMALE', 'MALE', 'OTHER') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id   INT UNSIGNED    NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(255)    NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO
    departments (name)
    VALUES
    ('開発部'),
    ('営業部'),
    ('総務部')
    ;

INSERT INTO
    users (department_id, name, age, sex)
    VALUES
    (1, 'かるぱす', 25, 'MALE'),
    (1, 'けんたふ', 30, 'MALE'),
    (1, 'まさすず', 21, 'MALE'),
    (1, 'ぱぴくす', 28, 'MALE'),
    (1, 'みはえる', 25, 'MALE'),
    (2, 'ぐすたふ', 36, 'MALE'),
    (2, 'まつした', 26, 'MALE'),
    (2, 'じゃん',   22, 'MALE'),
    (2, 'ふぁど',   29, 'MALE'),
    (2, 'あべいち', 36, 'MALE'),
    (2, 'まえも',   23, 'FEMALE'),
    (3, 'ぜにば',   23, 'FEMALE'),
    (3, 'いとまき', 25, 'FEMALE'),
    (3, 'たけたし', 33, 'MALE'),
    (3, 'ひみたす', 21, 'FEMALE'),
    (3, 'さきさま', 23, 'FEMALE')
    ;


