-- sysdate 函数，常用，将得到的时间格式化显示
SELECT
    TO_CHAR(SYSDATE, 'yyyy-mm-dd hh:mm:ss')
FROM REGIONS;
-- systimestamp 返回系统时间，该时间包含时区信息，精确到微秒。返回类型为带时区信息的TIMESTAMP类型
SELECT
    SYSTIMESTAMP
FROM REGIONS; --可以用于返回远端数据库服务器的时间
