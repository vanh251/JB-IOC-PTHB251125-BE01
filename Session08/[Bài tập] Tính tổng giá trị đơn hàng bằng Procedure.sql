set search_path to test01;

CREATE TABLE order_detail (
                              id SERIAL PRIMARY KEY,
                              order_id INT,
                              product_name VARCHAR(100),
                              quantity INT,
                              unit_price NUMERIC
);

INSERT INTO order_detail (order_id, product_name, quantity, unit_price)
VALUES
    (101, 'Laptop Dell XPS 13', 1, 25000000),
    (101, 'Chuột Logitech M90', 2, 150000),
    (102, 'iPhone 14 Pro Max', 1, 35000000),
    (103, 'Bàn phím cơ Razer', 5, 2200000),
    (104, 'Macbook Air M2', 2, 32000000);

-- Viết một Stored Procedure có tên calculate_order_total(order_id_input INT, OUT total NUMERIC)
-- Tham số order_id_input: mã đơn hàng cần tính
-- Tham số total: tổng giá trị đơn hàng
-- Trong Procedure:
-- Viết câu lệnh tính tổng tiền theo order_id
-- Gọi Procedure để kiểm tra hoạt động với một order_id cụ thể

create or replace procedure calculate_order_total(order_id_input INT, OUT total NUMERIC)
language plpgsql
as $$
    begin
        select sum(quantity * unit_price)
        into total
        from order_detail
        where order_id=order_id_input;
        raise notice 'tong gia tri don hang: %', total;
    end;
$$;

-- Gọi đúng tên procedure bạn vừa tạo ở trên
CALL calculate_order_total(101, NULL);