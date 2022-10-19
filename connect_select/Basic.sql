-- ������
-- ��򵥵����Ӳ�ѯ
SELECT *
FROM CONTACTS,
     PRODUCT_CATEGORIES;

-- ��ֵ���� " = "
SELECT
    c.CONTACT_ID,
    c.email,
    p.CATEGORY_ID,
    p.CATEGORY_NAME
FROM CONTACTS c,
     PRODUCT_CATEGORIES p
WHERE c.CONTACT_ID = p.CATEGORY_ID;

-- ����ֵ���ӣ������������� =�������� =��������������! =��������������"BETWEEN...AND..."��"IN"���������������б������ַ�ʽͨ����Ҫ��������ֵ����һ��ʹ�ã�����������������ݺܿ���û��ʵ�����塣
SELECT
    c.CONTACT_ID,
    c.email,
    p.CATEGORY_ID,
    p.CATEGORY_NAME
FROM CONTACTS c
         INNER JOIN PRODUCT_CATEGORIES p ON c.CONTACT_ID IN p.CATEGORY_ID;
-- inner join ���Լ�дΪ join ���� join ֻ���� inner join��
-- �ڶ���д��
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

-- inner join ������
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         INNER JOIN palette_b b ON a.color = b.color;

-- left join ������
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         LEFT JOIN palette_b b ON a.color = b.color;

-- left join ������
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         LEFT JOIN palette_b b ON a.color = b.color
WHERE b.id IS NULL;

-- right join ������
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         RIGHT JOIN palette_b b ON a.color = b.color
WHERE a.id IS NULL;

-- full outer join ȫ������ ��outer ��ѡ��
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         FULL OUTER JOIN palette_b b ON a.color = b.color;

-- ɸѡ a.id �� b.id ��Ϊ�յ�����
SELECT
    a.id    id_a,
    a.color color_a,
    b.id    id_b,
    b.color color_b
FROM palette_a a
         FULL JOIN palette_b b ON a.color = b.color
WHERE a.id IS NULL
   OR b.id IS NULL;



