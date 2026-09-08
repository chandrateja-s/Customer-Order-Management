USE CustomerOrderManagement;
GO

-- =============================================
-- 1. Order Totals
-- Calculate the total value of each order
-- =============================================

SELECT
    OrderID,
    SUM(Quantity * UnitPrice) AS OrderTotal
FROM OrderItems
GROUP BY OrderID
ORDER BY OrderID;
GO


-- =============================================
-- 2. Detailed Order Summary
-- Combine customer, order, product and revenue data
-- =============================================

SELECT 
    o.OrderID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    o.OrderDate,
    SUM(oi.Quantity * oi.UnitPrice) AS OrderTotal,
    STRING_AGG(p.ProductName, ', ') AS Products,
    o.Status
FROM Customers c
JOIN Orders o
    ON o.CustomerID = c.CustomerID
JOIN OrderItems oi
    ON oi.OrderID = o.OrderID
JOIN Products p
    ON p.ProductID = oi.ProductID
GROUP BY 
    o.OrderID,
    c.FirstName,
    c.LastName,
    o.OrderDate,
    o.Status
ORDER BY 
    CASE o.Status
        WHEN 'Completed' THEN 1
        WHEN 'Shipped' THEN 2
        WHEN 'Processing' THEN 3
        WHEN 'Pending' THEN 4
        ELSE 5
    END;
GO


-- =============================================
-- 3. Customer Spending Analysis
-- Calculate orders, total spending and average
-- order value for each customer
-- =============================================

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
    c.LastName
ORDER BY
    TotalSpent DESC;
GO


-- =============================================
-- 4. Orders by Status
-- Analyze order volume and order value by status
-- =============================================

SELECT
    o.Status,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalOrderValue
FROM Orders o
JOIN OrderItems oi
    ON oi.OrderID = o.OrderID
GROUP BY
    o.Status
ORDER BY
    CASE o.Status
        WHEN 'Completed' THEN 1
        WHEN 'Shipped' THEN 2
        WHEN 'Processing' THEN 3
        WHEN 'Pending' THEN 4
        ELSE 5
    END;
GO


-- =============================================
-- 5. Product Sales Analysis
-- Calculate quantity sold and revenue by product
-- =============================================

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
    p.ProductName
ORDER BY
    TotalRevenue DESC;
GO


-- =============================================
-- 6. Customer Ranking
-- Rank customers based on total spending
-- =============================================

WITH CustomerSpending AS
(
    SELECT
        c.CustomerID,
        c.FirstName + ' ' + c.LastName AS CustomerName,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
    FROM Customers c
    JOIN Orders o
        ON o.CustomerID = c.CustomerID
    JOIN OrderItems oi
        ON oi.OrderID = o.OrderID
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName
)
SELECT
    CustomerID,
    CustomerName,
    TotalSpent,
    RANK() OVER (ORDER BY TotalSpent DESC) AS CustomerRank
FROM CustomerSpending
ORDER BY CustomerRank;
GO