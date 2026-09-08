# Customer Order Management & Sales Analysis

## Overview

This project demonstrates a complete **Customer Order Management and Sales Analysis** solution using **SQL Server and Power BI**.

The project covers relational database design, SQL analysis, reusable database objects, data validation, and interactive business reporting.

The goal is to transform customer and order data into meaningful business insights that can support sales and operational decision-making.

---

## Business Objectives

The project focuses on answering questions such as:

* How much revenue has been generated?
* How many orders have been placed?
* Which products generate the most revenue?
* Which customers contribute the most revenue?
* How are orders distributed across different statuses?
* What is the average order value?
* Which products and customers are most important to the business?

---

## Technology Stack

* **SQL Server** - Database development and data analysis
* **T-SQL** - Queries, aggregations, CTEs, window functions, views and stored procedures
* **Power BI** - Interactive dashboard and data visualization
* **Git / GitHub** - Version control and project documentation

---

## Database Design

The database consists of four main tables:

```text
Customers
    |
    | 1:N
    v
Orders
    |
    | 1:N
    v
OrderItems
    ^
    | N:1
    |
Products
```

### Main Entities

* **Customers** - Customer information
* **Products** - Product and inventory information
* **Orders** - Customer orders and order status
* **OrderItems** - Products and quantities included in each order

Primary keys and foreign keys are used to maintain relationships and referential integrity.

More details are available in:

`docs/Data_Model.md`

---

## SQL Analysis

The project includes several analytical queries covering:

### Order Analysis

* Order totals
* Detailed order summaries
* Orders by status
* Order value by status

### Customer Analysis

* Total orders per customer
* Total customer spending
* Average order value
* Customer ranking using `RANK()`

### Product Analysis

* Quantity sold by product
* Revenue by product
* Product performance ranking

### SQL Techniques Demonstrated

* `JOIN`
* `GROUP BY`
* Aggregate functions
* `CASE`
* `STRING_AGG`
* Common Table Expressions (CTEs)
* Window functions
* Subqueries
* Conditional ordering

---

## Reusable SQL Objects

The project also includes reusable database objects.

### Views

* `vw_CustomerOrderSummary`
* `vw_OrderStatusSummary`
* `vw_ProductSalesSummary`

### Stored Procedures

* `sp_GetCustomerOrders`
* `sp_GetOrdersByStatus`
* `sp_GetCustomerSummary`

These objects demonstrate how analytical logic can be encapsulated and reused within a SQL Server database.

---

## Data Validation

Data quality checks were performed before building the dashboard.

The validation process checks for:

* Duplicate records
* Orphan orders
* Orphan order items
* Invalid quantities
* Negative prices
* NULL values
* Order status distribution

All validation checks passed successfully for the project dataset.

The validation queries are available in:

`sql/05_Data_Validation.sql`

---

## Power BI Dashboard

The SQL Server data was connected to Power BI to create an interactive sales and order analysis dashboard.

### Dashboard Features

* Total Orders KPI
* Total Revenue KPI
* Customer analysis
* Product revenue analysis
* Order status analysis
* Top 5 products by revenue
* Interactive filtering and cross-visual interactions

The dashboard allows users to explore sales performance from different perspectives.

---

## Key Business Metrics

The dashboard focuses on metrics including:

| Metric              | Description                                        |
| ------------------- | -------------------------------------------------- |
| Total Orders        | Number of unique orders                            |
| Total Revenue       | Revenue generated from order items                 |
| Total Spent         | Revenue contributed by individual customers        |
| Average Order Value | Average value of customer orders                   |
| Quantity Sold       | Number of product units sold                       |
| Order Status        | Distribution of orders across operational statuses |

---

## Project Structure

```text
Customer-Order-Management/
|
|-- .gitignore
|
|-- docs/
|   |-- Data_Model.md
|
|-- powerbi/
|   |-- CustomerOrderManagement.pbix
|
|-- screenshots/
|
|-- sql/
|   |-- 01_Database_and_Tables.sql
|   |-- 02_Analysis_Queries.sql
|   |-- 03_Views.sql
|   |-- 04_Stored_Procedures.sql
|   |-- 05_Data_Validation.sql
|
|-- README.md
```

---

## Project Workflow

```text
SQL Server Database
        |
        v
Data Validation
        |
        v
SQL Analysis
        |
        v
Views & Stored Procedures
        |
        v
Power BI Data Model
        |
        v
Interactive Dashboard
```

---

## Project Highlights

This project demonstrates practical experience with:

* Relational database design
* SQL Server and T-SQL
* Multi-table data analysis
* Data validation and quality checks
* SQL views and stored procedures
* CTEs and window functions
* Business KPI development
* Power BI dashboard development
* Git and GitHub project management

---

## Future Improvements

Possible future enhancements include:

* Adding a dedicated Date dimension
* Adding additional sales and profitability metrics
* Expanding the product and customer analysis
* Adding time-based sales trends
* Deploying and sharing the report through Power BI Service

---

## Author

**Chandra Teja Sakkurthi**

Aspiring Data Analyst with experience in SQL, Power BI and data analysis.

This project was developed as part of a practical data analytics portfolio.
