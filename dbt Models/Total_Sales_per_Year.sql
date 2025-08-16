WITH sales AS (
    SELECT *
    FROM `exalted-kit-469102-d9.sales_table.sales`
),
date_dim AS (
    SELECT *
    FROM `exalted-kit-469102-d9.date_table.date`
)
SELECT
    d.year as `Year`,
    SUM(s.sale_amount) AS `Total Sales`,
    SUM(s.profit) AS `Total Profit`
FROM sales s
JOIN date_dim d ON s.dateid = d.dateid
GROUP BY d.year
ORDER BY d.year;