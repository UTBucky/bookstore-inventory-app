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
	FOREIGN KEY (bookID) REFERENCES Books(bookID),
	FOREIGN KEY (orderID) REFERENCES Orders(orderID)
);

CREATE OR REPLACE TABLE BooksAuthors (
        bookID int,
	authorID int,
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
	('John', 'Smith', '555-555-2345');

--INSERT INTO Books () VALUES ();

--INSERT INTO Orders () VALUES ();

--INSERT INTO Authors () VALUES ();

--INSERT INTO Publishers () VALUES ();

-- SELECT * to Verify Sample Data:

SELECT * FROM Customers;
SELECT * FROM Books;
SELECT * FROM Orders;
SELECT * FROM Publishers;
SELECT * FROM Authors;
SELECT * FROM BooksOrders;
SELECT * FROM BooksAuthors;
