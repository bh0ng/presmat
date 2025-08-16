-- top 10 Highest Sales
WITH sales AS (
    SELECT *
    FROM `exalted-kit-469102-d9.sales_table.sales`
),
employee AS (
    SELECT *
    FROM `exalted-kit-469102-d9.employee_table.employee`
),
customer AS (
    SELECT *
    FROM `exalted-kit-469102-d9.customer_table.customer`
),
car AS (
    SELECT *
    FROM `exalted-kit-469102-d9.car_table.car`
),
date_dim AS (
    SELECT *
    FROM `exalted-kit-469102-d9.date_table.date`
)

SELECT
    s.saleid as `Sale ID`,
    d.full_date as `Date Sold`,
    CONCAT (c.first_name, ' ' ,c.last_name) as `Customer Name`,
    CONCAT (e.first_name, ' ' ,e.last_name) as `Employee Name`,
    car.model as `Car Model`,
    s.profit as `Profit`
FROM sales s
LEFT JOIN customer c ON s.customerid = c.customerid
LEFT JOIN employee e ON s.employeeid = e.employeeid
LEFT JOIN car ON s.carid = car.carid
LEFT JOIN date_dim d ON s.dateid = d.dateid
order by s.profit desc
LIMIT 10
