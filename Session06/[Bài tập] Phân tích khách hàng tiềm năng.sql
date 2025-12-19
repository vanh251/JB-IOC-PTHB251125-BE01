CREATE TABLE Orders
(
    id           SERIAL PRIMARY KEY,
    customer_id  INT,
    order_date   DATE,
    total_amount NUMERIC(10, 2)
);

CREATE TABLE Customer
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

SELECT c.name, SUM(o.total_amount) AS total_spent
FROM Customer c
         LEFT JOIN Orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;

SELECT c.name
FROM Customer c
         JOIN Orders o ON c.id = o.customer_id
GROUP BY c.name
HAVING SUM(o.total_amount) = (SELECT MAX(total_per_user)
                              FROM (SELECT SUM(total_amount) AS total_per_user
                                    FROM Orders
                                    GROUP BY customer_id) AS sub);

SELECT c.name
FROM Customer c
         LEFT JOIN Orders o ON c.id = o.customer_id
WHERE o.id IS NULL;

SELECT c.name, SUM(o.total_amount) AS total_spent
FROM Customer c
         JOIN Orders o ON c.id = o.customer_id
GROUP BY c.name
HAVING SUM(o.total_amount) > (SELECT AVG(total_per_user)
                              FROM (SELECT SUM(total_amount) AS total_per_user
                                    FROM Orders
                                    GROUP BY customer_id) AS sub);