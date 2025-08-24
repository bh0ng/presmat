# Metadata Documentation

**Database:** `mcqueen_db`  
**Last Updated:** 2025-08-23  
**Author:** Rolando Abagon Jr., Jovic Salmeron, Gretchen Contillo  

---

## Tables Overview

| Table Name           | Description                                                   |
|----------------------|---------------------------------------------------------------|
| Car                  | Stores car inventory details                                  |
| Customer             | Contains customer personal information                        |
| Employee             | Contains employee (sales staff) information                   |
| Date                 | Date dimension used for sale tracking and partitioning        |
| Sales                | Fact table storing car sale transactions (partitioned)        |
| top10_highest_sales  | Materialized view with the top 10 highest-value sales         |

---

## View: Top10 Highest Sales

| Column         | Data Type | Source Table | Description                    |
|----------------|-----------|--------------|--------------------------------|
| Sale ID        | INT       | Sales        | Unique ID of sale              |
| Date Sold      | DATE      | Date         | Date of transaction            |
| Customer Name  | VARCHAR   | Customer     | Full name                      |
| Employee Name  | VARCHAR   | Employee     | Salesperson’s full name        |
| Car Model      | VARCHAR   | Car          | Model of car sold              |
| Sale Amount    | DECIMAL   | Sales        | Value of sale                  |

> **Note:** This is a materialized view, implemented as a physical table with periodic refresh (hourly/daily).

---

## Table Structures and Descriptions

### Table: `car`

| Column Name | Data Type | Length | Nullable | Default | Key         | Description               |
|-------------|-----------|--------|----------|---------|-------------|---------------------------|
| CarID       | INT       | 3      | NO       | N/A     | Primary Key | Unique ID for the car     |
| Make        | VARCHAR   | 10     | YES      | NULL    |             | Manufacturer of the car   |
| Model       | VARCHAR   | 13     | YES      | NULL    |             | Model name of the car     |
| Year        | INT       | 4      | YES      | NULL    |             | Year the car was made     |
| Color       | VARCHAR   | 6      | YES      | NULL    |             | Color of the car          |
| MSRP        | DECIMAL   | 12,2   | YES      | NULL    |             | Manufacturer’s price      |

---

### Table: `customer`

| Column Name | Data Type | Length | Nullable | Default | Key         | Description               |
|-------------|-----------|--------|----------|---------|-------------|---------------------------|
| CustomerID  | INT       | 2      | NO       | N/A     | Primary Key | Unique ID for customer    |
| First_name  | VARCHAR   | 7      | YES      | NULL    |             | Customer's first name     |
| Last_name   | VARCHAR   | 11     | YES      | NULL    |             | Customer's last name      |
| Address     | VARCHAR   | 52     | YES      | NULL    |             | Street address            |
| City        | VARCHAR   | 11     | YES      | NULL    |             | City of residence         |
| Province    | VARCHAR   | 13     | YES      | NULL    |             | Province or state         |

---

### Table: `date`

| Column Name   | Data Type | Length | Nullable | Default | Key         | Description                         |
|---------------|-----------|--------|----------|---------|-------------|-------------------------------------|
| DateID        | INT       | 2      | NO       | N/A     | Primary Key | Unique ID for the date              |
| Full_date     | VARCHAR   | 9      | YES      | NULL    |             | Full date (e.g., 01-Jan-25)         |
| Day_of_week   | VARCHAR   | 9      | YES      | NULL    |             | Day of the week (e.g., Monday)      |
| Month         | VARCHAR   | 8      | YES      | NULL    |             | Month name (e.g., January)          |
| Year          | INT       | 4      | YES      | NULL    |             | Year (e.g., 2025)                   |
| Quarter       | VARCHAR   | 2      | YES      | NULL    |             | Quarter of the year (e.g., Q1)      |

---

### Table: `employee`

| Column Name  | Data Type | Length | Nullable | Default | Key         | Description               |
|--------------|-----------|--------|----------|---------|-------------|---------------------------|
| EmployeeID   | INT       | 4      | NO       | N/A     | Primary Key | Unique ID for employee    |
| First_name   | VARCHAR   | 7      | YES      | NULL    |             | Employee's first name     |
| Last_name    | VARCHAR   | 11     | YES      | NULL    |             | Employee's last name      |
| Position     | VARCHAR   | 15     | YES      | NULL    |             | Job title or role         |
| Hire_date    | VARCHAR   | 10     | YES      | NULL    |             | Date employee was hired   |

---

### Table: `sales`

| Column Name  | Data Type | Length | Nullable | Default | Key         | Description                         |
|--------------|-----------|--------|----------|---------|-------------|-------------------------------------|
| SaleID       | INT       | 2      | NO       | N/A     | Primary Key | Unique ID for each sale             |
| DateID       | INT       | 2      | YES      | NULL    |             | Reference to date of sale           |
| CarID        | INT       | 2      | YES      | NULL    |             | Reference to car sold               |
| CustomerID   | INT       | 2      | YES      | NULL    |             | Reference to customer who bought    |
| EmployeeID   | INT       | 4      | YES      | NULL    |             | Reference to employee who made sale |
| Sale_amount  | DEC       | 12,2   | YES      | NULL    |             | Refers to the actual sale amount    |
| Profit       | DEC       | 12,2   | YES      | NULL    |             | Refers to the profit of the sale    |
| Quantity_sold| INT       | 4      | YES      | NULL    |             | Refers to the count units sold      |

---

## Partitioning Details

| Partition Name | Condition      | Engine |
|----------------|----------------|--------|
| p1             | SaleID < 50    | InnoDB |
| p2             | SaleID < 100   | InnoDB |
| p3             | SaleID < MAXVALUE | InnoDB |

---
