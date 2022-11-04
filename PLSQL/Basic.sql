-- demo 01
begin
    -- ִ���忪ʼ
    DBMS_OUTPUT.PUT_LINE('����ִ���岿��......'); -- �����仰����Ļ
end;
-- ִ�������

-- demo 02
declare -- ���������Ĺؼ���
    result number(8, 2); -- ����һ������ result ,���������� number
begin
    -- ִ���忪ʼ
    result := 100 / 6; -- ��������ֵ
    DBMS_OUTPUT.PUT_LINE('���Ľ���ǣ�' || result); -- ������
end;
-- ����

-- demo 03
declare
    v_product_id varchar2(12);
begin
    select PRODUCT_ID
    into v_product_id -- select ������ into ... PL/SQL ���еĸ�ֵ��䣨select �������˳��Ҫ�� into �������˳��һһ��Ӧ��
    from products
    where PRODUCTS.PRODUCT_NAME = 'Intel Xeon E5-2697 V3'; -- �����ݴ��뵽 v_product��
    DBMS_OUTPUT.PUT_LINE('��Ʒ��Ӧ�ı�����' || v_product_id);
exception
    -- ���������ֻ�ܷ���һ�����ݣ�����һ����ᴥ���쳣
    when no_data_found then
        DBMS_OUTPUT.put_line('û�ж�Ӧ�ı���'); -- �Ҳ������ݴ�������Ϣ
    when too_many_rows then
        DBMS_OUTPUT.put_line('��Ӧ���ݹ��࣬��ȷ��'); -- ���ؼ�¼���ഥ������Ϣ
end ;
------------------------------------------------------------------------------------------------------------------------
declare
    v_productid            productinfo.productid%type;--��ƷID
    v_productname          varchar2(20);--��Ʒ����
    v_productprice         number(8, 2);--��Ʒ�۸�
    v_quantity             number(10);--����
    v_desperation constant v_productname%type := '����';--����
    v_spitgr               simple_integer     := 99.9;
    v_long                 long               := 'LONG���Ͳ���';
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
        || '����=' || length(v_productname));
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
    type product_rec is record -- �������ͱ��� product_rec
    -- ���������µ�������Ա
                        (
                            v_product_id    products.product_id%type, -- ��ƷID -- �������еı���
                            v_product_name  varchar2(255),            -- ��Ʒ���� -- �������
                            v_product_price number(8, 2)              -- �۸� -- �������
                        ); -- �����м�¼����
    v_product product_rec; -- �������� v_product�������� product_rec
begin
    select PRODUCT_ID, PRODUCT_NAME, LIST_PRICE into v_product from PRODUCTS where PRODUCT_ID = '228';
    --����INTO����ֱ����v_product��¼���ͣ�������ֵ������������¼����ʱ�����Ա��˳�����θ�ֵ�����ָ�ֵ��ʽ�ȽϷ��㡣
    DBMS_OUTPUT.PUT_LINE('product_id=' || v_product.v_product_id); -- ���
    DBMS_OUTPUT.PUT_LINE('product_name=' || v_product.v_product_name); -- ���
    DBMS_OUTPUT.PUT_LINE('product_price=' || v_product.v_product_price); -- ���
end;
/

declare
    v_product products%rowtype; -- �������� v_product�����������Ǳ� products ���м�¼����
begin
    select * into v_product from PRODUCTS where PRODUCT_ID = '228'; -- ��ѯ��һ����¼�浽 v_product
    DBMS_OUTPUT.PUT_LINE('product_id=' || v_product.product_id); -- ���
    DBMS_OUTPUT.PUT_LINE('product_name=' || v_product.product_name); -- ���
    DBMS_OUTPUT.PUT_LINE('product_price=' || v_product.list_price); -- ���
end;

-- ���������ͱ���Ķ����﷨����û�а��������Ķ���
declare
    type ty_name is table of -- ������������
        {
        column_type| -- �������е��������ͣ������������ͣ�
        variable_name%type | -- ��������
    table_name.column_name%type | -- ��������
    table_name%rowtype -- ���ñ������
    }
    [not null]
    index by {pls_integer | binary_integer | varchar2 (v_sieze)};
-- ������ĳ���������������������ͣ��Ͱ�������﷨
    variable_name type_name; -- variable_name �������� type_name �����������

-- ʹ��������Ϊ��ֵ
    declare
    type product_a is table of products%rowtype -- ������һ������������ products ����м�¼
        index by binary_integer; -- �������ͣ�������Ϊ�Ǽ�ֵ
    type product_b is table of varchar2(8) -- �����ڶ������������������� varchar2
        index by pls_integer;-- �������ͣ�������Ϊ�Ǽ�ֵ
    v_prt_row     product_a; -- ��������������� product_a
    v_prt         product_b; -- ��������������� product_b
begin
    v_prt(1) := '����'; --Ϊ������ֵ����ֵ�ķ�ʽͬ�������ƣ��ԡ���������������������ʽ��ֵ����ȡֵʱҲ��Ҫͬ���Ĺ���
    v_prt(-1) := '����';
    select * into v_prt_row(1) from PRODUCTS where PRODUCT_ID = '228'; -- ��������ֵ
    DBMS_OUTPUT.PUT_LINE('������-v_prt_row(1)=' || v_prt_row(1).PRODUCT_ID || '---' || v_prt_row(1).PRODUCT_NAME); -- ���
    DBMS_OUTPUT.PUT_LINE('v_prt(1)=' || v_prt(1)); -- ���
    DBMS_OUTPUT.PUT_LINE('v_prt(-1)=' || v_prt(-1)); -- ���
end;

-- ʹ���ַ�����Ϊ��ֵ
declare
    type pro_a is table of number(8) -- ������������������ number
        index by varchar2(20); -- ��������
    v_pro_char pro_a; -- ��������������� pro_a
begin
    v_pro_char('test') := 123; -- ��������ֵ
    v_pro_char('test1') := 0; -- ��������ֵ
    DBMS_OUTPUT.PUT_LINE('v_pro_char(123)=' || v_pro_char('test')); -- ���������ֵ
    DBMS_OUTPUT.PUT_LINE('v_pro_char(000)=' || v_pro_char('test1'));-- ���������ֵ
    DBMS_OUTPUT.PUT_LINE('v_pro_char(000)=' || v_pro_char.FIRST);
    DBMS_OUTPUT.PUT_LINE('v_pro_char(000)=' || v_pro_char(v_pro_char.FIRST));
end;

declare
    type varr is varray(100) of varchar2(20); -- �������� varr������100��varchar2 ���ͣ�����20
    v_product varr := varr('1', '2'); -- ����������������varr,��ʼ��������Ԫ��
begin
    v_product(1) := 'this is a'; -- ����һ������Ԫ�ظ�ֵ
    v_product(2) := 'this is b'; -- ���ڶ�������Ԫ�ظ�ֵ
    DBMS_OUTPUT.PUT_LINE('v_product(1)=' || v_product(1)); -- ���
    DBMS_OUTPUT.PUT_LINE('v_product(2)=' || v_product(2)); -- ���
end;

declare
    v_result number(10, 4); -- ����������������ͣ�����ʮλ������4λС��
begin
    v_result := sqrt(58 + 25 * 3 + (19 - 9) ** 2); -- ��������ֵ
    if v_result > 20 then
        DBMS_OUTPUT.PUT_LINE('ƽ����=' || v_result); -- ���
        DBMS_OUTPUT.PUT_LINE('���Ϊtrue��������');
    end if;
    DBMS_OUTPUT.PUT_LINE('���Ϊfase������������');
end;

declare
    n_result number(10);
begin
    n_result := 30;
    if n_result >= 30 then
        DBMS_OUTPUT.PUT_LINE('�������30');
    else
        DBMS_OUTPUT.PUT_LINE('���С��30');
    end if;
end;

declare
    n_student number(10);
begin
    n_student := DBMS_RANDOM.VALUE(100, 300);
    if n_student >= 100 and n_student <= 200 then
        DBMS_OUTPUT.PUT_LINE('��ֵ��Χ��100~200֮��');
    elsif n_student >= 200 and n_student <= 250 then
        DBMS_OUTPUT.PUT_LINE('��ֵ��Χ��200~250֮��');
    elsif n_student >= 250 and n_student <= 300 then
        DBMS_OUTPUT.PUT_LINE('��ֵ��Χ��250~300֮��');
        DBMS_OUTPUT.PUT_LINE('��ֵ��' || n_student);
    else
        DBMS_OUTPUT.PUT_LINE('����������������');
    end if;
end ;
select product_name, standard_cost, list_price
from PRODUCTS;

declare
    v_product products%rowtype;
begin
    select * into v_product from PRODUCTS where PRODUCT_ID = 228;
    if v_product.LIST_PRICE >= 2000 then
        DBMS_OUTPUT.PUT_LINE('�ò�Ʒ�۸�ƫ��');
        if v_product.STANDARD_COST >= 2000 then
            DBMS_OUTPUT.PUT_LINE('����2000����ȱ��');
        else
            DBMS_OUTPUT.PUT_LINE('С��2000��ȱ��');
        end if;
    elsif v_product.LIST_PRICE >= 1000 and v_product.LIST_PRICE <= 1500 then
        DBMS_OUTPUT.PUT_LINE('�еȼ۸�');
        if v_product.STANDARD_COST >= 2000 then
            DBMS_OUTPUT.PUT_LINE('����2000����ȱ��');
        else
            DBMS_OUTPUT.PUT_LINE('С��2000��ȱ��');
        end if;
    else
        DBMS_OUTPUT.PUT_LINE('�ò�Ʒ�۸�ƫ��');
        if v_product.STANDARD_COST >= 500 then
            DBMS_OUTPUT.PUT_LINE('��ȱ��');
        else
            DBMS_OUTPUT.PUT_LINE('ȱ��');
        end if;
    end if;
end;

declare
    v_categoryid varchar2(12);
begin
    select CATEGORY_ID into v_categoryid from PRODUCTS where PRODUCT_ID = 228;
    case v_categoryid
        when '2' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '��Ӧfake');
        when '3' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '��Ӧaa');
        when '4' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '��Ӧbb');
        when '1' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '��Ӧironman');
        else DBMS_OUTPUT.PUT_LINE('û���ҵ���Ӧ������');
        end case;
end;
select *
from PRODUCTS;

declare
    v_productinfo number(10, 2);
begin
    select LIST_PRICE into v_productinfo from PRODUCTS where PRODUCT_ID = 98;
    case
        when v_productinfo > 3000 then DBMS_OUTPUT.PUT_LINE('�߼۲�Ʒ���۸��ǣ�' || v_productinfo);
        when v_productinfo >= 2000 and v_productinfo <= 3000
            then DBMS_OUTPUT.PUT_LINE('�м۲�Ʒ���۸��ǣ�' || v_productinfo);
        when v_productinfo <= 1000 then DBMS_OUTPUT.PUT_LINE('�ͼ۲�Ʒ���۸��ǣ�' || v_productinfo);
        else DBMS_OUTPUT.PUT_LINE('�������ϣ��۸��ǣ�' || v_productinfo);
        end case;
end;

declare
    n_num number(8) := 1;
begin
    <<basicloop>>
    loop
        DBMS_OUTPUT.PUT_LINE('��ǰ������ֵ�ǣ�' || n_num);
        n_num := n_num + 1;
        if n_num > 5 then
            DBMS_OUTPUT.PUT_LINE('��������ǰ������ֵ�ǣ�' || n_num);
            exit basicloop;
        end if;
    end loop;
    DBMS_OUTPUT.PUT_LINE('ѭ������');
end ;

declare
    n_num number(8) := 1;
begin
    <<basicloop>>
    loop
        DBMS_OUTPUT.PUT_LINE('��ǰ������ֵ�ǣ�' || n_num);
        n_num := n_num + 1;
        exit basicloop when n_num > 5;
    end loop;
    DBMS_OUTPUT.PUT_LINE('ѭ������');
end ;

declare
    n_num number(8) := 1;
begin
    DBMS_OUTPUT.PUT_LINE('��ǰ������ֵ�ǣ�' || n_num);
    <<while_loop>>
    while n_num < 20
        loop
            if mod(n_num, 3) = 0 then
                DBMS_OUTPUT.PUT_LINE('�ܱ�3���������У�' || n_num);
            end if;
            n_num := n_num + 1;
        end loop;
    DBMS_OUTPUT.PUT_LINE('�˳�����ǰ������ֵ�ǣ�' || n_num);
    DBMS_OUTPUT.PUT_LINE('����ѭ��');
end ;

declare
    n_num number(8) := 1;
    v_num boolean   := true;
begin
    while v_num
        loop
            if mod(n_num, 3) = 0 then
                DBMS_OUTPUT.PUT_LINE('�ܱ��������������У�' || n_num);
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
    DBMS_OUTPUT.PUT_LINE('1��100֮���������ǣ�' || num);
    DBMS_OUTPUT.PUT_LINE('loop ѭ������');
end;

select *
from PRODUCTS;

declare
    vc_id varchar2(10) := 0;
    b_bol boolean      := true;
begin
    select CATEGORY_ID into vc_id from PRODUCTS where PRODUCT_NAME = 'Intel Xeon E5-2699 V3 (OEM/Tray)';
    DBMS_OUTPUT.PUT_LINE('���Զ�Ӧ�ı���ID�ǣ�' || vc_id);
exception
    when no_data_found then
        if b_bol then
            DBMS_OUTPUT.PUT_LINE('û�ж�Ӧ�ı��룬Ϊ�����ӵ�������');
            insert into PRODUCTS (PRODUCT_ID, PRODUCT_NAME) values ('001234', 'MacPro');
            commit;
        end if;
    when too_many_rows then
        DBMS_OUTPUT.PUT_LINE('��Ӧ���ݹ��࣬��ȷ��');
end;

DECLARE
    v_catgid VARCHAR2(10) := 0;
    v_bol    BOOLEAN      := TRUE;
BEGIN
    SELECT CATEGORYID
    INTO v_catgid
    FROM CATEGORYINFO
    WHERE CATEGORYNAME = '����';
    DBMS_OUTPUT.PUT_LINE('���Զ�Ӧ�ı�����ڣ�' || v_catgid);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        IF v_bol THEN
            DBMS_OUTPUT.PUT_LINE('û�ж�Ӧ�ı��룬Ϊ�����Ӹò�Ʒ����');
            INSERT INTO CATEGORYINFO VALUES ('0100000001', '����');
            COMMIT;
        END IF;
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('��Ӧ���ݹ��࣬��ȷ�ϣ�');
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

