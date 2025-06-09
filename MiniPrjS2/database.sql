
CREATE DATABASE ecommerce_db;
USE ecommerce_db;


CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

INSERT INTO Category (CategoryID, CategoryName) VALUES
(101, 'Men''s Clothing'),
(102, 'Women''s Clothing'),
(103, 'Kids'' Clothing'),
(104, 'Accessories'),
(105, 'Footwear');


CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    Status VARCHAR(20),
    ImagePath VARCHAR(255),
    CreatedDate DATETIME,
    LastModifiedDate DATETIME,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

INSERT INTO Product (ProductID, ProductName, CategoryID, Status, ImagePath, CreatedDate, LastModifiedDate)
VALUES
(1, 'Men Cotton Shirt', 101, 'Active', 'images/men-cotton-shirt.jpg', '2025-01-15 10:00:00', '2025-03-20 12:30:00'),
(2, 'Women Floral Dress', 102, 'Active', 'images/women-floral-dress.jpg', '2025-01-20 11:00:00', '2025-04-01 09:45:00'),
(3, 'Kids Winter Jacket', 103, 'Inactive', 'images/kids-winter-jacket.jpg', '2024-12-10 08:30:00', '2025-01-10 14:10:00'),
(4, 'Mens Leather Jacket', 101, 'Active', 'images/mens-leather-jacket.jpg', '2024-12-10 08:45:00', '2025-01-10 15:10:00');


CREATE TABLE ProductAttributes (
    AttributeID INT PRIMARY KEY,
    ProductID INT,
    AttributeName VARCHAR(50),
    AttributeValue VARCHAR(100),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT INTO ProductAttributes (AttributeID, ProductID, AttributeName, AttributeValue) VALUES
(1, 1, 'Color', 'Brown'),
(2, 1, 'Size', 'M'),
(3, 1, 'Material', '100% Cotton'),
(4, 2, 'Color', 'Yellow'),
(5, 2, 'Size', 'L'),
(6, 2, 'Pattern', 'Floral'),
(7, 3, 'Color', 'Yellow'),
(8, 3, 'Size', 'S'),
(9, 3, 'Season', 'Winter'),
(10, 4, 'Color', 'Tan Brown'),
(11, 4, 'Size', 'XL'),
(12, 4, 'Season', 'Winter');

CREATE TABLE ProductCategory (
    CategoryID INT,
    ProductID INT,
    SKU VARCHAR(50),
    Price DECIMAL(10, 2),
    Discount INT,
    DiscountPrice DECIMAL(10, 2),
    PRIMARY KEY (CategoryID, ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT INTO ProductCategory (CategoryID, ProductID, SKU, Price, Discount, DiscountPrice) VALUES
(101, 1, 'SKU-MCS-001', 1299.00, 38, 799.00),
(102, 2, 'SKU-WFD-002', 1899.50, 38, 1177.00),
(103, 3, 'SKU-KWJ-003', 2499.99, 45, 1374.45),
(101, 4, 'SKU-MLJ-004', 2499.00, 35, 1624.35);


CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Password VARCHAR(255),
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15)
);

INSERT INTO Users (UserID, FirstName, LastName, Password, Email, PhoneNumber) VALUES
(1, 'Arjun', 'Mehta', 'Pass@123', 'arjun.mehta@example.com', '9812345678'),
(2, 'Riya', 'Sharma', 'Riya#2024', 'riya.sharma@example.com', '9876543210'),
(3, 'Kabir', 'Singh', 'Kabir@456', 'kabir.singh@example.com', '9700011223'),
(4, 'Ananya', 'Rao', 'Ana2025!*', 'ananya.rao@example.com', '9733344455');
