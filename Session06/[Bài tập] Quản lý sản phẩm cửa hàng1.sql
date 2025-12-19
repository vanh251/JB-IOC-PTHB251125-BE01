-- create schema test01;
-- set search_path to test01;

CREATE TABLE Product
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(100),
    category VARCHAR(50),
    price    NUMERIC(10, 2),
    stock    INT
);

INSERT INTO Product (name, category, price, stock)
VALUES ('Laptop Gaming Dell', 'Điện tử', 25000000, 10),
       ('iPhone 15 Pro', 'Điện tử', 30000000, 50),
       ('Chuột Logitech', 'Phụ kiện', 500000, 100),
       ('Bàn phím cơ', 'Điện tử', 1500000, 30),
       ('Áo thun Dev', 'Thời trang', 200000, 200);

SELECT *
FROM Product;

SELECT *
FROM Product
ORDER BY price DESC
LIMIT 3;

SELECT *
FROM Product
WHERE category = 'Điện tử'
  AND price < 10000000;

SELECT *
FROM Product
ORDER BY stock ASC;