SET GLOBAL sql_mode='TRADITIONAL';

CREATE DATABASE IF NOT EXISTS 2015_training_01;
USE 2015_training_01;

DROP TABLE IF EXISTS user_hit_points;
CREATE TABLE user_hit_points (
    user_name       VARCHAR(255)    NOT NULL PRIMARY KEY,
    hit_point       INT UNSIGNED    NOT NULL,
    max_hit_point   INT UNSIGNED    NOT NULL,
    status          ENUM('normal', 'poison') NOT NULL
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
    sex             ENUM('FEMALE', 'MALE', 'OTHER') NOT NULL,
    INDEX           department_id (department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id   INT UNSIGNED    NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(255)    NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
    title_id        INT UNSIGNED    NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(255)    NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS user_titles;
CREATE TABLE user_titles (
    user_id         INT UNSIGNED    NOT NULL,
    title_id        INT UNSIGNED    NOT NULL,
    PRIMARY KEY user_title(user_id, title_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO
    departments (name)
    VALUES
    ('開発部'),
    ('営業部'),
    ('総務部')
    ;

INSERT INTO
    titles (name)
    VALUES
    ('チーフ'),
    ('リーダー'),
    ('シニア'),
    ('アドバンスドシニア')
    ;

INSERT INTO
    users (department_id, name, age, sex)
    VALUES
    (1, 'かるぱす', 25, 'MALE'),
    (1, 'けんたふ', 30, 'MALE'),
    (1, 'まさすず', 21, 'MALE'),
    (1, 'ぱぴくす', 28, 'MALE'),
    (1, 'みはえる', 25, 'MALE'),
    (1, 'みれい',   18, 'FEMALE'),
    (1, 'すえなみ', 34, 'MALE'),
    (1, 'しおん',   17, 'FEMALE'),
    (1, 'さきさま', 23, 'FEMALE'),
    (1, 'とくひろ', 39, 'MALE'),
    (1, 'とます',   32, 'MALE'),
    (1, 'いちろを', 42, 'MALE'),
    (1, 'まさらき', 43, 'MALE'),
    (2, 'あずき',   24, 'FEMALE'),
    (2, 'りっく',   34, 'MALE'),
    (2, 'ぐすたふ', 36, 'MALE'),
    (2, 'まつした', 26, 'MALE'),
    (2, 'じゃん',   22, 'MALE'),
    (2, 'にらたま', 25, 'MALE'),
    (2, 'ふぁど',   29, 'MALE'),
    (2, 'そらは',   32, 'MALE'),
    (2, 'あべいち', 36, 'MALE'),
    (2, 'あまねす', 49, 'MALE'),
    (3, 'まっつ',   27, 'MALE'),
    (3, 'にぽたん', 27, 'MALE'),
    (2, 'まれい',   27, 'FEMALE'),
    (2, 'まえも',   23, 'FEMALE'),
    (3, 'ひみか',   23, 'FEMALE'),
    (3, 'ぜにば',   23, 'FEMALE'),
    (3, 'ひみたす', 21, 'FEMALE'),
    (3, 'いとまき', 25, 'FEMALE'),
    (3, 'たけたし', 33, 'MALE'),
    (3, 'ゆう',     23, 'FEMALE'),
    (3, 'ゆうき',   19, 'FEMALE')
    ;


INSERT INTO
    user_titles (user_id, title_id)
    VALUES
    (1, 1),
    (6, 1),
    (5, 1),
    (8, 1),
    (9, 1),
    (7, 2),
    (2, 2),
    (15, 3)
    ;

CREATE DATABASE IF NOT EXISTS 2015_training_03;
USE 2015_training_03;


DROP TABLE IF EXISTS score;
CREATE TABLE score (
    student_name    VARCHAR(64)     NOT NULL,
    class_name      VARCHAR(64)     NOT NULL,
    grade           VARCHAR(64)     NOT NULL,
    score           VARCHAR(64)     NOT NULL,
    PRIMARY KEY student_class(student_name, class_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
