-- ##################################
-- client 1 に切り替え
USE 2015_training_01;
SELECT * FROM user_balances;
BEGIN WORK;

-- ##################################
-- ここでUSER_Aの口座をロック
UPDATE user_balances SET balance=balance - 100000 WHERE user_name='USER_A';

-- ##################################
-- client 2 に切り替え
USE 2015_training_lock;
SELECT * FROM user_balances;
BEGIN WORK;

-- ここでUSER_Bの口座をロック
UPDATE user_balances SET balance=balance - 200000 WHERE user_name='USER_B';

-- ##################################
-- client 1 に切り替え
UPDATE user_balances SET balance=balance + 100000 WHERE user_name='USER_B';

-- USER_Bの口座がclient 2によってロックされてるので、ロック解除待ち

-- ##################################
-- client 2 に切り替え
UPDATE user_balances SET balance=balance + 200000 WHERE user_name='USER_A';

-- USER_Aの口座がclient 1によってロックされてるので、ここでデッドロック

