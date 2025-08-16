-- Most Popular Car Models Sold
WITH sales AS (
    SELECT *
    FROM `exalted-kit-469102-d9.sales_table.sales`
),
car AS (
    SELECT *
    FROM `exalted-kit-469102-d9.car_table.car`
)
SELECT
    car.model as `Car Model`,
    COUNT(s.saleid) AS `Total Units Sold`,
    SUM(s.sale_amount) AS `Total Revenue`
FROM sales s
JOIN car ON s.carid = car.carid
GROUP BY car.model
ORDER BY `Total Units Sold` DESC
LIMIT 10;