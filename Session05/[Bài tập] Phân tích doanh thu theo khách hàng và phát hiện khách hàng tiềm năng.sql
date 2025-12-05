-- create schema test02;

set search_path to test02;

-- Tạo bảng customers
CREATE TABLE customers
(
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city          VARCHAR(50)
);

-- Thêm dữ liệu customers
INSERT INTO customers (customer_id, customer_name, city)
VALUES (1, 'Nguyễn Văn A', 'Hà Nội'),
       (2, 'Trần Thị B', 'Đà Nẵng'),
       (3, 'Lê Văn C', 'Hồ Chí Minh'),
       (4, 'Phạm Thị D', 'Hà Nội');

-- Tạo bảng orders
CREATE TABLE orders
(
    order_id    INT PRIMARY KEY,
    customer_id INT,
    order_date  DATE, -- Định dạng Năm-Tháng-Ngày
    total_price DECIMAL(15, 2),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

-- Thêm dữ liệu orders
INSERT INTO orders (order_id, customer_id, order_date, total_price)
VALUES (101, 1, '2024-12-20', 3000),
       (102, 2, '2025-01-05', 1500),
       (103, 1, '2025-02-10', 2500),
       (104, 3, '2025-02-15', 4000),
       (105, 4, '2025-03-01', 800);

-- Tạo bảng order_items
CREATE TABLE order_items
(
    item_id    INT PRIMARY KEY,
    order_id   INT,
    product_id INT,
    quantity   INT,
    price      DECIMAL(15, 2),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
    -- FOREIGN KEY (product_id) REFERENCES products(product_id) -- Bỏ comment dòng này nếu bảng products đã tồn tại
);

-- Thêm dữ liệu order_items
INSERT INTO order_items (item_id, order_id, product_id, quantity, price)
VALUES (1, 101, 1, 2, 1500),
       (2, 102, 2, 1, 1500),
       (3, 103, 3, 5, 500),
       (4, 104, 2, 4, 1000);

-- Viết truy vấn hiển thị tổng doanh thu và tổng số đơn hàng của mỗi khách hàng:
-- Chỉ hiển thị khách hàng có tổng doanh thu > 2000
-- Dùng ALIAS: total_revenue và order_count
select c.customer_name, sum(o.total_price) as total_revenue , count(o.order_id) as order_count
from customers c
join orders o on c.customer_id = o.customer_id
group by o.customer_id, c.customer_name
having sum(o.total_price) > 2000;


-- Viết truy vấn con (Subquery) để tìm doanh thu trung bình của tất cả khách hàng
-- Sau đó hiển thị những khách hàng có doanh thu lớn hơn mức trung bình đó
select c.*, sum(o.total_price) as total_revenue
from customers c
         join orders o on c.customer_id = o.customer_id
group by c.customer_name, c.customer_id
having sum(o.total_price) > (select avg(total_price)
                             from orders)
;

-- Dùng HAVING + GROUP BY để lọc ra thành phố có tổng doanh thu cao nhất
select c.city, sum(o.total_price) as total_revenue
from customers c
join orders o on c.customer_id = o.customer_id
group by c.city
order by sum(o.total_price) desc
limit 1;
-- (Mở rộng) Hãy dùng INNER JOIN giữa customers, orders, order_items để hiển thị chi tiết:
-- Tên khách hàng, tên thành phố, tổng sản phẩm đã mua, tổng chi tiêu

select c.customer_name, c.city, sum(oi.quantity) as "tong san pham da mua", sum(o.total_price) as "tong chi tieu"
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_id;

