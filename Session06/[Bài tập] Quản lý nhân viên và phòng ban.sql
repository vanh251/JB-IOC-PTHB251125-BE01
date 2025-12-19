CREATE TABLE Department
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Employee
(
    id            SERIAL PRIMARY KEY,
    full_name     VARCHAR(100),
    department_id INT,
    salary        NUMERIC(10, 2)
);

SELECT e.full_name, d.name AS department_name
FROM Employee e
         INNER JOIN Department d ON e.department_id = d.id;

SELECT d.name        AS department_name,
       AVG(e.salary) AS avg_salary
FROM Department d
         INNER JOIN Employee e ON d.id = e.department_id
GROUP BY d.name;

SELECT d.name        AS department_name,
       AVG(e.salary) AS avg_salary
FROM Department d
         INNER JOIN Employee e ON d.id = e.department_id
GROUP BY d.name
HAVING AVG(e.salary) > 10000000;

SELECT d.name
FROM Department d
         LEFT JOIN Employee e ON d.id = e.department_id
WHERE e.id IS NULL;