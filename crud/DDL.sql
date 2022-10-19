CREATE TABLE productinfo
(
    productid    VARCHAR2(10),   --商品编号
    productname  VARCHAR2(20),   --商品名称
    productprice NUMBER(8, 2),   --商品价格
    quantity     NUMBER(10),     --商品数量
    category     VARCHAR2(10),   --商品类型
    desperation  VARCHAR2(1000), --商品描述
    origin       VARCHAR2(10)--产地
);

SELECT *
FROM productinfo;

ALTER TABLE productinfo
    ADD test VARCHAR2(20); -- 添加列到表里


ALTER TABLE productinfo
    MODIFY test NUMBER; --修改字段类型

ALTER TABLE productinfo
    DROP COLUMN test; -- 删除字段

ALTER TABLE productinfo
    ADD test NUMBER
    MODIFY origin NUMBER; -- 修改多个字段

ALTER TABLE productinfo
    DROP (test, origin);-- 删除多个字段

ALTER TABLE productinfo
    ADD (test NUMBER,test1 NUMBER); --添加多个字段

ALTER TABLE productinfo
    MODIFY (test VARCHAR2(10),test1 VARCHAR2(1)); -- 修改多个字段

DROP TABLE productinfo;
-- 删除表

