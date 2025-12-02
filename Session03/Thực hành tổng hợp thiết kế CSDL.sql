-- create database CompanyDB ;
-- create schema company;

set search_path to company;

create table Employees(
    emp_id serial primary key ,
    name varchar(50) not null ,
    department_id int
);

create table Departments(
    department_id serial primary key ,
    department_name varchar(50)
);

create table projects(
    project_id serial primary key ,
    project_name varchar(50),
    start_date date,
    end_date date
);

create table EmployeeProjects(
    emp_id int references Employees(emp_id),
    project_id int references projects(project_id)
);

alter table Employees
add constraint fk_department foreign key (department_id) references Departments(department_id);