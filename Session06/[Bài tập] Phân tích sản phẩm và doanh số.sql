CREATE TABLE Product
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(100),
    category VARCHAR(50),
    price    NUMERIC(10, 2)
);

CREATE TABLE OrderDetail
(
    id         SERIAL PRIMARY KEY,
    order_id   INT,
    product_id INT,
    quantity   INT
);

SELECT p.name AS product_name, SUM(p.price * od.quantity) AS total_sales
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.name;

SELECT p.category, AVG(p.price * od.quantity) AS avg_category_revenue
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.category;

SELECT p.category, AVG(p.price * od.quantity) AS avg_category_revenue
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.category
HAVING AVG(p.price * od.quantity) > 20000000;

SELECT p.name
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.name
HAVING SUM(p.price * od.quantity) > (SELECT AVG(item_total)
                                     FROM (SELECT SUM(p2.price * od2.quantity) AS item_total
                                           FROM Product p2
                                                    JOIN OrderDetail od2 ON p2.id = od2.product_id
                                           GROUP BY p2.id) AS sub);

SELECT p.name
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.name
HAVING SUM(p.price * od.quantity) > (SELECT AVG(item_total)
                                     FROM (SELECT SUM(p2.price * od2.quantity) AS item_total
                                           FROM Product p2
                                                    JOIN OrderDetail od2 ON p2.id = od2.product_id
                                           GROUP BY p2.id) AS sub);