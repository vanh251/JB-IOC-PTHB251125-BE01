
set search_path to test04;

CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          price NUMERIC,
                          discount_percent INT
);

INSERT INTO products (name, price, discount_percent)
VALUES
    ('iPhone 15 Pro Max', 34000000, 60),
    ('Samsung Galaxy S24', 25000000, 55),
    ('MacBook Air M2', 28000000, 5),
    ('Tai nghe AirPods Pro', 5500000, 0),
    ('Chuột Logitech MX Master 3', 2500000, 20);

-- Viết Procedure calculate_discount(p_id INT, OUT p_final_price NUMERIC) để:
-- Lấy price và discount_percent của sản phẩm
-- Tính giá sau giảm:
--  p_final_price = price - (price * discount_percent / 100)
-- Nếu phần trăm giảm giá > 50, thì giới hạn chỉ còn 50%
-- Cập nhật lại cột price trong bảng products thành giá sau giảm

create or replace procedure calculate_discount(p_id INT, OUT p_final_price NUMERIC)
language plpgsql
as $$
declare
    discount int ;
begin
    select price into p_final_price
    from products
    where id = p_id;
    select discount_percent into discount
    from products
    where id = p_id;
    if discount > 50 then discount := 50;
    end if;
    p_final_price := p_final_price * (100-discount)/100;
    update products
    set price = p_final_price
    where id=p_id;
end;
$$;

call calculate_discount(1, null);
