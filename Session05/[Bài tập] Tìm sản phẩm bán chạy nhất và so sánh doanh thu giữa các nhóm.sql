set search_path to test01;

-- Viết truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders
-- Hiển thị: product_name, total_revenue

select p.product_name, sum(o.total_price) as total_revenue
from products as p
         join orders as o
              on p.product_id = o.product_id
group by p.product_name
having sum(o.total_price) =
       (select sum(total_price)
        from orders
        group by product_id
        order by sum(total_price) desc
        limit 1)
;

-- Viết truy vấn hiển thị tổng doanh thu theo từng nhóm category (dùng JOIN + GROUP BY)
select p.category, count(p.product_id) as total_quantity, sum(o.total_price) as total_sale
from products as p
         join orders as o
              on p.product_id = o.product_id
group by (category)
order by total_sale desc;

-- Dùng INTERSECT để tìm ra nhóm category có sản phẩm bán chạy nhất (ở câu 1) cũng nằm trong danh sách nhóm có tổng doanh thu lớn hơn 3000
select category
from products
where product_name in
      (select p.product_name
       from products as p
                join orders as o
                     on p.product_id = o.product_id
       group by p.product_name
       having sum(o.total_price) =
              (select sum(total_price)
               from orders
               group by product_id
               order by sum(total_price) desc
               limit 1))
intersect
select category
from products as p
         join orders as o
              on p.product_id = o.product_id
group by category
having sum(o.total_price) > 3000;