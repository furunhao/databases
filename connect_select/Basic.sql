-- 内连接
-- 最简单的连接查询
SELECT *
FROM CONTACTS,
     PRODUCT_CATEGORIES;

-- 等值连接 " = "
SELECT
    c.CONTACT_ID,
    c.email,
    p.CATEGORY_ID,
    p.CATEGORY_NAME
FROM CONTACTS c,
     PRODUCT_CATEGORIES p
WHERE c.CONTACT_ID = p.CATEGORY_ID;

-- 不等值连接（“＞”、“＞ =”、“＜ =”、“＜”、“! =”、“＜＞”、"BETWEEN...AND..."、"IN"等连接两个条件列表，但这种方式通常需要和其他等值运算一起使用，否则检索出来的数据很可能没有实际意义。
SELECT
    c.CONTACT_ID,
    c.email,
    p.CATEGORY_ID,
    p.CATEGORY_NAME
FROM CONTACTS c
         INNER JOIN PRODUCT_CATEGORIES p ON c.CONTACT_ID IN p.CATEGORY_ID;
-- inner join 可以简写为 join （但 join 只等于 inner join）
-- 第二种写法
SELECT
    c.CONTACT_ID,
    c.email,
    p.CATEGORY_ID,
    p.CATEGORY_NAME
FROM CONTACTS c,
     PRODUCT_CATEGORIES p
WHERE c.CONTACT_ID IN p.CATEGORY_ID;

CREATE TABLE palette_a
(
    id    INT PRIMARY KEY,
    color VARCHAR2(100) NOT NULL
);

CREATE TABLE palette_b
(
    id    INT PRIMARY KEY,
    color VARCHAR2(100) NOT NULL
);

INSERT INTO palette_a (id, color)
VALUES (1, 'Red');

INSERT INTO palette_a (id, color)
VALUES (2, 'Green');

INSERT INTO palette_a (id, color)
VALUES (3, 'Blue');

INSERT INTO palette_a (id, color)
VALUES (4, 'Purple');

-- insert data for the palette_b
INSERT INTO palette_b (id, color)
VALUES (1, 'Green');

INSERT INTO palette_b (id, color)
VALUES (2, 'Red');

INSERT INTO palette_b (id, color)
VALUES (3, 'Cyan');

INSERT INTO palette_b (id, color)
VALUES (4, 'Brown');

SELECT *
FROM palette_a,
     palette_b;

-- inner join 内连接
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         INNER JOIN palette_b b ON a.color = b.color;

-- left join 左连接
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         LEFT JOIN palette_b b ON a.color = b.color;

-- left join 左连接
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         LEFT JOIN palette_b b ON a.color = b.color
WHERE b.id IS NULL;

-- right join 右连接
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         RIGHT JOIN palette_b b ON a.color = b.color
WHERE a.id IS NULL;

-- full outer join 全外连接 （outer 可选）
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         FULL OUTER JOIN palette_b b ON a.color = b.color;

-- 筛选 a.id 和 b.id 都为空的数据
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         FULL JOIN palette_b b ON a.color = b.color
WHERE a.id IS NULL
   OR b.id IS NULL;



