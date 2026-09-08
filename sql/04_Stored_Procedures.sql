USE CustomerOrderManagement;
GO

-- =============================================
-- 1. Get Orders for a Customer
-- Returns all orders and their details for
-- a specific customer
-- =============================================

CREATE PROCEDURE sp_GetCustomerOrders
    @CustomerID INT
AS
BEGIN
    SELECT
        o.OrderID,
        o.OrderDate,
        STRING_AGG(p.ProductName, ', ') AS Products,
        SUM(oi.Quantity * oi.UnitPrice) AS OrderTotal,
        o.Status
    FROM Orders o
    JOIN OrderItems oi
        ON oi.OrderID = o.OrderID
    JOIN Products p
        ON p.ProductID = oi.ProductID
    WHERE o.CustomerID = @CustomerID
    GROUP BY
        o.OrderID,
        o.OrderDate,
        o.Status;
END;
GO


-- =============================================
-- 2. Get Orders by Status
-- Returns orders matching a specified status
-- =============================================

CREATE PROCEDURE sp_GetOrdersByStatus
    @Status VARCHAR(50)
AS
BEGIN
    SELECT
        o.OrderID,
        c.FirstName + ' ' + c.LastName AS CustomerName,
        o.OrderDate,
        STRING_AGG(p.ProductName, ', ') AS Products,
        SUM(oi.Quantity * oi.UnitPrice) AS OrderTotal,
        o.Status
    FROM Orders o
    JOIN Customers c
        ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi
        ON oi.OrderID = o.OrderID
    JOIN Products p
        ON p.ProductID = oi.ProductID
    WHERE o.Status = @Status
    GROUP BY
        o.OrderID,
        c.FirstName,
        c.LastName,
        o.OrderDate,
        o.Status;
END;
GO


-- =============================================
-- 3. Get Customer Summary
-- Returns order count, total spending and
-- average order value for a specific customer
-- =============================================

CREATE PROCEDURE sp_GetCustomerSummary
    @CustomerID INT
AS
BEGIN
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
    WHERE c.CustomerID = @CustomerID
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName;
END;
GO