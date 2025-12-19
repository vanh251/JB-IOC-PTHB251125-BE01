-- create database test09;
--
CREATE TABLE Orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT,
                        order_date DATE,
                        total_amount DECIMAL(10, 2)
);

INSERT INTO Orders (customer_id, order_date, total_amount)
SELECT
    (random() * 10000)::INT,
    CURRENT_DATE - (random() * 365)::INT,
    (random() * 1000)::DECIMAL(10, 2)
FROM generate_series(1, 200000);

EXPLAIN ANALYZE SELECT * FROM Orders WHERE customer_id = 500;

CREATE INDEX idx_orders_customer_id ON Orders(customer_id);

EXPLAIN ANALYZE SELECT * FROM Orders WHERE customer_id = 500;

/*
    === BÁO CÁO KẾT QUẢ SO SÁNH ===

    1. Trước khi tạo Index:
       - Cơ chế: Hệ thống sử dụng "Seq Scan" (quét tuần tự toàn bộ bảng).
       - Hiệu suất: Chậm, phải đọc toàn bộ dữ liệu để tìm kiếm, thời gian thực thi cao khi dữ liệu lớn.

    2. Sau khi tạo Index B-Tree:
       - Cơ chế: Hệ thống chuyển sang sử dụng "Index Scan" hoặc "Bitmap Heap Scan".
       - Hiệu suất: Tốc độ truy vấn tăng đột biến do hệ thống tìm trực tiếp vị trí bản ghi thông qua cấu trúc cây B-Tree thay vì quét toàn bộ bảng.

    => Kết luận: B-Tree Index là giải pháp tối ưu cho các truy vấn tìm kiếm chính xác trên cột có dữ liệu lớn như customer_id.
*/