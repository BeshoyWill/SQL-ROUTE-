-- 1.-	Create a view named ProductSalesSummary that displays the following information:
-- • ProductID
-- • ProductName
-- • CategoryName
-- • TotalUnitsSold (sum of quantities sold)
-- • TotalRevenue (sum of Quantity * UnitPrice * (1 – Discount))

Go
CREATE VIEW ProductSalesSummary AS
SELECT P.ProductID, P.ProductName, C.CategoryName, SUM(OD.Quantity) AS TotalUnitsSold , SUM(OD.Quantity * OD.UnitPrice * (1-OD.Discount)) AS TotalRevenue
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductID, P.ProductName, C.CategoryName

Go
SELECT * FROM ProductSalesSummary


-- 2. -	Create a view named LateShippedOrders that displays details of all orders where the ShippedDate is later than the RequiredDate.
-- Include the following columns:
-- • OrderID
-- • CustomerID
-- • OrderDate
-- • RequiredDate
-- • ShippedDate
-- • DaysLate (calculated as ShippedDate – RequiredDate)

Go
CREATE VIEW LateShippedOrders AS
SELECT O.OrderID, O.CustomerID, O.OrderDate, O.RequiredDate, O.ShippedDate, DATEDIFF(DAY, O.RequiredDate, O.ShippedDate) AS DaysLate
FROM [Order Details] OD
JOIN Orders O ON O.OrderID = OD.OrderID
WHERE O.ShippedDate > O.RequiredDate
GROUP BY O.OrderID, O.CustomerID, O.OrderDate, O.RequiredDate, O.ShippedDate

Go
SELECT * FROM dbo.LateShippedOrders