#/usr/bin/env bash
set -e

mysql -uroot -hlocalhost <<__EOF__
SET GLOBAL sql_mode='TRADITIONAL';

CREATE DATABASE IF NOT EXISTS 2015_training;
USE 2015_training;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id         INT             NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department_id   INT             NOT NULL,
    name            VARCHAR(255)    NOT NULL,
    age             INT             NOT NULL,
    sex             ENUM('FEMALE', 'MALE', 'OTHER') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id   INT             NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(255)    NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO
    departments (name)
    VALUES
    ('開発部'), ('営業部'), ('総務部');

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

__EOF__
