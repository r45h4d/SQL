-- User table
CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,
    Username VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL
);

-- Address table
CREATE TABLE Address (
    AddressID SERIAL PRIMARY KEY,
    UserID INT NOT NULL REFERENCES Users(UserID),
    Street VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    ZipCode VARCHAR(20)
);

-- Order table
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    UserID INT NOT NULL REFERENCES Users(UserID),
    OrderDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL
);

-- Product table
CREATE TABLE Product (
    ProductID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL
);

-- OrderItem table
CREATE TABLE OrderItem (
    OrderItemID SERIAL PRIMARY KEY,
    OrderID INT NOT NULL REFERENCES Orders(OrderID),
    ProductID INT NOT NULL REFERENCES Product(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL
);

-- Category table
CREATE TABLE Category (
    CategoryID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- ProductCategory table (junction table for many-to-many relationship)
CREATE TABLE ProductCategory (
    ProductID INT NOT NULL REFERENCES Product(ProductID),
    CategoryID INT NOT NULL REFERENCES Category(CategoryID),
    PRIMARY KEY (ProductID, CategoryID)
);

-- Payment table
CREATE TABLE Payment (
    PaymentID SERIAL PRIMARY KEY,
    OrderID INT NOT NULL REFERENCES Orders(OrderID),
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod VARCHAR(100) NOT NULL
);

-- ShoppingCart table
CREATE TABLE ShoppingCart (
    CartID SERIAL PRIMARY KEY,
    UserID INT NOT NULL REFERENCES Users(UserID),
    CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CartItem table
CREATE TABLE CartItem (
    CartItemID SERIAL PRIMARY KEY,
    CartID INT NOT NULL REFERENCES ShoppingCart(CartID),
    ProductID INT NOT NULL REFERENCES Product(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL
);


--------------------------------------------------------

SELECT COUNT(name) FROM category;

INSERT INTO Orders (UserID, OrderDate, TotalAmount)
VALUES (5, NOW(), 50);

SELECT AVG(price) FROM product;

SELECT MAX(userid) FROM users;

SELECT MIN(price) FROM product;

SELECT SUM(totalamount) FROM orders;

SELECT DISTINCT(paymentmethod) FROM payment;

SELECT * FROM users WHERE username LIKE 'user%';

SELECT userid as ID FROM users
UNION
SELECT productid FROM product;

SELECT userid as ID FROM users
UNION ALL
SELECT productid FROM product;

SELECT name FROM product
LIMIT 5
OFFSET 5;

SELECT name, AVG(price) FROM product
GROUP BY name;

SELECT name, AVG(price) AS average_price
FROM Product
GROUP BY name
HAVING AVG(price) BETWEEN 30 AND 70;

SELECT u.userid, u.username FROM users u
INNER JOIN shoppingcart s
ON u.userid=s.userid;

SELECT o.orderid, o.totalamount FROM orders o
LEFT JOIN payment p
ON o.orderid = p.orderid;

