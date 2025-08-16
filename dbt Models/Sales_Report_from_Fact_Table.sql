-- Sales Report from Fact Table
SELECT
    d.Year,
    d.Month,
    CONCAT(e.first_name, ' ', e.last_name) AS `Employee Name`,
    CONCAT(cu.first_name, ' ', cu.last_name) AS `Customer Name`,
    car.model AS `Car Model`,
    SUM(s.sale_amount) AS `Total Sales`,
    SUM(s.profit) AS `Total Profit`
FROM `exalted-kit-469102-d9.sales_table.sales` s
JOIN `exalted-kit-469102-d9.date_table.date` d 
    ON s.dateid = d.DateID
JOIN `exalted-kit-469102-d9.customer_table.customer` cu 
    ON s.customerid = cu.customerid
JOIN `exalted-kit-469102-d9.employee_table.employee` e 
    ON s.employeeid = e.employeeid
JOIN `exalted-kit-469102-d9.car_table.car` car 
    ON s.carid = car.carid
GROUP BY d.Year, d.Month, `Employee Name`, `Customer Name`, `Car Model`
ORDER BY d.Year, 
  CASE d.Month
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