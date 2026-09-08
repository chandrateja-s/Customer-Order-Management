# Data Model

## Overview

The Customer Order Management project uses a relational database designed to manage Customers, Products, Orders and Order Items.

The database consists of four main tables:

- `Customers`
- `Products`
- `Orders`
- `OrderItems`

The model follows a normalized relational structure, with primary and foreign keys used to maintain referential integrity.

---

## Entity Relationship Overview

```text
Customers
    |
    | 1
    |
    | N
  Orders
    |
    | 1
    |
    | N
OrderItems
    |
    | N
    |
    | 1
Products
 ```

 ## 1. Customers

Stores information about customers.

| Column | Data Type | Description |
|---|---|---|
| CustomerID | INT | Primary key; uniquely identifies each customer |
| FirstName | NVARCHAR(50) | Customer's first name |
| LastName | NVARCHAR(50) | Customer's last name |
| Email | NVARCHAR(100) | Customer's email address |
| City | NVARCHAR(50) | Customer's city |

**Primary Key:** `CustomerID`

## 2. Products

Stores information about products available for sale.

| Column | Data Type | Description |
|---|---|---|
| ProductID | INT | Primary key; uniquely identifies each product |
| ProductName | NVARCHAR(100) | Name of the product |
| Category | NVARCHAR(50) | Product category |
| Price | DECIMAL(10,2) | Product price |
| StockQuantity | INT | Current stock quantity |

**Primary Key:** `ProductID`

## 3. Orders

Stores customer order information.

| Column | Data Type | Description |
|---|---|---|
| OrderID | INT | Primary key; uniquely identifies each order |
| CustomerID | INT | Foreign key referencing `Customers` |
| OrderDate | DATE | Date the order was placed |
| Status | NVARCHAR(20) | Current order status |

**Primary Key:** `OrderID`

**Foreign Key:** `CustomerID -> Customers(CustomerID)`

Order statuses used in the dataset:

- Completed
- Shipped
- Processing
- Pending

## 4. OrderItems

Stores the individual products included in each order.

| Column | Data Type | Description |
|---|---|---|
| OrderItemID | INT | Primary key; uniquely identifies each order item |
| OrderID | INT | Foreign key referencing `Orders` |
| ProductID | INT | Foreign key referencing `Products` |
| Quantity | INT | Number of units ordered |
| UnitPrice | DECIMAL(10,2) | Price of the product at the time of the order |

**Primary Key:** `OrderItemID`

**Foreign Keys:**

- `OrderID -> Orders(OrderID)`
- `ProductID -> Products(ProductID)`

## Relationships

### Customers -> Orders

**One-to-Many**

One customer can place multiple orders, while each order belongs to one customer.

```text
Customers (1) ------< Orders (N)
 ```

### Orders -> OrderItems

**One-to-Many**

One order can contain multiple order items, while each order item belongs to one order.

```text
Orders (1) ------< OrderItems (N)
```

### Products -> OrderItems

**One-to-Many**

One product can appear in multiple order items, while each order item references one product.

```text
Products (1) ------< OrderItems (N)
```

## Design Considerations

The database separates customers, products, orders, and order items into independent entities rather than storing all information in a single table.

This structure:

- Reduces data duplication
- Improves data consistency
- Makes relationships explicit through foreign keys
- Supports analytical queries across multiple entities
- Provides a suitable foundation for Power BI reporting

## Analytical Layer

The database also contains reusable SQL objects built on top of the base tables.

### Views

- `vw_CustomerOrderSummary`
- `vw_OrderStatusSummary`
- `vw_ProductSalesSummary`

### Stored Procedures

- `sp_GetCustomerOrders`
- `sp_GetOrdersByStatus`
- `sp_GetCustomerSummary`

These objects provide reusable analytical logic and demonstrate SQL development beyond basic querying.