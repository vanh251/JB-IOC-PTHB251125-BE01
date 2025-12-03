-- create schema test04;

set search_path to test04;

CREATE TABLE products
(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(100),
    category     VARCHAR(50),
    price        DECIMAL(15, 0),
    stock        INT,
    manufacturer VARCHAR(50)
);

INSERT INTO products (id, name, category, price, stock, manufacturer)
VALUES (1, 'Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
       (2, 'Chuột Logitech M90', 'Phụ kiện', 150000, 50, 'Logitech'),
       (3, 'Bàn phím cơ Razer', 'Phụ kiện', 2200000, 0, 'Razer'),
       (4, 'Macbook Air M2', 'Laptop', 32000000, 7, 'Apple'),
       (5, 'iPhone 14 Pro Max', 'Điện thoại', 35000000, 15, 'Apple'),
       (6, 'Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
       (7, 'Tai nghe AirPods 3', 'Phụ kiện', 4500000, NULL, 'Apple');

-- Yêu cầu: Thực hiện các yêu cầu sau bằng SQL
--
-- Chèn dữ liệu mới:
-- Thêm sản phẩm “Chuột không dây Logitech M170”, loại Phụ kiện, giá 300000, tồn kho 20, hãng Logitech
insert into products ( id,name, category, price, stock, manufacturer)
values (8,'Chuột không dây Logitech M170', 'Phụ kiện', 30000, 20, 'Logitech');

-- Cập nhật dữ liệu:
-- Tăng giá tất cả sản phẩm của Apple thêm 10%
update products
set price=price*1.1
where manufacturer ilike 'Apple';

-- Xóa dữ liệu:
-- Xóa sản phẩm có stock = 0
delete from products
where stock=0;

-- Lọc theo điều kiện:
-- Hiển thị sản phẩm có price BETWEEN 1000000 AND 30000000
select * from products
where price between 1000000 and 30000000;

-- Lọc giá trị NULL:
-- Hiển thị sản phẩm có stock IS NULL
select * from products
where stock is null;

-- Loại bỏ trùng:
-- Liệt kê danh sách hãng sản xuất duy nhất
select distinct products.manufacturer
from products;

-- Sắp xếp dữ liệu
-- Hiển thị toàn bộ sản phẩm, sắp xếp giảm dần theo giá, sau đó tăng dần theo tên
select * from products
order by price desc , name;
-- Tìm kiếm (LIKE và ILIKE):
-- Tìm sản phẩm có tên chứa từ “laptop” (không phân biệt hoa thường)
select * from products
where name ilike '%laptop%';

-- Giới hạn kết quả:
-- Chỉ hiển thị 2 sản phẩm đầu tiên sau khi sắp xếp
select *
from products
order by price desc , name
limit 2;