USE NORTHWND

-- 1.  Create a scalar-valued function called CalculateOrderValue that takes an 
-- OrderID as input and returns the total value of the order (including discounts).

GO
CREATE FUNCTION CalculateOrderValue(@OrderID INT)
RETURNS DECIMAL(18, 2)
AS	
BEGIN
	DECLARE @TotalValue  DECIMAL(18, 2)
	SELECT @TotalValue = SUM(OD.Quantity * OD.UnitPrice * (1-OD.Discount))
	FROM [Order Details] OD
	WHERE OD.OrderID = @OrderID
			
	RETURN @TotalVAlue
END;

Go
SELECT dbo.CalculateOrderValue(10250)



-- 2.  Create a multi-statement table-valued function called GetCustomerOrderSummary that 
-- takes a CustomerID as input and returns a table with the following columns:
-- • CustomerID
-- • OrderYear (year of the order)
-- • TotalOrders (number of orders placed by the customer in that year).

Go
CREATE FUNCTION GetCustomerOrderSummary (@CustomerID NVARCHAR(20))
RETURNS @CustomerOrders TABLE
(
	CustomerID NVARCHAR(50),
	OrderYear INT,
	TotalOrders INT
)
AS
BEGIN
	INSERT INTO @CustomerOrders (CustomerID, OrderYear, TotalOrders)
	SELECT O.CustomerID, YEAR(O.OrderDate) AS OrderYear, COUNT(O.OrderID) AS TotalOrders
	FROM Orders O
	WHERE O.CustomerID = @CustomerID
	GROUP BY O.CustomerID, YEAR(O.OrderDate)
	RETURN;
END;

GO
SELECT * FROM dbo.GetCustomerOrderSummary('VINET')


-- 3. -	Write an inline table-valued function called GetTopSellingProducts that takes an input parameter 
-- @TopN (number of products to return). The function should return:
-- • ProductID, ProductName, and TotalUnitsSold (sum of quantity sold from OrderDetails).

Go
CREATE FUNCTION GetTopSellingProducts(@TopN INT)
RETURNS TABLE
AS
RETURN
(
	SELECT P.ProductID, P.ProductName, SUM(OD.Quantity) AS TotalUnitsSold
	FROM Products P
	JOIN [Order Details] OD
	ON P.ProductID = OD.ProductID
	GROUP BY P.ProductID, P.ProductName
	ORDER BY TotalUnitsSold DESC
	OFFSET 0 ROWS FETCH NEXT @TopN ROWS ONLY
)

Go
SELECT * 
FROM GetTopSellingProducts(1);