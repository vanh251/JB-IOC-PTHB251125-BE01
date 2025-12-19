CREATE TABLE Employee (
                          id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          department VARCHAR(50),
                          salary NUMERIC(10, 2),
                          hire_date DATE
);

INSERT INTO Employee (full_name, department, salary, hire_date) VALUES
                                                                    ('Nguyen Van An', 'IT', 15000000, '2023-05-15'),
                                                                    ('Tran Thi Binh', 'HR', 5000000, '2022-10-20'),
                                                                    ('Le Van Can', 'IT', 8000000, '2023-01-10'),
                                                                    ('Pham Minh Tuan', 'Marketing', 20000000, '2021-06-01'),
                                                                    ('Hoang Thu Trang', 'IT', 5500000, '2024-02-01'),
                                                                    ('Doan Du', 'Sales', 5800000, '2023-11-20');

-- Kiểm tra bảng trước khi update
SELECT * FROM Employee;

UPDATE Employee
SET salary = salary * 1.1
WHERE department = 'IT';

DELETE FROM Employee
WHERE salary < 6000000;

-- Kiểm tra bảng sau khi thay đổi
SELECT * FROM Employee;

SELECT * FROM Employee
WHERE full_name ILIKE '%An%';

SELECT * FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';