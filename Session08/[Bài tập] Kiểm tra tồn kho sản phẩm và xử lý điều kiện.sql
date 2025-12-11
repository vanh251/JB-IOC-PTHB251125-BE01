set search_path to test02;

CREATE TABLE inventory (
                           product_id SERIAL PRIMARY KEY,
                           product_name VARCHAR(100),
                           quantity INT
);

INSERT INTO inventory (product_name, quantity)
VALUES
    ('Chuột Logitech', 50),
    ('Bàn phím cơ', 30),
    ('Màn hình LG 24 inch', 10),
    ('Tai nghe Sony', 25);

-- Viết một Procedure có tên check_stock(p_id INT, p_qty INT) để:
-- Kiểm tra xem sản phẩm có đủ hàng không
-- Nếu quantity < p_qty, in ra thông báo lỗi bằng RAISE EXCEPTION ‘Không đủ hàng trong kho’
-- Gọi Procedure với các trường hợp:
-- Một sản phẩm có đủ hàng
-- Một sản phẩm không đủ hàng

create or replace procedure check_stock(p_id INT, p_qty INT)
language plpgsql
as $$
    declare
        qty int ;
    begin
        select quantity into qty
        from inventory
        where product_id = p_id;
        if p_qty > qty then raise exception 'Không đủ hàng trong kho';
        else raise exception 'Đủ hàng trong kho';
        end if;
    end;
$$;

call check_stock(1, 10);
call check_stock(3, 20);