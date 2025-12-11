set search_path to test03;

CREATE TABLE employees (
                           emp_id SERIAL PRIMARY KEY,
                           emp_name VARCHAR(100),
                           job_level INT,
                           salary NUMERIC
);

INSERT INTO employees (emp_name, job_level, salary)
VALUES
    ('Nguyen Van An', 1, 12000000),
    ('Tran Thi Bich', 2, 25000000.50),
    ('Le Van Cuong', 3, 45000000),
    ('Pham Thi Duyen', 1, 11500000),
    ('Hoang Van Em', 2, 23000000);

-- Công ty muốn cập nhật mức lương mới cho từng nhân viên dựa trên job_level:
--
-- Level 1 → tăng 5%
-- Level 2 → tăng 10%
-- Level 3 → tăng 15%

-- Tạo Procedure adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC) để:
-- Nhận emp_id của nhân viên
-- Cập nhật lương theo quy tắc trên
-- Trả về p_new_salary (lương mới) sau khi cập nhật

create or replace procedure adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC)
language plpgsql
as $$
declare
    level int;
begin
    select job_level into level
    from employees
    where emp_id = p_emp_id;
    select salary into p_new_salary
    from employees
    where emp_id = p_emp_id;
    if level = 1 then p_new_salary := p_new_salary *1.05;
    elsif level = 2 then p_new_salary := p_new_salary *1.1;
    else p_new_salary := p_new_salary *1.15;
    end if;
end;
$$;

call adjust_salary(3, null);
