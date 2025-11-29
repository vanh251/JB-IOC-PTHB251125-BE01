-- create database SalesDB;

create schema if not exists sales;

set search_path to sales;

create table Customers(
    customer_id serial primary key ,
    first_name varchar(50) not null ,
    last_name varchar(50) not null ,
    email text unique not null ,
    phone varchar(10)
);

create table products (
    product_id serial primary key ,
    product_name varchar(100) not null ,
    price float not null ,
    stock_quantity int not null
);

create table Orders (
    order_id serial primary key ,
    customer_id int references Customers(customer_id),
    out_date date
);

create table OrderItems(
    oder_item_id serial primary key ,
    order_id int references Orders(order_id),
    product_id int references products(product_id),
    quantity int check ( quantity >=1 )
);

