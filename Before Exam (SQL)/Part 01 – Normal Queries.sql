USE NORTHWND

-- 1.  Write a query to calculate the average order value for each customer, rounded to 2 decimal places. 
-- Display only those customers whose average order value is greater than 500. 
-- Include the CustomerID, CompanyName, and the calculated average order value.

SELECT C.CustomerID, ROUND(AVG(O.OrdersValues), 2) AS Average_Order_Value
FROM Customers C
JOIN 
(
	SELECT
		CustomerID,
		SUM(Freight) AS OrdersValues
	FROM Orders
	GROUP BY CustomerID
) O
ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID
HAVING AVG(O.OrdersValues) > 500;



-- 2.  Write a query to find the most recent order date for each customer and display their CustomerID, CompanyName, 
-- and OrderID for that order. Sort the result in descending order of the order date.

SELECT C.CustomerID, C.CompanyName, O.OrderID, MAX(O.OrderDate) AS Recent_Order
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName, O.OrderID
ORDER BY Recent_Order DESC


-- 3.  Write a query to calculate the total sales amount after applying discounts for each product. 
-- Display the ProductID, ProductName, and the total sales amount, rounded to 2 decimal places.

SELECT P.ProductID, P.ProductName, ROUND(SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)), 2) AS Total_Sales
FROM Products P
JOIN [Order Details] OD
ON OD.ProductID = P.ProductID
GROUP BY P.ProductID, P.ProductName