-- length(char) ��ȡ�ַ�����
SELECT
    LENGTH(REGION_NAME)
FROM REGIONS;
SELECT *
FROM REGIONS;
-- substr(char,position,length) ��ȡ�ַ���������char:ԭʼ�ַ�����position����ȡ�Ŀ�ʼλ�ã�Ĭ��Ϊ1�������ֵΪ���������char���ұ߿�ʼ��������-2���ʹӵ����ڶ�λ��ʼ��������length ��ʾ����
SELECT
    SUBSTR(REGION_NAME, -2, 5)
FROM REGIONS;

-- concat(char1,char2) �����ַ��������� ||������concatֻ������������||�������Ӷ��
SELECT
    CONCAT('�ҵ�', '����'),
    '�ҵ�' || '���£�'
FROM REGIONS;

-- upper(char) ת��Ϊ��д��ĸ
SELECT
    UPPER('a'),
    UPPER('this is world')
FROM REGIONS;
-- lower(char) ת��ΪСд��ĸ
SELECT
    LOWER('A'),
    LOWER('THIS IS MY WORLD')
FROM REGIONS;
-- initcap(char) ����ĸתΪ��д
SELECT
    INITCAP('this is cat')
FROM REGIONS;
-- nls_initcap ��ָ�������ĵ�һ����ĸתΪ��д
SELECT
    NLS_INITCAP('this is my morld,can you help me')
FROM REGIONS;
-- replace(char,search_string.replacement_string) �滻�ַ�����charΪĿ����ĸ����search_string ΪĿ����ĸ����Ҫ�������ַ�����
-- replacement_string ����������������������ַ�������ʹ�ã����ʾɾ��search_string���������ַ���
SELECT
    REPLACE(REGION_NAME, 'and', 'or')
FROM REGIONS;