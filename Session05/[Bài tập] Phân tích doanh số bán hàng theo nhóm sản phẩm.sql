-- create database session05;
--
-- create schema test01;
--
set search_path to test01;

-- Tạo bảng products
CREATE TABLE products
(
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(100),
    category     VARCHAR(50)
);

-- Thêm dữ liệu vào bảng products
INSERT INTO products (product_id, product_name, category)
VALUES (1, 'Laptop Dell', 'Electronics'),
       (2, 'iPhone 15', 'Electronics'),
       (3, 'Bàn học gỗ', 'Furniture'),
       (4, 'Ghế xoay', 'Furniture');

-- Tạo bảng orders
CREATE TABLE orders
(
    order_id    INT PRIMARY KEY,
    product_id  INT,
    quantity    INT,
    total_price DECIMAL(15, 2), -- Dùng Decimal để lưu tiền tệ chính xác
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

-- Thêm dữ liệu vào bảng orders
INSERT INTO orders (order_id, product_id, quantity, total_price)
VALUES (101, 1, 2, 2200),
       (102, 2, 3, 3300),
       (103, 3, 5, 2500),
       (104, 4, 4, 1600),
       (105, 1, 1, 1100);

-- Viết truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được (SUM(quantity)) cho từng nhóm danh mục (category)
-- Đặt bí danh cột như sau:
-- total_sales cho tổng doanh thu
-- total_quantity cho tổng số lượng
-- Chỉ hiển thị những nhóm có tổng doanh thu lớn hơn 2000
-- Sắp xếp kết quả theo tổng doanh thu giảm dần

select p.category, count(p.product_id) as total_quantity, sum(o.total_price) as total_sale
from products as p
join orders as o
on p.product_id=o.product_id
group by (category)
having sum(o.total_price)>2000
order by total_sale desc ;

