-- length(char) 获取字符长度
SELECT
    LENGTH(REGION_NAME)
FROM REGIONS;
SELECT *
FROM REGIONS;
-- substr(char,position,length) 截取字符串函数；char:原始字符串；position，截取的开始位置，默认为1，如果该值为负数，则从char的右边开始算起，例如-2，就从倒数第二位开始往右算起；length 表示长度
SELECT
    SUBSTR(REGION_NAME, -2, 5)
FROM REGIONS;

-- concat(char1,char2) 连接字符，类似于 ||；但是concat只能连接两个，||可以连接多个
SELECT
    CONCAT('我的', '天下'),
    '我的' || '天下！'
FROM REGIONS;

-- upper(char) 转换为大写字母
SELECT
    UPPER('a'),
    UPPER('this is world')
FROM REGIONS;
-- lower(char) 转换为小写字母
SELECT
    LOWER('A'),
    LOWER('THIS IS MY WORLD')
FROM REGIONS;
-- initcap(char) 首字母转为大写
SELECT
    INITCAP('this is cat')
FROM REGIONS;
-- nls_initcap 将指定参数的第一个字母转为大写
SELECT
    NLS_INITCAP('this is my morld,can you help me')
FROM REGIONS;
-- replace(char,search_string.replacement_string) 替换字符串；char为目标字母串，search_string 为目标字母串里要搜索的字符串；
-- replacement_string 乐轩，用它替代搜索出的字符串，不使用，则表示删除search_string搜索出的字符串
SELECT
    REPLACE(REGION_NAME, 'and', 'or')
FROM REGIONS;