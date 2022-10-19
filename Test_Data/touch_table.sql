create table regions
(
    region_id   number primary key,
    region_name varchar2(50) not null
);
-- countries table ´´½¨Ô¼Êø
create table countries
(
    country_id   char(2) primary key,
    country_name varchar2(40) not null,
    region_id    number, -- fk
    constraint fk_countries_regions foreign key (region_id)
        references regions (region_id)
        on delete cascade
);

-- location
create table locations
(
    location_id number primary key,
    address     varchar2(255) not null,
    postal_code varchar2(20),
    city        varchar2(50),
    state       varchar2(50),
    country_id  char(2), -- fk
    constraint fk_locations_countries
        foreign key (country_id)
            references countries (country_id)
            on delete cascade
);
-- warehouses
create table warehouses
(
    warehouse_id   number primary key,
    warehouse_name varchar(255),
    location_id    number(12 , 0), -- fk
    constraint fk_warehouses_locations
        foreign key (location_id)
            references locations (location_id)
            on delete cascade
);
-- employees
create table employees
(
    employee_id number primary key,
    first_name  varchar(255) not null,
    last_name   varchar(255) not null,
    email       varchar(255) not null,
    phone       varchar(50)  not null,
    hire_date   date         not null,
    manager_id  number(12 , 0), -- fk
    job_title   varchar(255) not null,
    constraint fk_employees_manager
        foreign key (manager_id)
            references employees (employee_id)
            on delete cascade
);
-- product category
create table product_categories
(
    category_id   number primary key,
    category_name varchar2(255) not null
);

-- products table
create table products
(
    product_id    number primary key,
    product_name  varchar2(255) not null,
    description   varchar2(2000),
    standard_cost number(9 , 2),
    list_price    number(9 , 2),
    category_id   number not null,
    constraint fk_products_categories
        foreign key (category_id)
            references product_categories (category_id)
            on delete cascade
);
-- customers
create table customers
(
    customer_id  number primary key,
    name         varchar2(255) not null,
    address      varchar2(255),
    website      varchar2(255),
    credit_limit number(8 , 2)
);
-- contacts
create table contacts
(
    contact_id  number primary key,
    first_name  varchar2(255) not null,
    last_name   varchar2(255) not null,
    email       varchar2(255) not null,
    phone       varchar2(20),
    customer_id number,
    constraint fk_contacts_customers
        foreign key (customer_id)
            references customers (customer_id)
            on delete cascade
);
-- orders table
create table orders
(
    order_id    number primary key,
    customer_id number(6 , 0) not null, -- fk
    status      varchar(20) not null,
    salesman_id number(6 , 0),          -- fk
    order_date  date        not null,
    constraint fk_orders_customers
        foreign key (customer_id)
            references customers (customer_id)
            on delete cascade,
    constraint fk_orders_employees
        foreign key (salesman_id)
            references employees (employee_id)
            on delete set null
);
-- order items
create table order_items
(
    order_id   number(12 , 0),          -- fk
    item_id    number(12 , 0),
    product_id number(12 , 0) not null, -- fk
    quantity   number(8 , 2) not null,
    unit_price number(8 , 2) not null,
    constraint pk_order_items
        primary key (order_id, item_id),
    constraint fk_order_items_products
        foreign key (product_id)
            references products (product_id)
            on delete cascade,
    constraint fk_order_items_orders
        foreign key (order_id)
            references orders (order_id)
            on delete cascade
);
-- inventories
create table inventories
(
    product_id   number(12 , 0), -- fk
    warehouse_id number(12 , 0), -- fk
    quantity     number(8 , 0) not null,
    constraint pk_inventories
        primary key (product_id, warehouse_id),
    constraint fk_inventories_products
        foreign key (product_id)
            references products (product_id)
            on delete cascade,
    constraint fk_inventories_warehouses
        foreign key (warehouse_id)
            references warehouses (warehouse_id)
            on delete cascade
);