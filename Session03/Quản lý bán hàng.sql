-- create schema sales;

set search_path to sales;

create table Members(
    member_id int primary key ,
    name varchar(100),
    email varchar(100) unique
);

create table Products(
    product_id serial primary key ,
    product_name varchar(50),
    price numeric(2),
    stock_quantity int
);

create table Orders(
    order_id serial primary key ,
    order_date date default current_date ,
    member_id int references Members(member_id)
);

create table OrderDetails(
    order_detail_id serial primary key ,
    order_id int references Orders(order_id),
    product_id int references Products(product_id),
    quantity int
);