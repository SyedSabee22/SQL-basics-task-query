-- Step 1: Create the Database and Use It
CREATE DATABASE task3;
USE task3;

-- Step 2: Create the Customers (Users) Table
CREATE TABLE Customers (
    user_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- Insert data into Customers table
INSERT INTO Customers (user_id, name, email) VALUES
(1, "Sabeel", "syedsabeelrahmani@gmail.com"),
(2, "Rahmani", "rahmani@gmail.com"),
(3, "Faizan", "faizan@gmail.com"),
(4, "Imran", "imran@gmail.com"),
(5, "Atif", "atif@gmail.com"),
(6, "Kashif", "kashif@gmail.com"),
(7, "Saif", "saif@gmail.com"),
(8, "Arif", "arif@gmail.com"),
(9, "Sohani", "sohani@gmail.com"),
(10, "Punam", "punam@gmail.com");
SELECT * FROM Customers;
-- Step 3: Create the Books (Products) Table
CREATE TABLE Books (
    product_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Insert data into Books table
INSERT INTO Books (product_id, title, author, price) VALUES
(01, "The Kite Runner", "Khalid Hussaini", 3000),
(02, "The Gods of Small Things", "Arundhati Roy", 1000),
(03, "The Mountain Echoes", "Khalid Hussaini", 4000),
(04, "The Thousand Splendid Suns", "Khalid Hussaini", 2000),
(05, "50 Shades of Love", "Hk Hamilton", 1000),
(06, "Haunted Adenile", "H. D. Carlton", 6000),
(07, "Harry Potter", "J.K Rowling", 7000),
(08, "Spider Man", "Stan lee", 1000),
(09, "Dark Matter", "manish ", 500),
(010, "Fifty shades of grey", "Wiiliam Shiekshapere", 3000);

-- Step 4: Create the Orders (Transactions) Table
CREATE TABLE Orders (
    transaction_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Customers(user_id)
);
SELECT * FROM Orders;

-- Insert data into Orders table
INSERT INTO Orders (transaction_id, user_id, order_date) VALUES
(11, 1, '2023-10-01'),
(21, 2, '2023-08-15'),
(31, 3, '2023-07-20'),
(41, 4, '2023-06-25'),
(51, 5, '2023-05-30'),
(61, 6, '2023-04-10'),
(71, 7, '2023-03-15'),
(81, 8, '2023-03-15'),
(91, 9, '2023-03-15'),
(101, 10, '2023-03-15');

-- Step 5: Create the OrderDetails (TransactionDetails) Table
CREATE TABLE OrderDetails (
    transaction_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (transaction_id, product_id),
    FOREIGN KEY (transaction_id) REFERENCES Orders(transaction_id),
    FOREIGN KEY (product_id) REFERENCES Books(product_id)
);
Select* From OrderDetails;
-- Insert data into OrderDetails table
INSERT INTO OrderDetails (transaction_id, product_id, quantity) VALUES
(11, 01, 2),  -- Transaction 1, Product 1 (2 copies)
(21, 02, 10),
(31, 03, 4), 
(41, 04, 2), 
(51, 05, 4),  
(71, 07, 11),  
(81, 08, 13), 
(91, 09,17), 
(101, 010, 13);  
-- 1.	Write a SQL query to retrieve the top 5 customers who have purchased the 
-- most books (by total quantity) over the last year.
SELECT c.user_id, 
       c.name, 
       c.email, 
       SUM(od.quantity) AS total_quantity
FROM Customers c
JOIN Orders o ON c.user_id = o.user_id
JOIN OrderDetails od ON o.transaction_id = od.transaction_id
WHERE o.order_date >= '2023-01-01' AND o.order_date <= '2023-12-31'
GROUP BY c.user_id, c.name, c.email
ORDER BY total_quantity DESC
LIMIT 5;
-- 2.	Write a SQL query to calculate the total 
-- revenue generated from book sales by each author.
SELECT
    b.author,
    SUM(b.price * od.quantity) AS total_revenue
FROM
    Books b
JOIN
    OrderDetails od ON b.product_id = od.product_id
JOIN
    Orders o ON od.transaction_id = o.transaction_id
GROUP BY
    b.author
ORDER BY
    total_revenue DESC;

   -- 3.Write a SQL query to retrieve all 
    -- books that have been ordered more than 10 times, 
    -- along with the total quantity ordered for each book.

SELECT
    b.product_id,
    b.title,
    b.author,
    SUM(od.quantity) AS total_quantity_ordered
FROM
    Books b
JOIN
    OrderDetails od ON b.product_id = od.product_id
JOIN
    Orders o ON od.transaction_id = o.transaction_id
GROUP BY
    b.product_id, b.title, b.author
HAVING
    SUM(od.quantity) > 10
ORDER BY
    total_quantity_ordered DESC
    Limit 6;
