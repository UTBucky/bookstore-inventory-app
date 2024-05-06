-- Group 55: Meadowlark Books
-- Database Manipulation Queries for Meadowlark Books

-- Customers Queries --

-- get all customers and info for browse customer page
SELECT customerID, fName AS 'First Name', lName AS 'Last Name', phoneNumber as 'Phone Number' FROM Customers;

-- add new customer info
INSERT INTO Customers (fName, lName, phoneNumber) VALUES
(:fNameInput, :lNameInput, :phoneNumberInput);

-- display existing customer info of selected customerID
SELECT customerID, fName AS 'First Name', lName AS 'Last Name', phoneNumber as 'Phone Number' FROM Customers
WHERE id= :customerIDselection;

-- edit existing customer info
UPDATE Customers SET fName = :fNameInput, lName = :lNameInput, phoneNumber = :phoneNumberInput
WHERE id= :customerIDselection;

-- delete existing customer
DELETE FROM Customers WHERE customerID = :customerIDSelection;


-- Orders Queries --

-- get all orders for browse order page
SELECT orderID, Orders.customerID, Customers.fName AS 'Customer First Name', Customers.lName AS 'Customer Last Name', dateOrdered AS 'Date Ordered', orderType AS 'Order Type' 
FROM Orders
INNER JOIN Customers ON Orders.customerID = Customers.customerID;

-- adding new order requires: selecting customer
SELECT customerID, fName AS 'First Name', lName AS 'Last Name', phoneNumber as 'Phone Number' FROM Customers;

-- add new order info
INSERT INTO Orders (customerID, dateOrdered, orderType) VALUES
((SELECT Customers.customerID FROM Customers WHERE customerID = 
 :customerIDSelection), :dateOrderedInput, :orderTypeInput)

-- edit existing order info
UPDATE Orders SET customerID = (SELECT customerID FROM Customers WHERE id = :customerIDselection), dateOrdered = :dateOrderedInput, orderType = :orderTypeInput WHERE orderID = :orderIDSelection;

-- delete order
DELETE FROM Orders WHERE orderID = :orderIDSelection;


-- BooksOrders Queries --

-- display all books in a selected order
SELECT bookOrderID, Books.title AS 'Book Title', quantity 
	FROM BooksOrders
	INNER JOIN Books ON BooksOrders.bookID = Books.bookID
    WHERE BooksOrders.orderID = :orderIDSelection;

-- add books to order
INSERT INTO BooksOrders (bookID, orderID, quantity) VALUES
((SELECT bookID FROM Books where bookID = :bookIDSelection), (SELECT orderID FROM Orders WHERE orderID = :orderIDSelection), :quantityInput);


