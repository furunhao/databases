-- ABS(n)函数。用于返回绝对值。该函数输入一个参数，参数类型为数值型，假如参数为可以隐式转换成数值类型，那么也可以
SELECT
    ABS(100),
    ABS(-100),
    ABS('-100')
FROM REGIONS;

-- MOD(n2,n1)函数。该函数表示返回n2除以n1的余数。参数为任意数值或可以隐式转成数值的类型。如果n1为0，那么该函数将返回n2。
SELECT
    MOD(5, 2),
    MOD(8 / 3, 5),
    MOD('10', 5),
    MOD(-10, 6),
    MOD(1, 0)
FROM REGIONS;

-- SIGN(n)函数。返回参数n的符号。正数返回1，0返回0，负数返回-1。但如果n为BINARY_FLOAT或BINARY_DOUBLE类型时，n＞=0或者n=NaN函数会返回1。
SELECT
    SIGN('9'),
    SIGN(-9),
    SIGN(0.00),
    SIGN(-2 * '9')
FROM REGIONS;

-- 指数/对数 函数
-- SQRT(n)函数。该函数返回n的平方根。n为数字类型的时候不能为负数，将返回一个实数，当n为BINARY_FLOAT或BINARY_DOUBLE类型时，n＜0将返回Nan
SELECT
    SQRT(100),
    SQRT('53.9')
FROM REGIONS;

-- POWER(n2,n1)函数。利用该函数可以得到n2的n1次幂的结果。这两个参数为任意数值，但如果n2为负数，那么n1必须为整数。
SELECT
    POWER(5, 2),
    POWER('5', 2),
    POWER(5.5, 2.5),
    POWER(-5, 2),
    5 * 5
FROM REGIONS;

-- LOG(n1,n2)函数。该函数可以返回以n1为底n2的对数，n1是除1和0以外的任意正数。n2为正数。
SELECT
    LOG(10, 100),
    LOG(10.5, '100'),
    POWER(10, 2)
FROM REGIONS;

-- 四舍五入截取函数
-- ROUND（for number）函数。该函数的具体原型是ROUND(n,integer)。它将数值n四舍五入成第二个参数指定的形式的十进制数。参数integer要求是整数，如果不是整数，那么它将被自动截取为整数部分。
-- 当integer为正整数时，表示n被四舍五入为integer位小数。如果该参数为负数，则n被四舍五入至小数点向左integer位。
SELECT
    ROUND(100.2345, 3),
    ROUND(99.1234213, 3.9),
    ROUND(88.234234, -2),
    ROUND(88.234234)
FROM REGIONS;

-- TRUNC（for number）函数。该函数的具体原型是TRUNC(n,integer)。它把数值n根据integer的值进行截取，截取时和integer的正负有关。参数integer要求是整数，如果不是整数，那么它将被自动截取为整数部分。
-- 当integer为正整数时，表示n将截取到integer位小数；如果integer为负数，则截取到小数点左第integer位，被截取部分用0代替。
SELECT
    TRUNC(100.3123123, 4),
    TRUNC(99.132213, 2.99),
    TRUNC(88.3123123, -2),
    TRUNC(123123.123123)
FROM REGIONS;

