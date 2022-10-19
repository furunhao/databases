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
    select
        PRODUCT_ID
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
    select
        productid,
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

select
    product_id,
    product_name,
    list_price
from products
where list_price < 5499.99
union
select
    product_id,
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
    v_prt_row product_a; -- ��������������� product_a
    v_prt product_b; -- ��������������� product_b
    begin
    v_prt(1):='����'; --Ϊ������ֵ����ֵ�ķ�ʽͬ�������ƣ��ԡ���������������������ʽ��ֵ����ȡֵʱҲ��Ҫͬ���Ĺ���
    v_prt(-1):='����';
    select * into v_prt_row(1) from PRODUCTS where PRODUCT_ID = '228'; -- ��������ֵ
    DBMS_OUTPUT.PUT_LINE('������-v_prt_row(1)='||v_prt_row(1).PRODUCT_ID||'---'||v_prt_row(1).PRODUCT_NAME); -- ���
    DBMS_OUTPUT.PUT_LINE('v_prt(1)='||v_prt(1)); -- ���
    DBMS_OUTPUT.PUT_LINE('v_prt(-1)='||v_prt(-1)); -- ���
end;

-- ʹ���ַ�����Ϊ��ֵ
declare
    type pro_a is table of number(8) -- ������������������ number
    index by varchar2(20); -- ��������
    v_pro_char pro_a; -- ��������������� pro_a
    begin
    v_pro_char('test'):=123; -- ��������ֵ
    v_pro_char('test1'):=0;  -- ��������ֵ
    DBMS_OUTPUT.PUT_LINE('v_pro_char(123)='||v_pro_char('test')); -- ���������ֵ
    DBMS_OUTPUT.PUT_LINE('v_pro_char(000)='||v_pro_char('test1'));-- ���������ֵ
    DBMS_OUTPUT.PUT_LINE('v_pro_char(000)='||v_pro_char.FIRST);
    DBMS_OUTPUT.PUT_LINE('v_pro_char(000)='||v_pro_char(v_pro_char.FIRST));
end;

declare
    type varr is varray(100) of varchar2(20); -- �������� varr������100��varchar2 ���ͣ�����20
    v_product varr:=varr('1','2'); -- ����������������varr,��ʼ��������Ԫ��
    begin
    v_product(1):='this is a'; -- ����һ������Ԫ�ظ�ֵ
    v_product(2):='this is b'; -- ���ڶ�������Ԫ�ظ�ֵ
    DBMS_OUTPUT.PUT_LINE('v_product(1)='||v_product(1)); -- ���
    DBMS_OUTPUT.PUT_LINE('v_product(2)='||v_product(2)); -- ���
end;

declare
    v_result number(10,4); -- ����������������ͣ�����ʮλ������4λС��
    begin
    v_result:=sqrt(58+25*3+(19-9)**2); -- ��������ֵ
    if v_result > 20 then
    DBMS_OUTPUT.PUT_LINE('ƽ����='||v_result); -- ���
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
