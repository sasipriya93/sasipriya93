CREATE DATABASE ORG;
USE ORG;
CREATE TABLE Customer(CustomerID INT PRIMARY KEY,Name VARCHAR(255),Email VARCHAR(255),JoinDate DATE);
CREATE TABLE Product(ProductID INT PRIMARY KEY,Name VARCHAR(255), Category VARCHAR(255),Price DECIMAL(10,2));
CREATE TABLE Orders(OrderID INT PRIMARY KEY,CustomerID INT, OrderDate DATE,TotalAmount DECIMAL(10,2),FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID));
CREATE TABLE OrderDetails(OrderDetailID INT PRIMARY KEY,OrderID INT,ProductID INT,Quantity INT,PricePerUnit DECIMAL(10,2),FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY(ProductID) REFERENCES Product(ProductID));
INSERT INTO Customer(CustomerID,Name,Email,JoinDate) VALUES 
(1,'JOHN DOE','johndoe@example.com','2020-01-10'),
(2,'JANE SMITH','janesmith@example.com','2020-01-05'),
(3,'SASI PRIYA','sasipriya@gmail.com','2021-01-02'),
(4,'YAZHINI','yazhini@gamil.com','2021-02-12'),
(5,'RAVISHANKAR','ravi123@example.com','2021-01-05'),
(6,'SANGAVI','sangavi@gmail.com','2020-02-03'),
(7,'KANIMOZHHI','kanimozhi@gmail.com','2020-01-09'),
(8,'SHIVA KUMAR','shivakumar@example.com','2021-03-03'),
(9,'PRITHIVIRAJ','prithivi@gmail.com','2021-01-02'),
(10,'ALICE JOHNSON','alicejohnson@example.com','2020-01-02');

INSERT INTO Product(ProductID,Name,Category,Price) VALUES 
(1,'LAPTOP','Electronics',999.99),
(2,'SMARTPHONE','Electronics',499.99),
(3,'REFRIDGERATOR','Home Appliance',950.99),
(4,'WASHING MACHINE','Home Appliances',250.99),
(5,'TELEVISION','Electronics',150.99),
(6,'IPHONE','Electronics',599.99),
(7,'PLAYSTATION','Electronics',450.99),
(8,'FLOWER VASE','Home Decor',199.99),
(9,'TEAK WOODEN SOFA','Furniture',299.99),
(10,'DESK LAMP','Home Decor',29.99);

INSERT INTO Orders(OrderID,CustomerID,OrderDate,TotalAmount) VALUES 
(1,1,'2020-02-15',1499.98),
(2,2,'2020-02-17',499.99),
(3,4,'2021-03-22',999.99),
(4,3,'2020-02-11',599.98),
(5,9,'2021-04-29',1299.99),
(6,8,'2020-06-06',899.70),
(7,7,'2020-05-18',1450.99),
(8,5,'2020-03-21',799.98),
(9,6,'2021-08-28',1299.99),
(10,10,'2020-03-21',78.99);

INSERT INTO OrderDetails(OrderDetailID,OrderID,ProductID,Quantity,PricePerUnit) VALUES 
(1,1,1,1,999.99),
(2,1,2,1,499.99),
(3,4,4,5,950.99),
(4,3,5,2,250.99),
(5,9,7,4,150.99),
(6,8,7,6,599.99),
(7,7,8,4,450.99),
(8,5,9,3,199.99),
(9,6,10,8,299.99),
(10,10,2,1,29.99);


SELECT Name from Customer;
SELECT * from Product where category ='Electronics';
SELECT COUNT(*) AS TotalOrders FROM Orders;


SELECT C.CustomerID, C.Name,P.Name AS ProductNmae
FROM Customer  C 
JOIN orders O ON C.CustomerID = O.CustomerID
JOIN  orderdetails OD  ON O.OrderID = OD.OrderDetailID
JOIN  product P ON OD.ProductID =P.ProductID;
---------


SELECT O.OrderID, COUNT(DISTINCT OD.ProductID) AS NumProducts
FROM orders O
JOIN orderdetails OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID
HAVING NumProducts > 1;


--------
SELECT C.CustomerID, C.Name AS CustomerName, SUM(OD.Quantity * OD.PricePerUnit) AS TotalSalesAmount
FROM Customer C
JOIN orders O ON C.CustomerID = O.CustomerID
JOIN orderdetails OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.Name;

-------






SELECT CustomerID, Name AS CustomerName, JoinDate, DATEDIFF(CURDATE(), JoinDate) AS MembershipDuration
FROM Customer
ORDER BY MembershipDuration DESC
LIMIT 1;


-------


SELECT 
    current_month.month,
    current_month.total_sales AS current_month_sales,
    previous_month.total_sales AS previous_month_sales,
    (current_month.total_sales - previous_month.total_sales) / previous_month.total_sales AS growth_rate
FROM
    (SELECT YEAR(orderdate) AS year,
            MONTH(orderdate) AS month,
            SUM(TotalAmount) AS total_sales
    FROM orders
    GROUP BY YEAR(orderdate), MONTH(orderdate)) AS current_month
LEFT JOIN
    (SELECT YEAR(orderdate) AS year,
            MONTH(orderdate) AS month,
            SUM(TotalAmount) AS total_sales
    FROM orders
    GROUP BY YEAR(orderdate), MONTH(orderdate)) AS previous_month
ON current_month.year = previous_month.year
AND current_month.month = previous_month.month + 1;



----------
INSERT INTO Customer(CustomerID,Name,Email,JoinDate) VALUES 
(11, 'RAJ', 'rajdesingner@gmail.com','2020-03-20');

--------
UPDATE product
SET price = 1229.99
WHERE productid = 6;

------
SELECT *
FROM product
WHERE productid = 6;

select *from customer