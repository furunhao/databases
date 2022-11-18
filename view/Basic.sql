create or replace view regions_name_view as
select REGION_NAME
from REGIONS;

select *
from REGIONS
where ROWNUM < 1; -- ROWNUM 函数，限制返回数据的数量

select view_name
from user_views; -- 查询用户下的视图数量

create or replace view mult_view as
select ct.customer_id, ct.name, ct.address, ct.website, ct.credit_limit
from CUSTOMERS ct,
     ORDER_ITEMS oi
where ct.CUSTOMER_ID = oi.ORDER_ID
  and rownum < 20;

create or replace view vi_mult_view as
select name, address
from mult_view;

create or replace view dml_view as
select *
from PRODUCTS
where CATEGORY_ID = 1
  and ROWNUM < 21
with check option;


create procedure test as
begin
    DBMS_OUTPUT.PUT_LINE('这是第一个存储过程');
end;

create or replace procedure productinfo as
begin
    update PRODUCTS
    set PRODUCT_NAME = 'sale'
    where PRODUCT_ID in
          ( select PRODUCT_ID from ( select * from PRODUCTS order by PRODUCT_NAME desc ) where rownum < 4 );
    commit;
end;

