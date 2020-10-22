CREATE DATABASE Chuong10_1;
USE Chuong10_1;

CREATE TABLE Customer
(
    cID  INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(25),
    cAge TINYINT
);

CREATE TABLE Orders
(
    oID         INT PRIMARY KEY AUTO_INCREMENT,
    cID         INT,
    oDate       DATETIME,
    oTotalPrice INT,
    CONSTRAINT customer_id FOREIGN KEY (cID) REFERENCES Customer (cID)
);

CREATE TABLE Product
(
    pID    INT PRIMARY KEY AUTO_INCREMENT,
    pName  VARCHAR(25),
    pPrice INT
);

CREATE TABLE OrderDetail
(
    oID   INT,
    pID   INT,
    odQTY INT,
    PRIMARY KEY (oID, pID),
    CONSTRAINT order_id FOREIGN KEY (oID) REFERENCES Orders (oID),
    CONSTRAINT product_id FOREIGN KEY (pID) REFERENCES Product (pID)
);

INSERT INTO Customer (name, cage)
VALUES ('Minh Quan', 10),
       ('Ngoc Oanh', 20),
       ('Hong Ha', 50);

INSERT INTO Orders (cID, oDate)
VALUES (1, '2006/3/21'),
       (2, '2006/3/23'),
       (1, '2006/3/16');

INSERT INTO Product (pName, pPrice)
VALUES ('May Giat', 3),
       ('Tu Lanh', 5),
       ('Dieu Hoa', 7),
       ('Quat', 1),
       ('Bep Dien', 2);

INSERT INTO OrderDetail(oID, pID, odQTY)
VALUES (1, 1, 3),
       (1, 3, 7),
       (1, 4, 2),
       (2, 1, 1),
       (3, 1, 8),
       (2, 5, 4),
       (2, 3, 3);

SELECT *
FROM Orders
ORDER BY oDate DESC;

SELECT pName, pPrice
FROM Product
WHERE 1 = 1
  AND pPrice = (SELECT MAX(pPrice) FROM Product);

SELECT Name, pName
FROM Customer
         JOIN OrderDetail
         JOIN Product ON OrderDetail.pID = Product.pID
         JOIN Orders ON Customer.cID = Orders.cID AND OrderDetail.oID = Orders.oID;

SELECT Name
FROM Customer
WHERE Customer.cID != ALL (SELECT cID FROM Orders);

SELECT Orders.oID, oDate, odQTY, pName, pPrice
FROM Orders
         JOIN OrderDetail ON Orders.oID = OrderDetail.oID
         JOIN Product ON Product.pID = OrderDetail.pID;

SELECT Orders.oID, oDate, SUM((odQTY * pPrice)) AS Total
FROM Orders
         JOIN OrderDetail ON Orders.oID = OrderDetail.oID
         JOIN Product ON Product.pID = OrderDetail.pID
GROUP BY Orders.oID;

CREATE VIEW Sales AS
SELECT SUM((odQTY * pPrice)) AS Sales
FROM Orders
         JOIN OrderDetail ON Orders.oID = OrderDetail.oID
         JOIN Product ON Product.pID = OrderDetail.pID;

ALTER TABLE Customer
    MODIFY cID INT;
ALTER TABLE Customer
    DROP PRIMARY KEY;

ALTER TABLE Orders
    MODIFY oID INT;
ALTER TABLE Orders
    DROP PRIMARY KEY;
ALTER TABLE Orders
    DROP FOREIGN KEY customer_id;

ALTER TABLE Product
    MODIFY pID INT;
ALTER TABLE Product
    DROP PRIMARY KEY;

ALTER TABLE OrderDetail
    DROP PRIMARY KEY;
ALTER TABLE OrderDetail
    DROP FOREIGN KEY order_id;
ALTER TABLE OrderDetail
    DROP FOREIGN KEY product_id;

CREATE TRIGGER cusUpdate
    AFTER UPDATE
    ON Customer
    FOR EACH ROW
BEGIN
    UPDATE Orders SET cID = NEW.cID WHERE cID = OLD.cID;
END;

UPDATE Customer SET cID = 1 WHERE cID=10;

CREATE PROCEDURE delProduct (IN TenSP VARCHAR(25))
BEGIN
    DELETE FROM Product WHERE pName = TenSP;
END;

CALL delProduct('Quat');

SELECT * FROM Product;
