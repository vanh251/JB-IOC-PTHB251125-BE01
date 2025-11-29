-- create database ElearningDB;

create schema elearning;

set search_path to elearning;

create table Students(
    student_id serial primary key ,
    first_name varchar(50) not null ,
    last_name varchar(50) not null ,
    email text unique not null
);

create table Instructors(
    instructor_id serial primary key ,
    first_name varchar(50) not null ,
    last_name varchar(50) not null ,
    email text unique not null
);

create table Courses(
    course_id serial primary key ,
    course_name varchar(100) not null ,
    instructor_id int references Instructors(instructor_id)
);

create table Enrollments(
    enrollment_id serial primary key ,
    student_id int references Students(student_id),
    course_id int references Courses(course_id),
    enroll_date date not null
);

create table Assignments(
    assignment_id serial primary key ,
    course_id int references Courses(course_id),
    title varchar(100) not null ,
    due_date date not null
);

create table Submissions(
    submission_id serial primary key ,
    assignment_id int references Assignments(assignment_id),
    student_id int references Students(student_id),
    submission_date date not null ,
    grade float check ( grade between 0 and 100)
);