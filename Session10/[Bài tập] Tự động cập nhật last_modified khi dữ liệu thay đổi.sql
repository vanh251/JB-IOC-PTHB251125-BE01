-- create schema test01;
--
-- set search_path to test01;

CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          price NUMERIC(10, 2) NOT NULL,
                          last_modified TIMESTAMP
);

INSERT INTO products (name, price, last_modified)
VALUES
    ('Laptop Gaming', 25000000.00, '2025-12-16 10:30:00'),
    ('Chuột không dây', 150000.50, NOW()),
    ('Màn hình 24 inch', 3500000.00, NOW()),
    ('Tai nghe Bluetooth', 1200000.00, '2025-12-17 08:15:00'),
    ('USB 64GB', 250000.00, NOW());


-- Viết Function update_last_modified() bằng PL/pgSQL để tự động cập nhật last_modified mỗi khi bản ghi được cập nhật

create or replace function update_last_modified()
returns trigger
language plpgsql
as $$
begin
    new.last_modified = now() at time zone 'Asia/Ho_chi_minh';
    return new;
end;
$$;

-- Tạo Trigger trg_update_last_modified gắn với bảng products để gọi Function trước khi thực hiện UPDATE
create or replace trigger trg_update_last_modified
before update on products
for each row
execute function update_last_modified();

