-- demo 01
begin
    -- ִ���忪ʼ
    dbms_output.put_line( '����ִ���岿��......' ); -- �����仰����Ļ
end;
-- ִ�������

-- demo 02
declare -- ���������Ĺؼ���
    result number(8 , 2); -- ����һ������ result ,���������� number
begin
    -- ִ���忪ʼ
    result := 100 / 6; -- ��������ֵ
    dbms_output.put_line( '���Ľ���ǣ�' || result ); -- ������
end;
-- ����

-- demo 03
declare
    v_product_id varchar2(12);
begin
    select product_id
    into v_product_id -- select ������ into ... PL/SQL ���еĸ�ֵ��䣨select �������˳��Ҫ�� into �������˳��һһ��Ӧ��
    from products
    where products.product_name = 'Intel Xeon E5-2697 V3'; -- �����ݴ��뵽 v_product��
    dbms_output.put_line( '��Ʒ��Ӧ�ı�����' || v_product_id );
exception
    -- ���������ֻ�ܷ���һ�����ݣ�����һ����ᴥ���쳣
    when no_data_found then
        dbms_output.put_line( 'û�ж�Ӧ�ı���' ); -- �Ҳ������ݴ�������Ϣ
    when too_many_rows then
        dbms_output.put_line( '��Ӧ���ݹ��࣬��ȷ��' ); -- ���ؼ�¼���ഥ������Ϣ
end ;
------------------------------------------------------------------------------------------------------------------------
declare
    v_productid            productinfo.productid%type;--��ƷID
    v_productname          varchar2(20);--��Ʒ����
    v_productprice         number(8 , 2);--��Ʒ�۸�
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
    dbms_output.put_line( 'v_productid=' || v_productid );
    dbms_output.put_line( 'v_productname=' || v_productname
        || '����=' || length( v_productname ) );
    dbms_output.put_line( 'v_productprice=' || v_productprice );
    dbms_output.put_line( 'v_quantity=' || v_quantity );
    dbms_output.put_line( 'v_desperation=' || v_desperation );
    dbms_output.put_line( 'v_spitgr=' || v_spitgr );
    dbms_output.put_line( 'v_long=' || v_long );
    dbms_output.put_line( 'v_date=' || v_date );
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
                        ( v_product_id    products.product_id%type , -- ��ƷID -- �������еı���
                          v_product_name  varchar2(255) ,            -- ��Ʒ���� -- �������
                          v_product_price number(8 , 2)              -- �۸� -- �������
                        ); -- �����м�¼����
    v_product product_rec; -- �������� v_product�������� product_rec
begin
    select product_id, product_name, list_price into v_product from products where product_id = '228';
    --����INTO����ֱ����v_product��¼���ͣ�������ֵ������������¼����ʱ�����Ա��˳�����θ�ֵ�����ָ�ֵ��ʽ�ȽϷ��㡣
    dbms_output.put_line( 'product_id=' || v_product.v_product_id ); -- ���
    dbms_output.put_line( 'product_name=' || v_product.v_product_name ); -- ���
    dbms_output.put_line( 'product_price=' || v_product.v_product_price ); -- ���
end;
/
declare
    v_product products%rowtype; -- �������� v_product�����������Ǳ� products ���м�¼����
begin
    select * into v_product from products where product_id = '228'; -- ��ѯ��һ����¼�浽 v_product
    dbms_output.put_line( 'product_id=' || v_product.product_id ); -- ���
    dbms_output.put_line( 'product_name=' || v_product.product_name ); -- ���
    dbms_output.put_line( 'product_price=' || v_product.list_price ); -- ���
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
    v_prt( 1 ) := '����'; --Ϊ������ֵ����ֵ�ķ�ʽͬ�������ƣ��ԡ���������������������ʽ��ֵ����ȡֵʱҲ��Ҫͬ���Ĺ���
    v_prt( -1 ) := '����';
    select * into v_prt_row( 1 ) from products where product_id = '228'; -- ��������ֵ
    dbms_output.put_line( '������-v_prt_row(1)=' || v_prt_row( 1 ).product_id || '---' ||
                          v_prt_row( 1 ).product_name ); -- ���
    dbms_output.put_line( 'v_prt(1)=' || v_prt( 1 ) ); -- ���
    dbms_output.put_line( 'v_prt(-1)=' || v_prt( -1 ) ); -- ���
end;

-- ʹ���ַ�����Ϊ��ֵ
declare
    type pro_a is table of number(8) -- ������������������ number
        index by varchar2(20); -- ��������
    v_pro_char pro_a; -- ��������������� pro_a
begin
    v_pro_char( 'test' ) := 123; -- ��������ֵ
    v_pro_char( 'test1' ) := 0; -- ��������ֵ
    dbms_output.put_line( 'v_pro_char(123)=' || v_pro_char( 'test' ) ); -- ���������ֵ
    dbms_output.put_line( 'v_pro_char(000)=' || v_pro_char( 'test1' ) );-- ���������ֵ
    dbms_output.put_line( 'v_pro_char(000)=' || v_pro_char.first );
    dbms_output.put_line( 'v_pro_char(000)=' || v_pro_char( v_pro_char.first ) );
end;
declare
    type varr is varray(100) of varchar2(20); -- �������� varr������100��varchar2 ���ͣ�����20
    v_product varr := varr( '1' , '2' ); -- ����������������varr,��ʼ��������Ԫ��
begin
    v_product( 1 ) := 'this is a'; -- ����һ������Ԫ�ظ�ֵ
    v_product( 2 ) := 'this is b'; -- ���ڶ�������Ԫ�ظ�ֵ
    dbms_output.put_line( 'v_product(1)=' || v_product( 1 ) ); -- ���
    dbms_output.put_line( 'v_product(2)=' || v_product( 2 ) ); -- ���
end;
declare
    v_result number(10 , 4); -- ����������������ͣ�����ʮλ������4λС��
begin
    v_result := sqrt( 58 + 25 * 3 + ( 19 - 9 ) ** 2 ); -- ��������ֵ
    if v_result > 20
        then
            dbms_output.put_line( 'ƽ����=' || v_result ); -- ���
            dbms_output.put_line( '���Ϊtrue��������' );
        end if;
    dbms_output.put_line( '���Ϊfase������������' );
end;
declare
    n_result number(10);
begin
    n_result := 30;
    if n_result >= 30
        then
            dbms_output.put_line( '�������30' );
        else
            dbms_output.put_line( '���С��30' );
        end if;
end;
declare
    n_student number(10);
begin
    n_student := dbms_random.value( 100 , 300 );
    if n_student >= 100 and n_student <= 200
        then
            dbms_output.put_line( '��ֵ��Χ��100~200֮��' );
        elsif n_student >= 200 and n_student <= 250
            then
                dbms_output.put_line( '��ֵ��Χ��200~250֮��' );
        elsif n_student >= 250 and n_student <= 300
            then
                dbms_output.put_line( '��ֵ��Χ��250~300֮��' );
                dbms_output.put_line( '��ֵ��' || n_student );
        else
            dbms_output.put_line( '����������������' );
        end if;
end ;
select product_name, standard_cost, list_price
from products;
declare
    v_product products%rowtype;
begin
    select * into v_product from products where product_id = 228;
    if v_product.list_price >= 2000
        then
            dbms_output.put_line( '�ò�Ʒ�۸�ƫ��' );
            if v_product.standard_cost >= 2000
                then
                    dbms_output.put_line( '����2000����ȱ��' );
                else
                    dbms_output.put_line( 'С��2000��ȱ��' );
                end if;
        elsif v_product.list_price >= 1000 and v_product.list_price <= 1500
            then
                dbms_output.put_line( '�еȼ۸�' );
                if v_product.standard_cost >= 2000
                    then
                        dbms_output.put_line( '����2000����ȱ��' );
                    else
                        dbms_output.put_line( 'С��2000��ȱ��' );
                    end if;
        else
            dbms_output.put_line( '�ò�Ʒ�۸�ƫ��' );
            if v_product.standard_cost >= 500
                then
                    dbms_output.put_line( '��ȱ��' );
                else
                    dbms_output.put_line( 'ȱ��' );
                end if;
        end if;
end;
declare
    v_categoryid varchar2(12);
begin
    select category_id into v_categoryid from products where product_id = 228;
    case v_categoryid
        when '2'
            then dbms_output.put_line( v_categoryid || '��Ӧfake' );
        when '3'
            then dbms_output.put_line( v_categoryid || '��Ӧaa' );
        when '4'
            then dbms_output.put_line( v_categoryid || '��Ӧbb' );
        when '1'
            then dbms_output.put_line( v_categoryid || '��Ӧironman' );
            else dbms_output.put_line( 'û���ҵ���Ӧ������' );
        end case;
end;
select *
from products;
declare
    v_productinfo number(10 , 2);
begin
    select list_price into v_productinfo from products where product_id = 98;
    case
        when v_productinfo > 3000
            then dbms_output.put_line( '�߼۲�Ʒ���۸��ǣ�' || v_productinfo );
        when v_productinfo >= 2000 and v_productinfo <= 3000
            then dbms_output.put_line( '�м۲�Ʒ���۸��ǣ�' || v_productinfo );
        when v_productinfo <= 1000
            then dbms_output.put_line( '�ͼ۲�Ʒ���۸��ǣ�' || v_productinfo );
            else dbms_output.put_line( '�������ϣ��۸��ǣ�' || v_productinfo );
        end case;
end;
declare
    n_num number(8) := 1;
begin
    <<basicloop>>
    loop
        dbms_output.put_line( '��ǰ������ֵ�ǣ�' || n_num );
        n_num := n_num + 1;
        if n_num > 5
            then
                dbms_output.put_line( '��������ǰ������ֵ�ǣ�' || n_num );
                exit basicloop;
            end if;
    end loop;
    dbms_output.put_line( 'ѭ������' );
end ;
declare
    n_num number(8) := 1;
begin
    <<basicloop>>
    loop
        dbms_output.put_line( '��ǰ������ֵ�ǣ�' || n_num );
        n_num := n_num + 1;
        exit basicloop when n_num > 5;
    end loop;
    dbms_output.put_line( 'ѭ������' );
end ;
declare
    n_num number(8) := 1;
begin
    dbms_output.put_line( '��ǰ������ֵ�ǣ�' || n_num );
    <<while_loop>>
    while n_num < 20
        loop
            if mod( n_num , 3 ) = 0
                then
                    dbms_output.put_line( '�ܱ�3���������У�' || n_num );
                end if;
            n_num := n_num + 1;
        end loop;
    dbms_output.put_line( '�˳�����ǰ������ֵ�ǣ�' || n_num );
    dbms_output.put_line( '����ѭ��' );
end ;
declare
    n_num number(8) := 1;
    v_num boolean   := true;
begin
    while v_num
        loop
            if mod( n_num , 3 ) = 0
                then
                    dbms_output.put_line( '�ܱ��������������У�' || n_num );
                end if;
            if n_num >= 20
                then
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
    dbms_output.put_line( '1��100֮���������ǣ�' || num );
    dbms_output.put_line( 'loop ѭ������' );
end;
select *
from products;
declare
    vc_id varchar2(10) := 0;
    b_bol boolean      := true;
begin
    select category_id into vc_id from products where product_name = 'Intel Xeon E5-2699 V3 (OEM/Tray)';
    dbms_output.put_line( '���Զ�Ӧ�ı���ID�ǣ�' || vc_id );
exception
    when no_data_found then
        if b_bol
            then
                dbms_output.put_line( 'û�ж�Ӧ�ı��룬Ϊ�����ӵ�������' );
                insert
                into products ( product_id , product_name ) values ( '001234' , 'MacPro' );
                commit;
            end if;
    when too_many_rows then
        dbms_output.put_line( '��Ӧ���ݹ��࣬��ȷ��' );
end;
declare
    v_catgid varchar2(10) := 0;
    v_bol    boolean      := true;
begin
    select categoryid
    into v_catgid
    from categoryinfo
    where categoryname = '����';
    dbms_output.put_line( '���Զ�Ӧ�ı�����ڣ�' || v_catgid );

exception
    when no_data_found then
        if v_bol
            then
                dbms_output.put_line( 'û�ж�Ӧ�ı��룬Ϊ�����Ӹò�Ʒ����' );
                insert
                into categoryinfo values ( '0100000001' , '����' );
                commit;
            end if;
    when too_many_rows then
        dbms_output.put_line( '��Ӧ���ݹ��࣬��ȷ�ϣ�' );
end;
declare
    table_name varchar2(200);
begin
    table_name := 'create table test_DDL(
        id varchar2(10),
        name varchar2(10)
        )';
    execute immediate table_name;
end;
begin
    for i in 1..100
        loop
            dbms_output.put_line( i );
        end loop;
end;

declare
    v_categoryid varchar2(12);
begin
    select CATEGORY_ID into v_categoryid from PRODUCTS where PRODUCT_ID = 228;
    case v_categoryid
        when '2' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '��Ӧfake'); -- �ҵ���Ӧ�����ֱ�ӽ��� case ������ִ��֮��� when...then
        when '3' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '��Ӧaa');
        when '4' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '��Ӧbb');
        when '1' then DBMS_OUTPUT.PUT_LINE(v_categoryid || '��Ӧironman');
        else DBMS_OUTPUT.PUT_LINE('û���ҵ���Ӧ������');
        end case;
end;