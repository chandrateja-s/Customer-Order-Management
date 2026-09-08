USE CustomerOrderManagement;
GO

-- =============================================
-- 1. Check for Duplicate Customers
-- =============================================

SELECT
    CustomerID,
    COUNT(*) AS RecordCount
FROM Customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;
GO


-- =============================================
-- 2. Check for Duplicate Products
-- =============================================

SELECT
    ProductID,
    COUNT(*) AS RecordCount
FROM Products
GROUP BY ProductID
HAVING COUNT(*) > 1;
GO


-- =============================================
-- 3. Check for Duplicate Orders
-- =============================================

SELECT
    OrderID,
    COUNT(*) AS RecordCount
FROM Orders
GROUP BY OrderID
HAVING COUNT(*) > 1;
GO


-- =============================================
-- 4. Check for Orphan Orders
-- Orders must reference an existing customer
-- =============================================

SELECT
    o.OrderID,
    o.CustomerID
FROM Orders o
LEFT JOIN Customers c
    ON o.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;
GO


-- =============================================
-- 5. Check for Orphan OrderItems - Orders
-- Every OrderItem must reference an existing order
-- =============================================

SELECT
    oi.OrderItemID,
    oi.OrderID
FROM OrderItems oi
LEFT JOIN Orders o
    ON oi.OrderID = o.OrderID
WHERE o.OrderID IS NULL;
GO


-- =============================================
-- 6. Check for Orphan OrderItems - Products
-- Every OrderItem must reference an existing product
-- =============================================

SELECT
    oi.OrderItemID,
    oi.ProductID
FROM OrderItems oi
LEFT JOIN Products p
    ON oi.ProductID = p.ProductID
WHERE p.ProductID IS NULL;
GO


-- =============================================
-- 7. Check Order Status Distribution
-- =============================================

SELECT
    Status,
    COUNT(*) AS NumberOfOrders
FROM Orders
GROUP BY Status
ORDER BY NumberOfOrders DESC;
GO


-- =============================================
-- 8. Check for Invalid OrderItem Values
-- Quantity must be greater than zero
-- UnitPrice must not be negative
-- =============================================

SELECT *
FROM OrderItems
WHERE Quantity <= 0
   OR UnitPrice < 0;
GO


-- =============================================
-- 9. Check for NULL Values - Customers
-- =============================================

SELECT
    SUM(CASE WHEN FirstName IS NULL THEN 1 ELSE 0 END) AS NullFirstName,
    SUM(CASE WHEN LastName IS NULL THEN 1 ELSE 0 END) AS NullLastName,
    SUM(CASE WHEN Email IS NULL THEN 1 ELSE 0 END) AS NullEmail,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS NullCity
FROM Customers;
GO


-- =============================================
-- 10. Check for NULL Values - Orders
-- =============================================

SELECT
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS NullCustomerID,
    SUM(CASE WHEN OrderDate IS NULL THEN 1 ELSE 0 END) AS NullOrderDate,
    SUM(CASE WHEN Status IS NULL THEN 1 ELSE 0 END) AS NullStatus
FROM Orders;
GO


-- =============================================
-- 11. Check for NULL Values - OrderItems
-- =============================================

SELECT
    SUM(CASE WHEN OrderID IS NULL THEN 1 ELSE 0 END) AS NullOrderID,
    SUM(CASE WHEN ProductID IS NULL THEN 1 ELSE 0 END) AS NullProductID,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS NullQuantity,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS NullUnitPrice
FROM OrderItems;
GO