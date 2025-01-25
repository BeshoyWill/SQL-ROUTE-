-- 1. Create a trigger that prevents the deletion of an order from the Orders table if the order has been shipped 
-- (i.e., if the ShippedDate is not NULL).
-- • If an attempt to delete a shipped order is made, the trigger should raise an error message saying “Cannot delete shipped orders.”

Go
CREATE OR ALTER TRIGGER PreventShippedOrderDeletion
ON ORDERS
INSTEAD OF DELETE
AS
BEGIN
	IF EXISTS
	(
		SELECT  1
		FROM deleted
		WHERE ShippedDate IS NOT NULL
	)
	BEGIN
		RAISERROR('Cannot delete shipped orders.', 16, 1);
		RETURN;
	END;

	DELETE FROM Orders
	WHERE Orders.OrderID IN (SELECT OrderID FROM deleted);
END

DELETE FROM Orders WHERE OrderID = 10250;


-- 2. Create a trigger that logs every UPDATE to the UnitPrice column in the Products table.
-- • The trigger should insert the following details into a PriceUpdateLog table (which you will need to create):
-- • ProductID
-- • OldPrice
-- • NewPrice
-- • UpdateDate (timestamp of the update).

Go
CREATE TABLE PriceUpdateLog
(
	[LogID] INT IDENTITY PRIMARY KEY,
	ProductID INT NOT NULL,
	OldPrice DECIMAL(18, 2) NOT NULL,
	NewPrice DECIMAL(18, 2) NOT NULL,
	UpdateDate DATE NOT NULL DEFAULT GETDATE()
)

Go
CREATE OR ALTER TRIGGER LogPriceUpdate
ON Products
AFTER UPDATE
AS
BEGIN
	INSERT INTO PriceUpdateLog (ProductID, OldPrice, NewPrice, UpdateDate)
	SELECT I.ProductID, D.UnitPrice AS OldPrice, I.UnitPrice AS NewPrice, GETDATE() AS UpdateDate
	FROM inserted I
	JOIN deleted D ON I.ProductID = D.ProductID
	WHERE I.UnitPrice <> D.UnitPrice;
END;

UPDATE Products
SET UnitPrice = 10
WHERE ProductID = 1

SELECT * FROM PriceUpdateLog