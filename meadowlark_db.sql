-- Create Tables:

CREATE OR REPLACE TABLE Customers (
        customerID int NOT NULL AUTO_INCREMENT,
        fName varchar(50),
        lName varchar(50),
        phoneNumber varchar(50),
        PRIMARY KEY (customerID)
);

CREATE OR REPLACE TABLE Publishers (
        publisherID int NOT NULL AUTO_INCREMENT,
        name varchar(50),
        PRIMARY KEY (publisherID)
);

CREATE OR REPLACE TABLE Books (
        bookID int NOT NULL AUTO_INCREMENT,
        title varchar(50),
	price decimal(6,2) NOT NULL,
	publisherID int,
	PRIMARY KEY (bookID),
	FOREIGN KEY (publisherID) REFERENCES Publishers(publisherID)
);

CREATE OR REPLACE TABLE Orders (
        orderID int NOT NULL AUTO_INCREMENT,
        customerID int NOT NULL,
	dateOrdered date NOT NULL,
	orderType varchar(50),
	FOREIGN KEY (customerID) REFERENCES Customers(customerID),
        PRIMARY KEY (orderID)
);

CREATE OR REPLACE TABLE Authors (
        authorID int NOT NULL AUTO_INCREMENT,
        fName varchar(50),
        lName varchar(50),
        PRIMARY KEY (authorID)
);

CREATE OR REPLACE TABLE BooksOrders (
        bookID int,
	orderID int,
	quantity int NOT NULL,
	PRIMARY KEY (bookID, orderID),
	FOREIGN KEY (bookID) REFERENCES Books(bookID),
	FOREIGN KEY (orderID) REFERENCES Orders(orderID)
);

CREATE OR REPLACE TABLE BooksAuthors (
        bookID int,
	authorID int,
	PRIMARY KEY (bookID, authorID),
	FOREIGN KEY (bookID) REFERENCES Books(bookID),
	FOREIGN KEY (authorID) REFERENCES Authors(authorID)
);

-- DESCRIBE to Verify Tables:

DESCRIBE Customers;
DESCRIBE Books;
DESCRIBE Orders;
DESCRIBE Publishers;
DESCRIBE Authors;
DESCRIBE BooksOrders;
DESCRIBE BooksAuthors;

-- Insert Sample Data:

INSERT INTO Customers (fName, lName, phoneNumber) VALUES 
	('Jane', 'Doe', '555-555-1234'),
	('John', 'Smith', '555-555-2345'),
	('Joe', 'Schmo', '555-555-3456');

INSERT INTO Authors (fName, lName) VALUES
        ('Professor', 'Coder'),
        ('George', 'Orwell'),
        ('Ted', 'Chiang');

INSERT INTO Publishers (name) VALUES
        ('Miracle Publishing'),
        ('Signet Classic'),
        ('Penguin Books');

INSERT INTO Books (title, price, publisherID) VALUES 
	('Hello World: Programming 101', 39.99, (SELECT publisherID FROM Publishers WHERE name = 'Miracle Publishing')),
	('Animal Farm', 19.99, (SELECT publisherID FROM Publishers WHERE name = 'Signet Classic')),
	('Exhalation', 29.99, (SELECT publisherID FROM Publishers WHERE name = 'Penguin Books'));

INSERT INTO Orders (customerID, dateOrdered, orderType) VALUES 
	((SELECT customerID FROM Customers WHERE fName = 'Joe' AND lName = 'Schmo'), 20240428, 'IN STORE'),
	((SELECT customerID FROM Customers WHERE fName = 'Jane' AND lName = 'Doe'), 20240427, 'DELIVERY'),
	((SELECT customerID FROM Customers WHERE fName = 'John' AND lName = 'Smith'), 20240429, 'PICK UP');

-- INSERT INTO BooksOrders () VALUES ();

-- INSERT INTO BooksAuthors () VALUES ();

-- SELECT * to Verify Sample Data:

SELECT * FROM Customers;
SELECT * FROM Books;
SELECT * FROM Orders;
SELECT * FROM Publishers;
SELECT * FROM Authors;
SELECT * FROM BooksOrders;
SELECT * FROM BooksAuthors;
