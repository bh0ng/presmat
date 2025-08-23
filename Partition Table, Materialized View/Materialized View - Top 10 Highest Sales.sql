CREATE VIEW top10_highest_sales AS
SELECT
    s.saleid AS `Sale ID`,
    d.full_date AS `Date Sold`,
    CONCAT(c.first_name, ' ', c.last_name) AS `Customer Name`,
    CONCAT(e.first_name, ' ', e.last_name) AS `Employee Name`,
    car.model AS `Car Model`,
    s.sale_amount AS `Sale Amount`
FROM sales s
LEFT JOIN customer c ON s.customerid = c.customerid
LEFT JOIN employee e ON s.employeeid = e.employeeid
LEFT JOIN car ON s.carid = car.carid
LEFT JOIN date d ON s.dateid = d.dateid
ORDER BY s.sale_amount DESC
LIMIT 10;