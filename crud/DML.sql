-- ����� insert; �޸��� update; ɾ���� delete; ������ select;
-- ��������
SELECT *
FROM manageinfo;
INSERT INTO manageinfo
(manageid,
 loginname,
 password,
 name,
 tel)
VALUES ('1',
        'xiaowang',
        '123456',
        'liming',
        '12345678');

SELECT *
FROM logininfo;
CREATE TABLE logininfo
(
    loginname     VARCHAR2(10), -- ����Աע����
    loginpassword VARCHAR2(10)  -- ����Ա����
);
-- ͨ��������������������(ȷ�����ű��еĸ������ֶ���������һ���ſ���ʹ�ã�
INSERT INTO logininfo
(loginname,
 loginpassword)
SELECT
    loginname,
    password
FROM manageinfo;
-- Ŀ���������ݶ�����뵽�±���

-- ֱ�Ӵ��������ݵı�
SELECT *
FROM login;
CREATE TABLE login AS
SELECT
    loginname,
    password
FROM manageinfo;
INSERT INTO login
(loginname,
 password)
VALUES ('wang',
        '123');
INSERT INTO login
(loginname,
 password)
VALUES ('zhang',
        '123');

-- �޸�����
UPDATE login
SET loginname = 'test'; -- ����where�������޸�loginname�ֶ��µ���������
UPDATE login
SET loginname = 'zhang'
WHERE password = '123456';
-- �޸������޸�ָ��������

-- ɾ������
DELETE
FROM login; -- ɾ���������е�����
DELETE
FROM login
WHERE loginname = 'wang';
--ɾ��ָ��������
-- truncate ɾ�����ݣ���deleteһ����ɾ����������ݣ������ٶ��������
TRUNCATE TABLE login;

--


