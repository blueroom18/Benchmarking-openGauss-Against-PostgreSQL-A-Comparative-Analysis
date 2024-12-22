-- 2.数据访问和更新的竞争
-- 2.1 查询
-- Simple selection
EXPLAIN ANALYSE
SELECT * FROM person WHERE id = 0;

-- 计算age列的总和
EXPLAIN ANALYSE
SELECT SUM(id) AS total_age FROM person;

-- 计算age列的行数
EXPLAIN ANALYSE
SELECT COUNT(id) AS total_count FROM person;

-- 计算age列的总和，并过滤age > 30的记录
EXPLAIN ANALYSE
SELECT SUM(id) AS total_age
FROM person
WHERE id > 30;

-- 计算age列的行数，并过滤age > 30的记录
EXPLAIN ANALYSE
SELECT COUNT(id) AS total_count
FROM person
WHERE id > 30;

-- 2.2 UPDATE 操作中的竞争
-- 行级锁
-- 执行第一个事务的操作
BEGIN;
UPDATE person SET name = 'Temp1' WHERE id = 1;

-- 在另一个会话中执行此查询
SELECT * FROM pg_locks WHERE relation = (SELECT oid FROM pg_class WHERE relname = 'person');

-- 执行第二个事务的操作
BEGIN;
UPDATE person SET name = 'Temp2' WHERE id = 1;

-- 检查代码
SELECT * FROM pg_locks WHERE relation = (SELECT oid FROM pg_class WHERE relname = 'person');

-- 表级锁的检测
BEGIN;
ALTER TABLE person ADD COLUMN address VARCHAR;
COMMIT;
-- 在另一个会话中执行此查询
BEGIN;
SELECT * FROM person;
COMMIT;

SELECT * FROM pg_stat_activity;  -- 查看当前活动的会话
SELECT * FROM pg_locks;          -- 查看当前锁的信息








--
Create table formal_user(name VARCHAR, email VARCHAR);

-- 创建临时表
CREATE TEMP TABLE tmp_users (name VARCHAR, email VARCHAR);

-- 插入数据到临时表
INSERT INTO tmp_users (name, email)
SELECT 'user' || generate_series(1, 1000000), 'user' || generate_series(1, 1000000) || '@examp';


-- 导出数据到文件
copy formal_user (name, email) FROM 'd/LearnCS/tmp_users.csv' WITH CSV;

-- 使用 COPY 从文件插入到目标表
COPY formal_user (name, email) FROM 'd/LearnCS/tmp_users.csv' WITH CSV;