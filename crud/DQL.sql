-- 避免使用 * 号查询表内所有数据，明确需要查询的字段；
-- * 号查询在效率上明显不如指定字段去查询；如果表内新增字段，使用 * 号查询可能引起程序的异常
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
        '夏普',
        '7000',
        '20',
        '010030001',
        '4444',
        '');
-- 使用别名 as 查询
SELECT
    productid   AS a,
    productname AS b,
    productprice   c
FROM productinfo;
SELECT *
FROM productinfo;
-- 查询中使用表达式（注意，这里的查询操作并不会改变数据库里的值） || ： 连接符号，像 Java 中连接字符串的 + 号
SELECT
    productid,
    productname,
    productprice || ' * ' || 1.25 || ' = ' || productprice * 1.25 AS newprice
FROM productinfo;
-- substr 函数；截取部门内容
SELECT
    SUBSTR(productid, 0, 4) 截取前4位编号
FROM productinfo;
-- 表示从0开始，总共展示四个字符；0代表的就是第一个字符
-- 过滤重复数据
SELECT DISTINCT
    productid AS 过滤重复id,
    productid,
    productname,
    productprice
FROM productinfo;

-- 查询指定字段的数据
SELECT
    first_name,
    last_name
FROM contacts;

-- 可以指定某个模式下的表或视图的列;   模式.表名.字段；这样可以查询其他模式下的表
SELECT
    code.contacts.contact_id,
    contacts.first_name,
    contacts.last_name
FROM code.contacts;

-- 排序 order by(默认以 ASC 升序展示，加上 DeSC 降序显示
SELECT
    product_id,
    product_name,
    standard_cost,
    list_price
FROM products
ORDER BY list_price DESC;
-- 优先把空值展示在顶部
SELECT *
FROM productinfo
ORDER BY origin NULLS FIRST;
-- 优先把空值展示在底部
SELECT *
FROM productinfo
ORDER BY origin NULLS LAST;
-- 使用查询列表中字段的位置（数字代表字段在表里的位置）来作为排序字段，这么做一是为了方便，二是为了防止使用UNION时出现错误。
SELECT *
FROM productinfo
ORDER BY 7 DESC;
-- 多字段排序：当第一个字段数据相同时，才会对第二个字段排序
SELECT *
FROM productinfo
ORDER BY 1 DESC,
         2 DESC,
         3 DESC,
         4 DESC,
         5 DESC,
         6 DESC,
         origin NULLS LAST;
-- where 语句（单个条件）
SELECT
    product_id,
    product_name,
    list_price
FROM products
WHERE list_price > 3000
ORDER BY list_price DESC;
-- <>  要求 list_price 字段下不等于 8867.99 的数据 ; 等同于 != (不等于）
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
-- 使用 substr 函数列出前几位等于 intel 的数据
SELECT
    product_id,
    product_name,
    list_price
FROM products
WHERE SUBSTR(product_name, 0, 3) = 'AMD';
-- where 多个条件限制
SELECT
    product_id,
    product_name,
    list_price
FROM products
WHERE list_price <= 3500
  AND list_price >= 3000;
-- 针对上面语句的简单写法(between 左边的值要比右边的小，这是一个闭区间)
SELECT
    product_id,
    product_name,
    list_price
FROM products
WHERE list_price BETWEEN 3000 AND 3200;
-- or 代表 价格要
SELECT
    product_id,
    product_name,
    list_price
FROM products
WHERE list_price < 5499.99
   OR products.list_price > 8867.99;
--模糊查询 like
SELECT
    customer_id,
    name,
    address
FROM customers
WHERE name LIKE 'Amer%';
--In 查询（查询出ID等于270和200的信息）
SELECT
    customer_id,
    name,
    address,
    website
FROM customers
WHERE customer_id IN (170, 200);
-- not in 不查询等于 2和4的数据
SELECT
    customer_id,
    name,
    address,
    website
FROM customers
WHERE customer_id NOT IN (2, 4);
-- is 查询origin值为空的数据
SELECT *
FROM productinfo
WHERE origin IS NULL;
-- is 查询origin值不为空的数据
SELECT *
FROM productinfo
WHERE origin IS NOT NULL;

-- 分组函数 group by 允许出现在where语句后，即被分组的语句都是经过where语句筛选过的
-- 当查询中存在GROUP BY子句时，SELECT列表中只能存在分组函数，或出现在GROUP BY子句中的字段。
SELECT
    product_name,
    AVG(list_price)
FROM products
GROUP BY product_name;
-- 多个字段分组
SELECT
    category          产品类型编码,
    AVG(productprice) 平均价格,
    origin            产地
FROM productinfo
GROUP BY category,
         origin;

SELECT *
FROM productinfo;
-- 更新数据
UPDATE productinfo
SET productprice = 6000
WHERE origin = 44;

-- where 和 group by 混合使用
SELECT
    category          产品类型编码,
    AVG(productprice) 平均价格,
    origin            产地
FROM productinfo
WHERE productprice > 6000
GROUP BY category,
         origin;

-- HAVING和GROUP BY一起使用，限制搜索条件。它和WHERE子句不一样，HAVING子句与组有关，而不与单个的值有关。在GROUP BY子句中，作用于GROUP BY创建的组。
-- 过滤分组后的数据
-- where 服务于 from
-- having 服务于 group by
SELECT
    category,
    AVG(productprice)
FROM productinfo
GROUP BY category
HAVING AVG(productprice) > 6000;

-- 子查询（嵌套查询）出现在 select update delete中；本质是where后的一个表达式
-- 单一条件查询（查询产品类型为 MP3 的数据）
SELECT
    productname,
    productprice
FROM productinfo
WHERE category = (SELECT
                      categoryid
                  FROM categoryinfo
                  WHERE categoryname = 'MP3');

-- 多条件查询（查询大于最小值和小于最大值的数据）
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

-- 子查询返回多行(in)
-- 查询 categoryid 等于 电视和MP3的数据
SELECT
    productname,
    productprice
FROM productinfo
WHERE category IN
      (SELECT
           categoryid
       FROM categoryinfo
       WHERE categoryname = '电视'
          OR categoryname = 'MP3');

-- ANY：表示满足子查询结果的任何一个。和＜、＜=搭配，表示小于等于列表中的最大值；而和＞、＞=配合时表示大于等于列表中的最小值。
-- 从产品表PRODUCTINFO中查询出价格低于指定价格列表中的最大值。指定的价格列表就是指产品类型编码为“0100030002”的所有产品价格
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

-- some 等同于 any
-- SOME的用法和ANY一样，只不过ANY多用在非“=”的环境中。SOME这里表示找出和子查询中任何价格相等的产品。
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

-- ALL：表示满足子查询结果的所有结果。和＜、＜=搭配，表示小于等于列表中的最小值；而和＞、＞=配合时表示大于等于列表中的最大值。
-- 找出比指定价格列表还低的产品数据
SELECT
    productname,
    productprice
FROM productinfo
WHERE productprice <
          ALL (SELECT
                   productprice
               FROM productinfo
               WHERE category = '0100030002');