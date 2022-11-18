-- demo 01
declare
    cursor test
        is select *
           from products;
    cur_test products%rowtype;
begin
    open test;
    fetch test into cur_test;
    dbms_output.put_line( cur_test.product_name || '**and**' || cur_test.product_id || '**and**' ||
                          cur_test.list_price );
    close test;
end;

-- demo 02
declare
    cur_productid    varchar(10);
    cur_productname  products.product_name%type;
    cur_productprice products.list_price%type;
    cursor test02
        is select product_id, product_name, list_price
           from products
           where rownum = 1;
begin
    open test02;
    fetch test02 into cur_productid,cur_productname,cur_productprice;
    dbms_output.put_line( cur_productid || ' + ' || cur_productname || ' + ' || cur_productprice );
    close test02;
end;

-- loop
declare
    cursor demo_loop
        is select product_id, product_name, list_price
           from products
           where list_price > 2500;
    cur_productid    products.product_id%type;
    cur_productname  products.product_name%type;
    cur_productprice products.list_price%type;

begin
    open demo_loop;
    loop
        fetch demo_loop into cur_productid,cur_productname,cur_productprice;
        exit when demo_loop%notfound;
        dbms_output.put_line( cur_productid || ' + ' || cur_productname || ' + ' || cur_productprice );
    end loop;
    close demo_loop;
end;

-- bulk collect
declare
    cursor collect_for
        is select *
           from products
           where list_price > 2000;
    type collect_table is table of products%rowtype;
    collect_rd collect_table;
begin
    open collect_for;
    loop
        fetch collect_for bulk collect into collect_rd limit 5;
        for collet_rd in collect_for
            loop
                dbms_output.put_line( '��Ʒid��' || collect_rd.product_id || '��Ʒ���ƣ�' ||
                                      collect_rd.product_name || '��Ʒ�۸�' || collect_rd.list_price );
            end loop;
        close collect_for;
    end loop;
end ;
declare
    cursor cfl is select product_name, list_price -- �����α겢������ѯ
                  from products
                  where list_price > 2500
                    and rownum < 6;
begin
    for curcfl in cfl -- �α귵�ص����ݷŵ� curcfl ��������� %rowtype
        loop
            dbms_output.put_line( '���ƣ�' || curcfl.product_name || '�۸�' || curcfl.list_price );
        end loop;
end;
declare
    cursor prct_isopen_cur is select product_name, list_price
                              from products
                              where list_price > 2500;
    cur_prodrcd product%rowtype;
begin
    open prct_isopen_cur;
    if prct_isopen_cur%isopen
        then
            loop
                fetch prct_isopen_cur into cur_prodrcd;
                exit when prct_isopen_cur%notfound;
                dbms_output.put_line( '��Ʒ���ƣ�' || cur_prodrcd.product_name || '��Ʒ�۸�' || cur_prodrcd.list_price );
            end loop;
        else
            dbms_output.put_line( '�α�û�д�' );
        end if;
end;
declare
    cursor test_found is select id, name
                         from test_ddl;
    found_bl test_ddl%rowtype;
begin
    open test_found;
    loop
        fetch test_found into found_bl;
        if test_found%found
            then
                dbms_output.put_line( '���ƣ�' || found_bl.id || '��Ʒ�۸�' || found_bl.name );
            else
                dbms_output.put_line( 'û�з�������' );
                exit;
            end if;
    end loop;
end;
declare
    cur_product_id    oraclea.id%type    := '0324';
    cur_product_price oraclea.price%type := '1200';
    cur_product_name  oraclea%rowtype;
    cursor cur_oracle(id varchar,price number) is select *
                                                  from oraclea;
begin
    open cur_oracle( cur_product_id , cur_product_price );
    loop
        fetch cur_oracle into cur_product_name;
        exit when cur_oracle%notfound;
        dbms_output.put_line( '��ƷID��' || cur_product_name.id || '��Ʒ���ƣ�' || cur_product_name.price ||
                              '��Ʒ���ƣ�' ||
                              cur_product_name.name );
    end loop;
    close cur_oracle;
end;
declare
    cur_product_name test_ddl.name%type;
    cur_product_id   test_ddl.id%type;
begin
    select name, id into cur_product_name,cur_product_id from test_ddl;
    if sql%found
        then
            dbms_output.put_line( '��Ʒ���ƣ�' || cur_product_name || '��Ʒid��' || cur_product_id );
        end if;
end;
declare
    cur_product_name test_ddl.name%type;
    cur_product_id   test_ddl.id%type;
begin
    select name, id into cur_product_name,cur_product_id from test_ddl;
    if sql%found
        then
            dbms_output.put_line( '��Ʒ���ƣ�' || cur_product_name || '��Ʒid��' || cur_product_id );
        end if;
exception
    when no_data_found then
        dbms_output.put_line( '������' ); -- ��������������ִ�д����
    when too_many_rows then
        dbms_output.put_line( '���ݹ���' ); -- �������ݳ��� 1 ��ִ�д����
end;
select *
from products;
create procedure product_cur_prc
as
    cur_product_id   product_info.category_id%type; -- ������ͱ���
    cur_product_name product_info.category_name%type; -- ��Ų�Ʒ��������
    cur_prtinfo      product_info%rowtype; -- ��ű� products ���м�¼

    cursor cur_category_id is select category
                              from categoryinfo
                              group by category;
begin
    open cur_category_id;
    loop
        fetch cur_category_id into cur_product_id;
        exit when cur_category_id%notfound;
        select categoryname
        into cur_product_name
        from categoryinfo
        where category = cur_product_id;
    end loop;
end;