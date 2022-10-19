-- 主键约束：一个表中只有一个主键约束，但是要给主键约束可以由一个表中多个列组成
--
CREATE TABLE categoryinfo
(
    categoryid   VARCHAR2(10) PRIMARY KEY,
    categoryname VARCHAR2(10)
);
SELECT *
FROM categoryinfo;
-- 使用alter table 语句设置主键
ALTER TABLE categoryinfo
    ADD CONSTRAINT pk_category PRIMARY KEY (categoryid);
--pk_category 是主键约束的名称，自定义
-- 移除主键约束
ALTER TABLE categoryinfo
    DROP CONSTRAINT pk_category;
ALTER TABLE categoryinfo
    DROP PRIMARY KEY;

-- 外键约束
CREATE TABLE productinfo1
(
    productid    VARCHAR2(10) PRIMARY KEY,
    productname  VARCHAR2(20),
    productprice NUMBER(8, 2),
    quantity     NUMBER(10),
    desperation  VARCHAR2(1000),
    category     VARCHAR2(10),
    origin       VARCHAR2(10),
    CONSTRAINT fk_pro FOREIGN KEY (category) REFERENCES code.categoryinfo (categoryid)
        -- productinfo 表中的 category字段数据就必须是categoryinfo表中categoryid字段已经存在的数据，这就保证了商品类型信息的一致性
        -- constraint 后面是外键约束的名称；foreign里是指定外键约束的名称；references后面跟要引用的表名（列名）
        ON DELETE CASCADE --设置级联删除，当主键字段被删除后，外键所对应的字段也会被删除
);
--添加外键约束
ALTER TABLE productinfo1
    ADD CONSTRAINT fk_pro FOREIGN KEY (category) REFERENCES code.categoryinfo (categoryid);
-- 删除外键约束
ALTER TABLE productinfo1
    DROP CONSTRAINT fk_pro;

-- 检查约束(限定字段下输入的数据范围）
CREATE TABLE custominfo
(
    customid VARCHAR2(10),  --顾客编号
    name     VARCHAR2(10),  --顾客姓名
    age      NUMBER(2),     --顾客年龄
    gender   VARCHAR2(2),   --顾客性别
    tel      NUMBER(11),    --顾客电话
    address  VARCHAR2(100), --顾客地址
    CONSTRAINT chk_age CHECK ( age >= 18 AND age <= 99 )
);
-- 添加检查约束
ALTER TABLE custominfo
    ADD CONSTRAINT chk_gender CHECK ( gender = '男' OR gender = '女' );
--删除约束
ALTER TABLE custominfo
    DROP CONSTRAINT chk_gender;

-- 唯一约束（类似于主键约束，但是这个约束一张表内可以创建多个，主键约束只能一个）
CREATE TABLE orderinfo
(
    orderid       VARCHAR2(10), -- 订单编号
    customid      VARCHAR2(10), -- 顾客编号
    productid     VARCHAR2(10), -- 商品编号
    orderdate     VARCHAR2(10), -- 订单日期
    orderquantity NUMBER(10),   --订单数量
    senddate      VARCHAR2(10), -- 发货日期
    CONSTRAINT uni_order UNIQUE (orderid, customid)
);
-- 添加唯一约束
ALTER TABLE orderinfo
    ADD CONSTRAINT uni_product UNIQUE (productid);
-- 删除约束
ALTER TABLE orderinfo
    DROP CONSTRAINT uni_product;

-- 非空约束
CREATE TABLE manageinfo
(
    manageid  VARCHAR2(10),          -- 管理员编号
    loginname VARCHAR2(10) NOT NULL, -- 管理员姓名
    password  VARCHAR2(10) NOT NULL, -- 管理员密码
    name      VARCHAR2(10),          --管理员真实姓名
    tel       VARCHAR2(11)           --管理员俩你想方式
);
-- 添加非空约束
ALTER TABLE manageinfo
    MODIFY tel NOT NULL;
-- 删除非空约束
ALTER TABLE manageinfo
    MODIFY tel NULL;

