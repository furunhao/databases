-- descode �ú����ľ����﷨��DECODE(expr,search,result[,search1,result1][,default])���ú�����ִ�й����ǣ���expr��������searchʱ�ͷ���result��ֵ���ù��̿����ظ������������û��ƥ��Ľ�������Է���Ĭ��ֵdefault��ע������һ��һ��ƥ����̡�
SELECT
    CATEGORY_ID,
    PRODUCT_NAME,
    LIST_PRICE,
    DECODE(SIGN(LIST_PRICE - 3000), 1, '����', -1, '����', 0, '����')
FROM PRODUCTS;