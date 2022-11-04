-- demo 01
begin
    -- 执行体开始
    DBMS_OUTPUT.PUT_LINE('这是执行体部分......'); -- 输出这句话到屏幕
end;
-- 执行体结束

-- demo 02
declare -- 声明变量的关键字
    result number(8, 2); -- 声明一个变量 result ,数据类型是 number
begin
    -- 执行体开始
    result := 100 / 6; -- 给变量赋值
    DBMS_OUTPUT.PUT_LINE('最后的结果是：' || result); -- 输出结果
end;
-- 结束

-- demo 03
declare
    v_product_id varchar2(12);
begin
    select PRODUCT_ID
    into v_product_id -- select 。。。 into ... PL/SQL 特有的赋值语句（select 后的列名顺序要和 into 后的列名顺序一一对应）
    from products
    where PRODUCTS.PRODUCT_NAME = 'Intel Xeon E5-2697 V3'; -- 将数据存入到 v_product中
    DBMS_OUTPUT.PUT_LINE('产品对应的编码是' || v_product_id);
exception
    -- 该类型语句只能返回一条数据，超过一条则会触发异常
    when no_data_found then
        DBMS_OUTPUT.put_line('没有对应的编码'); -- 找不到数据触发此信息
    when too_many_rows then
        DBMS_OUTPUT.put_line('对应数据过多，请确认'); -- 返回记录过多触发此信息
end ;
------------------------------------------------------------------------------------------------------------------------
declare
    v_productid            productinfo.productid%type;--产品ID
    v_productname          varchar2(20);--产品名称
    v_productprice         number(8, 2);--产品价格
    v_quantity             number(10);--数量
    v_desperation constant v_productname%type := '测试';--测试
    v_spitgr               simple_integer     := 99.9;
    v_long                 long               := 'LONG类型测试';
    v_date                 date               := sysdate;
begin
    select productid,
           productname,
           productprice,
           quantity
    into v_productid,v_productname,v_productprice,v_quantity
    from productinfo
    where productid = '0240040001';
    DBMS_OUTPUT.PUT_LINE('v_productid=' || v_productid);
    DBMS_OUTPUT.PUT_LINE('v_productname=' || v_productname
        || '长度=' || length(v_productname));
    DBMS_OUTPUT.PUT_LINE('v_productprice=' || v_productprice);
    DBMS_OUTPUT.PUT_LINE('v_quantity=' || v_quantity);
    DBMS_OUTPUT.PUT_LINE('v_desperation=' || v_desperation);
    DBMS_OUTPUT.PUT_LINE('v_spitgr=' || v_spitgr);
    DBMS_OUTPUT.PUT_LINE('v_long=' || v_long);
    DBMS_OUTPUT.PUT_LINE('v_date=' || v_date);
end;

select product_id,
       product_name,
       list_price
from products
where list_price < 5499.99
union
select product_id,
       product_name,
       list_price
from products
where products.list_price > 8867.99;

declare
    type product_rec is record -- 声明类型变量 product_rec
    -- 声明类型下的三个成员
                        (
                            v_product_id    products.product_id%type, -- 产品ID -- 引用已有的变量
                            v_product_name  varchar2(255),            -- 产品名称 -- 定义变量
                            v_product_price number(8, 2)              -- 价格 -- 定义变量
                        ); -- 声明行记录类型
    v_product product_rec; -- 声明变量 v_product，类型是 product_rec
begin
    select PRODUCT_ID, PRODUCT_NAME, LIST_PRICE into v_product from PRODUCTS where PRODUCT_ID = '228';
    --这里INTO后面直接是v_product记录类型，这样赋值会依据声明记录类型时里面成员的顺序依次赋值。这种赋值方式比较方便。
    DBMS_OUTPUT.PUT_LINE('product_id=' || v_product.v_product_id); -- 输出
    DBMS_OUTPUT.PUT_LINE('product_name=' || v_product.v_product_name); -- 输出
    DBMS_OUTPUT.PUT_LINE('product_price=' || v_product.v_product_price); -- 输出
end;
/

declare
    v_product products%rowtype; -- 声明变量 v_product，数据类型是表 products 的行记录类型
begin
    select * into v_product from PRODUCTS where PRODUCT_ID = '228'; -- 查询了一条记录存到 v_product
    DBMS_OUTPUT.PUT_LINE('product_id=' || v_product.product_id); -- 输出
    DBMS_OUTPUT.PUT_LINE('product_name=' || v_product.product_name); -- 输出
    DBMS_OUTPUT.PUT_LINE('product_price=' || v_product.list_price); -- 输出
end;

-- 索引表类型本身的定义语法，并没有包含变量的定义
declare
    type ty_name is table of -- 定义类型名称
        {
        column_type| -- 索引表中的数据类型（标量数据类型）
        variable_name%type | -- 引用类型
    table_name.column_name%type | -- 引用类型
    table_name%rowtype -- 引用表的类型
    }
    [not null]
    index by {pls_integer | binary_integer | varchar2 (v_sieze)};
-- 如果想把某个变量声明成索引表类型，就按照这个语法
    variable_name type_name; -- variable_name 变量名称 type_name 索引表的名称

-- 使用数字作为键值
    declare
    type product_a is table of products%rowtype -- 声明第一个索引表，引用 products 表的行记录
        index by binary_integer; -- 索引类型，可以认为是键值
    type product_b is table of varchar2(8) -- 声明第二个索引表，数据类型是 varchar2
        index by pls_integer;-- 索引类型，可以认为是键值
    v_prt_row     product_a; -- 定义变量，类型是 product_a
    v_prt         product_b; -- 定义变量，类型是 product_b
begin
    v_prt(1) := '正数'; --为变量赋值；赋值的方式同数组类似，以“变量名（索引）”的形式赋值，当取值时也需要同样的规则。
    v_prt(-1) := '负数';
    select * into v_prt_row(1) from PRODUCTS where PRODUCT_ID = '228'; -- 给变量数值
    DBMS_OUTPUT.PUT_LINE('行数据-v_prt_row(1)=' || v_prt_row(1).PRODUCT_ID || '---' || v_prt_row(1).PRODUCT_NAME); -- 输出
    DBMS_OUTPUT.PUT_LINE('v_prt(1)=' || v_prt(1)); -- 输出
    DBMS_OUTPUT.PUT_LINE('v_prt(-1)=' || v_prt(-1)); -- 输出
end;

-- 使用字符串作为键值
declare
    type pro_a is table of number(8) -- 声明索引表，数据类型 number
        index by varchar2(20); -- 索引类型
    v_pro_char pro_a; -- 定义变量，类型是 pro_a
begin
    v_pro_char('test') := 123; -- 给变量赋值
    v_pro_char('test1') := 0; -- 给变量赋值
    DBMS_OUTPUT.PUT_LINE('v_pro_char(123)=' || v_pro_char('test')); -- 输出变量的值
    DBMS_OUTPUT.PUT_LINE('v_pro_char(000)=' || v_pro_char('test1'));-- 输出变量的值
    DBMS_OUTPUT.PUT_LINE('v_pro_char(000)=' || v_pro_char.FIRST);
    DBMS_OUTPUT.PUT_LINE('v_pro_char(000)=' || v_pro_char(v_pro_char.FIRST));
end;

declare
    type varr is varray(100) of varchar2(20); -- 定义数组 varr，长度100；varchar2 类型，长度20
    v_product varr := varr('1', '2'); -- 声明变量，类型是varr,初始化了两个元素
begin
    v_product(1) := 'this is a'; -- 给第一个数组元素赋值
    v_product(2) := 'this is b'; -- 给第二个数组元素赋值
    DBMS_OUTPUT.PUT_LINE('v_product(1)=' || v_product(1)); -- 输出
    DBMS_OUTPUT.PUT_LINE('v_product(2)=' || v_product(2)); -- 输出
end;

declare
    v_result number(10, 4); -- 定义变量的数据类型，长度十位，保留4位小数
begin
    v_result := sqrt(58 + 25 * 3 + (19 - 9) ** 2); -- 给变量赋值
    if v_result > 20 then
        DBMS_OUTPUT.PUT_LINE('平方根=' || v_result); -- 输出
        DBMS_OUTPUT.PUT_LINE('结果为true，输出结果');
    end if;
    DBMS_OUTPUT.PUT_LINE('结果为fase，不满足条件');
end;

declare
    n_result number(10);
begin
    n_result := 30;
    if n_result >= 30 then
        DBMS_OUTPUT.PUT_LINE('结果大于30');
    else
        DBMS_OUTPUT.PUT_LINE('结果小于30');
    end if;
end;

declare
    n_student number(10);
begin
    n_student := DBMS_RANDOM.VALUE(100, 300);
    if n_student >= 100 and n_student <= 200 then
        DBMS_OUTPUT.PUT_LINE('数值范围在100~200之间');
    elsif n_student >= 200 and n_student <= 250 then
        DBMS_OUTPUT.PUT_LINE('数值范围在200~250之间');
    elsif n_student >= 250 and n_student <= 300 then
        DBMS_OUTPUT.PUT_LINE('数值范围在250~300之间');
        DBMS_OUTPUT.PUT_LINE('数值是' || n_student);
    else
        DBMS_OUTPUT.PUT_LINE('所有条件都不符合');
    end if;
end ;
select product_name, standard_cost, list_price
from PRODUCTS;

declare
    v_product products%rowtype;
begin
    select * into v_product from PRODUCTS where PRODUCT_ID = 228;
    if v_product.LIST_PRICE >= 2000 then
        DBMS_OUTPUT.PUT_LINE('该产品价格偏高');
        if v_product.STANDARD_COST >= 2000 then
            DBMS_OUTPUT.PUT_LINE('大于2000，不缺货');
        else
            DBMS_OUTPUT.PUT_LINE('小于2000，缺货');
        end if;
    elsif v_product.LIST_PRICE >= 1000 and v_product.LIST_PRICE <= 1500 then
        DBMS_OUTPUT.PUT_LINE('中等价格');
        if v_product.STANDARD_COST >= 2000 then
            DBMS_OUTPUT.PUT_LINE('大于2000，不缺货');
        else
            DBMS_OUTPUT.PUT_LINE('小于2000，缺货');
        end if;
    else
        DBMS_OUTPUT.PUT_LINE('该产品价格偏低');
        if v_product.STANDARD_COST >= 500 then
            DBMS_OUTPUT.PUT_LINE('不缺货');
        else
            DBMS_OUTPUT.PUT_LINE('缺货');
        end if;
    end if;
end;

declare
    v_categoryid varchar2(12);
begin
    select CATEGORY_ID into v_categoryid from PRODUCTS where PRODUCT_ID = 228;
    case v_categoryid
        when '2' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '对应fake');
        when '3' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '对应aa');
        when '4' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '对应bb');
        when '1' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '对应ironman');
        else DBMS_OUTPUT.PUT_LINE('没有找到对应的类型');
        end case;
end;
select *
from PRODUCTS;

declare
    v_productinfo number(10, 2);
begin
    select LIST_PRICE into v_productinfo from PRODUCTS where PRODUCT_ID = 98;
    case
        when v_productinfo > 3000 then DBMS_OUTPUT.PUT_LINE('高价产品，价格是：' || v_productinfo);
        when v_productinfo >= 2000 and v_productinfo <= 3000
            then DBMS_OUTPUT.PUT_LINE('中价产品，价格是：' || v_productinfo);
        when v_productinfo <= 1000 then DBMS_OUTPUT.PUT_LINE('低价产品，价格是：' || v_productinfo);
        else DBMS_OUTPUT.PUT_LINE('都不符合，价格是：' || v_productinfo);
        end case;
end;

declare
    n_num number(8) := 1;
begin
    <<basicloop>>
    loop
        DBMS_OUTPUT.PUT_LINE('当前变量的值是：' || n_num);
        n_num := n_num + 1;
        if n_num > 5 then
            DBMS_OUTPUT.PUT_LINE('结束，当前变量的值是：' || n_num);
            exit basicloop;
        end if;
    end loop;
    DBMS_OUTPUT.PUT_LINE('循环结束');
end ;

declare
    n_num number(8) := 1;
begin
    <<basicloop>>
    loop
        DBMS_OUTPUT.PUT_LINE('当前变量的值是：' || n_num);
        n_num := n_num + 1;
        exit basicloop when n_num > 5;
    end loop;
    DBMS_OUTPUT.PUT_LINE('循环结束');
end ;

declare
    n_num number(8) := 1;
begin
    DBMS_OUTPUT.PUT_LINE('当前变量的值是：' || n_num);
    <<while_loop>>
    while n_num < 20
        loop
            if mod(n_num, 3) = 0 then
                DBMS_OUTPUT.PUT_LINE('能被3整除的数有：' || n_num);
            end if;
            n_num := n_num + 1;
        end loop;
    DBMS_OUTPUT.PUT_LINE('退出，当前变量的值是：' || n_num);
    DBMS_OUTPUT.PUT_LINE('结束循环');
end ;

declare
    n_num number(8) := 1;
    v_num boolean   := true;
begin
    while v_num
        loop
            if mod(n_num, 3) = 0 then
                DBMS_OUTPUT.PUT_LINE('能被三整除的数字有：' || n_num);
            end if;
            if n_num >= 20 then
                v_num := false;
            end if;
            n_num := n_num + 1;
        end loop;
end;

declare
    num number(8) := 0;
begin
    <<for_loop>>
    for inx in 1..20
        loop
            num := num + inx;
        end loop for_loop;
    DBMS_OUTPUT.PUT_LINE('1到100之间整数和是：' || num);
    DBMS_OUTPUT.PUT_LINE('loop 循环结束');
end;

select *
from PRODUCTS;

declare
    vc_id varchar2(10) := 0;
    b_bol boolean      := true;
begin
    select CATEGORY_ID into vc_id from PRODUCTS where PRODUCT_NAME = 'Intel Xeon E5-2699 V3 (OEM/Tray)';
    DBMS_OUTPUT.PUT_LINE('电脑对应的编码ID是：' || vc_id);
exception
    when no_data_found then
        if b_bol then
            DBMS_OUTPUT.PUT_LINE('没有对应的编码，为其增加电脑类型');
            insert into PRODUCTS (PRODUCT_ID, PRODUCT_NAME) values ('001234', 'MacPro');
            commit;
        end if;
    when too_many_rows then
        DBMS_OUTPUT.PUT_LINE('对应数据过多，请确定');
end;

DECLARE
    v_catgid VARCHAR2(10) := 0;
    v_bol    BOOLEAN      := TRUE;
BEGIN
    SELECT CATEGORYID
    INTO v_catgid
    FROM CATEGORYINFO
    WHERE CATEGORYNAME = '电脑';
    DBMS_OUTPUT.PUT_LINE('电脑对应的编码存在：' || v_catgid);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        IF v_bol THEN
            DBMS_OUTPUT.PUT_LINE('没有对应的编码，为其增加该产品类型');
            INSERT INTO CATEGORYINFO VALUES ('0100000001', '电脑');
            COMMIT;
        END IF;
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('对应数据过多，请确认！');
END;

declare
    table_name varchar2(200);
begin
    table_name := 'create table test_DDL(
        id varchar2(10),
        name varchar2(10)
        )';
    execute immediate table_name;
end;

