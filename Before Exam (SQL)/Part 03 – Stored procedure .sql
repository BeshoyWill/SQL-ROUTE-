USE NORTHWND

-- 1. Create a stored procedure named GetCustomerOrderHistory that takes a CustomerID as input and returns a list of:
-- • ProductName
-- • TotalQuantityOrdered (sum of quantities ordered for that product by the customer).

Go
CREATE PROCEDURE GetCustomerOrderHistory(@CustomerID NVARCHAR(20))
AS
BEGIN
	SELECT P.ProductName, SUM(OD.Quantity) AS TotalQuantityOrdered
	FROM Orders O
	JOIN [Order Details] OD ON O.OrderID = OD.OrderID
	JOIN Products P ON P.ProductID = OD.ProductID
	WHERE O.CustomerID = @CustomerID
	GROUP BY P.ProductName
	ORDER BY TotalQuantityOrdered DESC
END;

Go
EXEC GetCustomerOrderHistory @CustomerID = 'VINET'

-- 2. -	Create a stored procedure named UpdateProductPrices that takes two parameters:
-- • @CategoryID (ID of the product category)
-- • @Percentage (percentage increase or decrease, e.g., 10 for a 10% increase).
-- The procedure should:
-- • Increase the prices of all products in the specified category by the given percentage.
-- • Display the ProductID, ProductName, and the updated UnitPrice after the change.

Go
CREATE PROCEDURE UpdateProductPrices(@CategoryID INT, @Percentage INT)
AS
BEGIN
	UPDATE Products
	SET UnitPrice = UnitPrice + (UnitPrice * @Percentage / 100)
	WHERE CategoryID = @CategoryID
	SELECT P.ProductID, P.ProductName, P.UnitPrice
	FROM Products P
	WHERE P.CategoryID= @CategoryID
END;

Go
EXEC UpdateProductPrices @CategoryID=1 , @Percentage=10;