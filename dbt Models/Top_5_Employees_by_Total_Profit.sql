-- Top 5 Employees by Total Profit
WITH sales AS (
    SELECT *
    FROM `exalted-kit-469102-d9.sales_table.sales`
),
employee AS (
    SELECT *
    FROM `exalted-kit-469102-d9.employee_table.employee`
)
SELECT
    e.employeeid as `Employee ID`,
    CONCAT (e.first_name, ' ', e.last_name) AS `Employee Name`,
    SUM(s.profit) AS `Total Profit`
FROM sales s
JOIN employee e ON s.employeeid = e.employeeid
GROUP BY e.employeeid, `Employee Name`
ORDER BY `Total Profit` DESC
LIMIT 5;