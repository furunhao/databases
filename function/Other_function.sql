-- descode 该函数的具体语法是DECODE(expr,search,result[,search1,result1][,default])。该函数的执行过程是，当expr符合条件search时就返回result的值，该过程可以重复多个，如果最后没有匹配的结果，可以返回默认值default，注意它是一对一的匹配过程。
SELECT
    CATEGORY_ID,
    PRODUCT_NAME,
    LIST_PRICE,
    DECODE(SIGN(LIST_PRICE - 3000), 1, '充足', -1, '不足', 0, '不足')
FROM PRODUCTS;