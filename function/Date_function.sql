-- sysdate ���������ã����õ���ʱ���ʽ����ʾ
SELECT
    TO_CHAR(SYSDATE, 'yyyy-mm-dd hh:mm:ss')
FROM REGIONS;
-- systimestamp ����ϵͳʱ�䣬��ʱ�����ʱ����Ϣ����ȷ��΢�롣��������Ϊ��ʱ����Ϣ��TIMESTAMP����
SELECT
    SYSTIMESTAMP
FROM REGIONS; --�������ڷ���Զ�����ݿ��������ʱ��
