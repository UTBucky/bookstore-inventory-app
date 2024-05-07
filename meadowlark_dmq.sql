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

-- edit existing line item in BooksOrders
UPDATE BooksOrders SET bookID = :bookIDInput, orderID = :orderIDInput, quantity = :quantityInput
WHERE id= :bookOrderIDSelection;

-- delete line item in BooksOrders
DELETE FROM BooksOrders WHERE bookOrderID = :bookOrderIDSelection;


-- Authors Queries --

-- get all Authors for browse author page
SELECT authorID, fName AS 'First Name', lName AS 'Last Name' FROM Authors;

-- add new Author info
INSERT INTO Authors (fName, lName) VALUES
(:fNameInput, :lNameInput);

-- display existing author info of selected authorID
SELECT authorID, fName AS 'First Name', lName AS 'Last Name' FROM Authors
WHERE id= :authorIDselection;

-- edit existing author info
UPDATE Authors SET fName = :fNameInput, lName = :lNameInput
WHERE id= :authorIDselection;

-- delete existing author
DELETE FROM Authors WHERE authorID = :authorIDSelection;


-- BooksAuthors Queries --

-- display all authors for a selected book
SELECT bookAuthorID, Books.title AS 'Book Title', Author.fName || ' ' || Author.lName AS "Author"
	FROM BooksAuthors
	INNER JOIN Books ON BooksAuthors.bookID = Books.bookID
	INNER JOIN Authors ON BooksAuthors.authorID = Authors.authorID
    WHERE Books.bookID = :bookIDSelection;

-- add author to book
INSERT INTO BooksAuthors (bookID, authorID) VALUES
((SELECT bookID FROM Books where bookID = :bookIDSelection), (SELECT authorID FROM Authors WHERE authorID = :authorIDSelection));

-- edit bookID and authorID for BooksAuthors
UPDATE BooksAuthors SET bookID = :bookIDInput, authorID = :authorIDInput
WHERE id= :bookAuthorIDSelection;

-- delete book and author relationship in BooksAuthors
DELETE FROM BooksAuthors WHERE bookAuthorID = :bookAuthorIDSelection;


-- Publisher Queries --

-- get all publishers for browse publisher page
SELECT publisherID, name AS 'Name' FROM Publishers;

-- add new publisher info
INSERT INTO Publishers (name) VALUES
(:nameInput);

-- display existing publisher info of selected publisherID
SELECT name AS 'Name' FROM Publishers
WHERE id= :publisherIDselection;

-- edit existing publisher info
UPDATE Publishers SET name = :nameInput
WHERE id= :publisherIDselection;

-- delete existing publisher
DELETE FROM Publishers WHERE publisherID = :publisherIDSelection;