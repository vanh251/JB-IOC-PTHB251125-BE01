-- create schema test02;
--
-- set search_path to test02;

CREATE TABLE customers
(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    credit_limit NUMERIC(10, 2)
);

CREATE TABLE orders
(
    id           SERIAL PRIMARY KEY,
    customer_id  INTEGER REFERENCES customers (id),
    order_amount NUMERIC(10, 2) NOT NULL
);

INSERT INTO customers (name, credit_limit)
VALUES
    ('Nguyễn Văn A', 10000000.00),
    ('Trần Thị B', 5000000.00),
    ('Lê Văn C', 20000000.00);

INSERT INTO orders (customer_id, order_amount)
VALUES
    (1, 500000.00),
    (1, 1200000.00),
    (2, 200000.00),
    (3, 15000000.00);

-- Viết Function check_credit_limit() để kiểm tra tổng giá trị đơn hàng của khách hàng trước khi insert đơn mới. Nếu vượt hạn mức, raise exception

create or replace function check_credit_limit()
returns trigger
as $$
    declare
    total_amount numeric ;
    limit_cre numeric;
    begin
        select coalesce( sum (order_amount), 0) into total_amount
        from orders
        where orders.customer_id=new.customer_id;

        select credit_limit into limit_cre
        from customers
        where id = new.customer_id;

        if (new.order_amount + total_amount) > limit_cre
        then raise exception 'Giao dịch thất bại';
        end if;
        return new;
    end;
$$ language plpgsql;

-- Tạo Trigger trg_check_credit gắn với bảng orders để gọi Function trước khi insert
create or replace trigger trg_check_credit
before insert on orders
for each row
execute function check_credit_limit();
