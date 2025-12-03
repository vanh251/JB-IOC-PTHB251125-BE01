-- create schema test03;

set search_path to test03;

CREATE TABLE students
(
    id         SERIAL PRIMARY KEY,
    full_name  VARCHAR(100),
    gender     VARCHAR(10),
    birth_year INT,
    major      VARCHAR(50),
    gpa        DECIMAL(3, 1)
);

INSERT INTO students (id, full_name, gender, birth_year, major, gpa)
VALUES (1, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
       (2, 'Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
       (3, 'Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
       (4, 'Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
       (5, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
       (6, 'Lưu Đức Tài', 'Nam', 2004, 'Cơ khí', NULL),
       (7, 'Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);

--Thêm sinh viên “Phan Hoàng Nam”, giới tính Nam, sinh năm 2003, ngành CNTT, GPA 3.8
INSERT INTO students (id, full_name, gender, birth_year, major, gpa)
VALUES (8 ,'Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

--Sinh viên “Lê Quốc Cường” vừa cải thiện học lực, cập nhật gpa = 3.4
update students
set gpa = 3.4
where full_name ilike 'Lê quốc cường';

--Xóa tất cả sinh viên có gpa IS NULL
delete from students
where gpa is null;

--Hiển thị sinh viên ngành CNTT có gpa >= 3.0, chỉ lấy 3 kết quả đầu tiên
select *
from students
where gpa>=3.0
limit 3;

--Liệt kê danh sách ngành học duy nhất
select distinct major from students;

--Hiển thị sinh viên ngành CNTT, sắp xếp giảm dần theo GPA, sau đó tăng dần theo tên
select full_name, major, gpa from students
where major ilike '%CNTT%'
order by gpa desc , full_name;

--Tìm sinh viên có tên bắt đầu bằng “Nguyễn”
select * from students
where full_name ilike 'Nguyễn%';

--Hiển thị sinh viên có năm sinh từ 2001 đến 2003
select * from students
where birth_year between 2001 and 2003;