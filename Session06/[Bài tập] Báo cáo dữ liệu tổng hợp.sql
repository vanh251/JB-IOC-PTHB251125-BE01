CREATE TABLE OldCustomers
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE NewCustomers
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

SELECT name, city
FROM OldCustomers
UNION
SELECT name, city
FROM NewCustomers;

SELECT name, city
FROM OldCustomers
INTERSECT
SELECT name, city
FROM NewCustomers;

SELECT city, COUNT(*) AS customer_count
FROM (SELECT name, city
      FROM OldCustomers
      UNION ALL
      SELECT name, city
      FROM NewCustomers) AS all_customers
GROUP BY city;

SELECT city
FROM (SELECT city, COUNT(*) as count
      FROM (SELECT city FROM OldCustomers UNION ALL SELECT city FROM NewCustomers) as t
      GROUP BY city) as sub
WHERE count = (SELECT MAX(count)
               FROM (SELECT COUNT(*) as count
                     FROM (SELECT city FROM OldCustomers UNION ALL SELECT city FROM NewCustomers) as t2
                     GROUP BY city) as sub2);
