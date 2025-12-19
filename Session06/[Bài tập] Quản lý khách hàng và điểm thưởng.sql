CREATE TABLE Customer
(
    id     SERIAL PRIMARY KEY,
    name   VARCHAR(100),
    email  VARCHAR(100),
    phone  VARCHAR(20),
    points INT
);

INSERT INTO Customer (name, email, phone, points)
VALUES ('Nguyễn Văn A', 'a@gmail.com', '0901234567', 100),
       ('Trần Thị B', 'b@gmail.com', '0907654321', 250),
       ('Lê Văn C', NULL, '0912345678', 50),
       ('Nguyễn Văn A', 'a2@gmail.com', '0988888888', 300),
       ('Phạm Minh D', 'd@gmail.com', '0933333333', 450),
       ('Hoàng Lan E', 'e@gmail.com', '0944444444', 120),
       ('Đỗ Hùng F', 'f@gmail.com', '0955555555', 500);

SELECT DISTINCT name
FROM Customer;

SELECT *
FROM Customer
WHERE email IS NULL;

SELECT *
FROM Customer
ORDER BY points DESC
LIMIT 3 OFFSET 1;

SELECT *
FROM Customer
ORDER BY name DESC;