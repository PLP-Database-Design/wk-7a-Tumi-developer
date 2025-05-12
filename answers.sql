-- Question 1 Achieving 1NF (First Normal Form)
-- here's the SQL query to transform the table into 1NF:

-- Create a new table to store the 1NF data.  This avoids modifying the original table.
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- new table splitting the Products string from the original table.

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM ProductDetail
CROSS JOIN (
    SELECT 1 AS n UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    SELECT 4 
) AS numbers
WHERE n <= LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1;



-- Question 2 Achieving 2NF (Second Normal Form)
-- To transform the OrderDetails table into 2NF, we decompose it into two tables: Customers and Orders

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert data into the Customers table
INSERT INTO Customers (CustomerID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(255),
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerID, Product, Quantity)
SELECT OrderID, OrderID, Product, Quantity
FROM OrderDetails;

-- Display the resulting tables
SELECT * FROM Customers;
SELECT * FROM Orders;

-- Question 1

CREATE TABLE ProductDetail (

OrderID INT,

CustomerName VARCHAR(100),

Products VARCHAR(100)

);

INSERT INTO ProductDetail(OrderID, CustomerName, Products)

VALUES

(101, 'John Doe', 'Laptop'),

(101, 'John Doe', 'Mouse'),

(102, 'Jane Smith', 'Tablet'),

(102, 'Jane Smith', 'Keyboard'),

(102, 'Jane Smith', 'Mouse'),

(103, 'Emily Clark', 'Phone');

-- Question 2

CREATE TABLE Orders (

OrderID INT PRIMARY KEY,

CustomerName VARCHAR(100)

);

INSERT INTO Orders (OrderID, CustomerName)

VALUES

(101, 'John Doe'),

(102, 'Jane Smith'),

(103, 'Emily Clark');

CREATE TABLE Product (

OrderID INT,

Product VARCHAR(100),

Quantity INT,

PRIMARY KEY (OrderID, Product),

FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)

);

INSERT INTO Product (OrderID, Product, Quantity)

VALUES

(101, 'Laptop', 2),

(101, 'Mouse', 1),

(102, 'Tablet', 3),

(102, 'Keyboard', 1),

(102, 'Mouse', 2),

(103, 'Phone', 1);