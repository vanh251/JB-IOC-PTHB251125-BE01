-- create database SchoolDB;

create schema school;

set search_path to school;

CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    dob DATE
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    credits INT
);

create table Enrollments(
    enrollment_id serial primary key ,
    student_id int ,
    course_id int ,
    grade char(1) ,
    constraint fk_student foreign key (student_id) references Students (student_id),
    constraint fk_course foreign key (course_id) references Courses (course_id) ,
    constraint check_grade check ( grade in ('A', 'B', 'C', 'D', 'E', 'F') )
);