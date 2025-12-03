create schema other_school;

set search_path to other_school;

create table students(
    id serial primary key ,
    name varchar(50) ,
    age int ,
    major varchar(50) ,
    gpa decimal(3,2)
);

insert into students (name, age, major, gpa) values
('An', '20', 'CNTT', 3.5),
('Binh', 21, 'toán', 3.2),
('cường', 22, 'CNTT', 3.8),
('em', 21, 'CNTT', 2.9);

insert into students (name, age, major, gpa) values
('Hung', 23, 'Hoa hoc', 3.4);

delete from students
where gpa < 3.6;

select name, major
from students
order by gpa desc ;

select distinct name
from  students
where major ilike '%CNTT%';

select id, name
from students
where gpa between 3.0 and 3.6;

select id, name
from students
where name ilike 'c%';

select *
from students
order by name
limit 2
offset 2;