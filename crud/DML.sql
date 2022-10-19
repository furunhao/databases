-- 添加用 insert; 修改用 update; 删除用 delete; 搜索用 select;
-- 插入数据
SELECT *
FROM manageinfo;
INSERT INTO manageinfo
(manageid,
 loginname,
 password,
 name,
 tel)
VALUES ('1',
        'xiaowang',
        '123456',
        'liming',
        '12345678');

SELECT *
FROM logininfo;
CREATE TABLE logininfo
(
    loginname     VARCHAR2(10), -- 管理员注册名
    loginpassword VARCHAR2(10)  -- 管理员密码
);
-- 通过其他表向表里插入数据(确保两张表列的个数和字段数据类型一样才可以使用）
INSERT INTO logininfo
(loginname,
 loginpassword)
SELECT
    loginname,
    password
FROM manageinfo;
-- 目标表里的数据都会插入到新表里

-- 直接创建带数据的表
SELECT *
FROM login;
CREATE TABLE login AS
SELECT
    loginname,
    password
FROM manageinfo;
INSERT INTO login
(loginname,
 password)
VALUES ('wang',
        '123');
INSERT INTO login
(loginname,
 password)
VALUES ('zhang',
        '123');

-- 修改数据
UPDATE login
SET loginname = 'test'; -- 不加where条件会修改loginname字段下的所有数据
UPDATE login
SET loginname = 'zhang'
WHERE password = '123456';
-- 修改条件修改指定的数据

-- 删除数据
DELETE
FROM login; -- 删除表内所有的数据
DELETE
FROM login
WHERE loginname = 'wang';
--删除指定的数据
-- truncate 删除数据；和delete一样，删除表里的数据，但是速度明显提高
TRUNCATE TABLE login;

--


