-- Total Sales and Profit by Month
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
    d.month as `Month`,
    SUM(s.sale_amount) AS `Total Sales`,
    SUM(s.profit) AS `Total Profit`
FROM sales s
JOIN date_dim d ON s.dateid = d.dateid
GROUP BY d.year, d.month
ORDER BY d.year,
CASE d.month
      WHEN 'January' THEN 1
      WHEN 'February' THEN 2
      WHEN 'March' THEN 3
      WHEN 'April' THEN 4
      WHEN 'May' THEN 5
      WHEN 'June' THEN 6
      WHEN 'July' THEN 7
      WHEN 'August' THEN 8
      WHEN 'September' THEN 9
      WHEN 'October' THEN 10
      WHEN 'November' THEN 11
      WHEN 'December' THEN 12
  END;