-- ����ʹ�� * �Ų�ѯ�����������ݣ���ȷ��Ҫ��ѯ���ֶΣ�
-- * �Ų�ѯ��Ч�������Բ���ָ���ֶ�ȥ��ѯ��������������ֶΣ�ʹ�� * �Ų�ѯ�������������쳣
INSERT
INTO productinfo
(productid,
 productname,
 productprice,
 quantity,
 category,
 desperation,
 origin)
VALUES ('0240040001',
        '����',
        '7000',
        '20',
        '010030001',
        '4444',
        '');
-- ʹ�ñ��� as ��ѯ
SELECT
    productid   AS a,
    productname AS b,
    productprice   c
FROM productinfo;
SELECT *
FROM productinfo;
-- ��ѯ��ʹ�ñ��ʽ��ע�⣬����Ĳ�ѯ����������ı����ݿ����ֵ�� || �� ���ӷ��ţ��� Java �������ַ����� + ��
SELECT
    productid,
    productname,
    productprice || ' * ' || 1.25 || ' = ' || productprice * 1.25 AS newprice
FROM productinfo;
-- substr ��������ȡ��������
SELECT
    SUBSTR(productid, 0, 4) ��ȡǰ4λ���
FROM productinfo;
-- ��ʾ��0��ʼ���ܹ�չʾ�ĸ��ַ���0����ľ��ǵ�һ���ַ�
-- �����ظ�����
SELECT DISTINCT
    productid AS �����ظ�id,
    productid,
    productname,
    productprice
FROM productinfo;

-- ��ѯָ���ֶε�����
SELECT
    first_name,
    last_name
FROM contacts;

-- ����ָ��ĳ��ģʽ�µı����ͼ����;   ģʽ.����.�ֶΣ��������Բ�ѯ����ģʽ�µı�
SELECT
    code.contacts.contact_id,
    contacts.first_name,
    contacts.last_name
FROM code.contacts;

-- ���� order by(Ĭ���� ASC ����չʾ������ DeSC ������ʾ
SELECT
    product_id,
    product_name,
    standard_cost,
    list_price
FROM products
ORDER BY list_price DESC;
-- ���Ȱѿ�ֵչʾ�ڶ���
SELECT *
FROM productinfo
ORDER BY origin NULLS FIRST;
-- ���Ȱѿ�ֵչʾ�ڵײ�
SELECT *
FROM productinfo
ORDER BY origin NULLS LAST;
-- ʹ�ò�ѯ�б����ֶε�λ�ã����ִ����ֶ��ڱ����λ�ã�����Ϊ�����ֶΣ���ô��һ��Ϊ�˷��㣬����Ϊ�˷�ֹʹ��UNIONʱ���ִ���
SELECT *
FROM productinfo
ORDER BY 7 DESC;
-- ���ֶ����򣺵���һ���ֶ�������ͬʱ���Ż�Եڶ����ֶ�����
SELECT *
FROM productinfo
ORDER BY 1 DESC,
         2 DESC,
         3 DESC,
         4 DESC,
         5 DESC,
         6 DESC,
         origin NULLS LAST;
-- where ��䣨����������
SELECT
    product_id,
    product_name,
    list_price
FROM products
WHERE list_price > 3000
ORDER BY list_price DESC;
-- <>  Ҫ�� list_price �ֶ��²����� 8867.99 ������ ; ��ͬ�� != (�����ڣ�
SELECT
    product_id,
    product_name,
    list_price
FROM products
WHERE list_price > 3000
  AND list_price != 5499.99;

SELECT
    product_id,
    product_name,
    list_price
FROM products;
-- ʹ�� substr �����г�ǰ��λ���� intel ������
SELECT
    product_id,
    product_name,
    list_price
FROM products
WHERE SUBSTR(product_name, 0, 3) = 'AMD';
-- where �����������
SELECT
    product_id,
    product_name,
    list_price
FROM products
WHERE list_price <= 3500
  AND list_price >= 3000;
-- ����������ļ�д��(between ��ߵ�ֵҪ���ұߵ�С������һ��������)
SELECT
    product_id,
    product_name,
    list_price
FROM products
WHERE list_price BETWEEN 3000 AND 3200;
-- or ���� �۸�Ҫ
SELECT
    product_id,
    product_name,
    list_price
FROM products
WHERE list_price < 5499.99
   OR products.list_price > 8867.99;
--ģ����ѯ like
SELECT
    customer_id,
    name,
    address
FROM customers
WHERE name LIKE 'Amer%';
--In ��ѯ����ѯ��ID����270��200����Ϣ��
SELECT
    customer_id,
    name,
    address,
    website
FROM customers
WHERE customer_id IN (170, 200);
-- not in ����ѯ���� 2��4������
SELECT
    customer_id,
    name,
    address,
    website
FROM customers
WHERE customer_id NOT IN (2, 4);
-- is ��ѯoriginֵΪ�յ�����
SELECT *
FROM productinfo
WHERE origin IS NULL;
-- is ��ѯoriginֵ��Ϊ�յ�����
SELECT *
FROM productinfo
WHERE origin IS NOT NULL;

-- ���麯�� group by ���������where���󣬼����������䶼�Ǿ���where���ɸѡ����
-- ����ѯ�д���GROUP BY�Ӿ�ʱ��SELECT�б���ֻ�ܴ��ڷ��麯�����������GROUP BY�Ӿ��е��ֶΡ�
SELECT
    product_name,
    AVG(list_price)
FROM products
GROUP BY product_name;
-- ����ֶη���
SELECT
    category          ��Ʒ���ͱ���,
    AVG(productprice) ƽ���۸�,
    origin            ����
FROM productinfo
GROUP BY category,
         origin;

SELECT *
FROM productinfo;
-- ��������
UPDATE productinfo
SET productprice = 6000
WHERE origin = 44;

-- where �� group by ���ʹ��
SELECT
    category          ��Ʒ���ͱ���,
    AVG(productprice) ƽ���۸�,
    origin            ����
FROM productinfo
WHERE productprice > 6000
GROUP BY category,
         origin;

-- HAVING��GROUP BYһ��ʹ�ã�������������������WHERE�Ӿ䲻һ����HAVING�Ӿ������йأ������뵥����ֵ�йء���GROUP BY�Ӿ��У�������GROUP BY�������顣
-- ���˷���������
-- where ������ from
-- having ������ group by
SELECT
    category,
    AVG(productprice)
FROM productinfo
GROUP BY category
HAVING AVG(productprice) > 6000;

-- �Ӳ�ѯ��Ƕ�ײ�ѯ�������� select update delete�У�������where���һ�����ʽ
-- ��һ������ѯ����ѯ��Ʒ����Ϊ MP3 �����ݣ�
SELECT
    productname,
    productprice
FROM productinfo
WHERE category = (SELECT
                      categoryid
                  FROM categoryinfo
                  WHERE categoryname = 'MP3');

-- ��������ѯ����ѯ������Сֵ��С�����ֵ�����ݣ�
SELECT
    productname,
    productprice
FROM productinfo
WHERE productprice > (SELECT
                          MIN(productprice)
                      FROM productinfo)
  AND productprice < (SELECT
                          MAX(productprice)
                      FROM productinfo)

-- �Ӳ�ѯ���ض���(in)
-- ��ѯ categoryid ���� ���Ӻ�MP3������
SELECT
    productname,
    productprice
FROM productinfo
WHERE category IN
      (SELECT
           categoryid
       FROM categoryinfo
       WHERE categoryname = '����'
          OR categoryname = 'MP3');

-- ANY����ʾ�����Ӳ�ѯ������κ�һ�����ͣ�����=���䣬��ʾС�ڵ����б��е����ֵ�����ͣ�����=���ʱ��ʾ���ڵ����б��е���Сֵ��
-- �Ӳ�Ʒ��PRODUCTINFO�в�ѯ���۸����ָ���۸��б��е����ֵ��ָ���ļ۸��б����ָ��Ʒ���ͱ���Ϊ��0100030002�������в�Ʒ�۸�
SELECT
    productname,
    productprice
FROM productinfo
WHERE productprice < ANY
      (SELECT
           productprice
       FROM productinfo
       WHERE category = '0100030002')
  AND category <> '0100030002';

-- some ��ͬ�� any
-- SOME���÷���ANYһ����ֻ����ANY�����ڷǡ�=���Ļ����С�SOME�����ʾ�ҳ����Ӳ�ѯ���κμ۸���ȵĲ�Ʒ��
SELECT
    productname,
    productprice
FROM productinfo
WHERE productprice =
    SOME (SELECT
              productprice
          FROM productinfo
          WHERE category = '0100030002')
  AND category <> '0100030002';

-- ALL����ʾ�����Ӳ�ѯ��������н�����ͣ�����=���䣬��ʾС�ڵ����б��е���Сֵ�����ͣ�����=���ʱ��ʾ���ڵ����б��е����ֵ��
-- �ҳ���ָ���۸��б��͵Ĳ�Ʒ����
SELECT
    productname,
    productprice
FROM productinfo
WHERE productprice <
          ALL (SELECT
                   productprice
               FROM productinfo
               WHERE category = '0100030002');