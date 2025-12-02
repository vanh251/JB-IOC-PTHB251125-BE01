set search_path to library;

create table Books(
    book_id int primary key ,
    title varchar(100) ,
    author varchar(100) ,
    published_year int ,
    available boolean default true
);

create table Members(
    member_id int primary key ,
    name varchar(100),
    email varchar(100) unique ,
    join_date date default current_date
);