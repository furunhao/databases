CREATE TABLE productinfo
(
    productid    VARCHAR2(10),   --��Ʒ���
    productname  VARCHAR2(20),   --��Ʒ����
    productprice NUMBER(8, 2),   --��Ʒ�۸�
    quantity     NUMBER(10),     --��Ʒ����
    category     VARCHAR2(10),   --��Ʒ����
    desperation  VARCHAR2(1000), --��Ʒ����
    origin       VARCHAR2(10)--����
);

SELECT *
FROM productinfo;

ALTER TABLE productinfo
    ADD test VARCHAR2(20); -- ����е�����


ALTER TABLE productinfo
    MODIFY test NUMBER; --�޸��ֶ�����

ALTER TABLE productinfo
    DROP COLUMN test; -- ɾ���ֶ�

ALTER TABLE productinfo
    ADD test NUMBER
    MODIFY origin NUMBER; -- �޸Ķ���ֶ�

ALTER TABLE productinfo
    DROP (test, origin);-- ɾ������ֶ�

ALTER TABLE productinfo
    ADD (test NUMBER,test1 NUMBER); --��Ӷ���ֶ�

ALTER TABLE productinfo
    MODIFY (test VARCHAR2(10),test1 VARCHAR2(1)); -- �޸Ķ���ֶ�

DROP TABLE productinfo;
-- ɾ����

