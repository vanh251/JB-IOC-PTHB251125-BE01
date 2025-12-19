CREATE TABLE Orders (
                        id SERIAL PRIMARY KEY,
                        customer_id INT,
                        order_date DATE,
                        total_amount NUMERIC(10,2)
);

INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
                                                               (1, '2023-05-10', 15000000),
                                                               (2, '2023-11-20', 40000000),
                                                               (1, '2024-01-15', 500000),
                                                               (3, '2024-06-20', 60000000),
                                                               (2, '2024-12-01', 2500000),
                                                               (4, '2025-02-14', 1200000);

SELECT
    SUM(total_amount) AS total_revenue,
    COUNT(id) AS total_orders,
    AVG(total_amount) AS average_order_value
FROM Orders;

SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    SUM(total_amount) AS annual_revenue
FROM Orders
GROUP BY EXTRACT(YEAR FROM order_date);

SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    SUM(total_amount) AS annual_revenue
FROM Orders
GROUP BY EXTRACT(YEAR FROM order_date);

SELECT * FROM Orders
ORDER BY total_amount DESC
LIMIT 5;