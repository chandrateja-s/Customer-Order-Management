USE CustomerOrderManagement;
GO

-- =============================================
-- 1. Customer Order Summary
-- Provides order count, total spending and
-- average order value for each customer
-- =============================================

CREATE VIEW vw_CustomerOrderSummary
AS
SELECT
    c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent,
    AVG(OrderTotals.OrderTotal) AS AvgOrderValue
FROM Customers c
JOIN Orders o
    ON o.CustomerID = c.CustomerID
JOIN OrderItems oi
    ON oi.OrderID = o.OrderID
JOIN
(
    SELECT
        OrderID,
        SUM(Quantity * UnitPrice) AS OrderTotal
    FROM OrderItems
    GROUP BY OrderID
) AS OrderTotals
    ON OrderTotals.OrderID = o.OrderID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName;
GO


-- =============================================
-- 2. Order Status Summary
-- Provides order count and total order value
-- for each status
-- =============================================

CREATE VIEW vw_OrderStatusSummary
AS
SELECT
    o.Status,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalOrderValue
FROM Orders o
JOIN OrderItems oi
    ON oi.OrderID = o.OrderID
GROUP BY
    o.Status;
GO


-- =============================================
-- 3. Product Sales Summary
-- Provides quantity sold and revenue by product
-- =============================================

CREATE VIEW vw_ProductSalesSummary
AS
SELECT
    p.ProductID,
    p.ProductName,
    SUM(oi.Quantity) AS TotalQuantitySold,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM Products p
JOIN OrderItems oi
    ON oi.ProductID = p.ProductID
GROUP BY
    p.ProductID,
    p.ProductName;
GO