CREATE DATABASE Chuong6_4;
USE Chuong6_4;

CREATE TABLE Customers
(
    MaKhach     INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Ten         NVARCHAR(30) NOT NULL,
    SoDienThoai VARCHAR(20)
);

CREATE TABLE Items
(
    MaHang  INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Ten     NVARCHAR(30) NOT NULL,
    SoLuong INT,
    DonGia  INT
);

CREATE TABLE CustomerItem
(
    MaKhach INT NOT NULL,
    MaHang  INT NOT NULL,
    SoLuong INT,
    PRIMARY KEY (MaKhach, MaHang),
    CONSTRAINT ma_khach FOREIGN KEY (MaKhach) REFERENCES Customers (MaKhach),
    CONSTRAINT ma_hang FOREIGN KEY (MaHang) REFERENCES Items (MaHang)
);

INSERT INTO Items (Ten, SoLuong, DonGia)
VALUES (N'Tủ lạnh', 5, 3500),
       (N'Ti vi', 2, 3000),
       (N'Điều hoà', 1, 8000),
       (N'Quạt da', 5, 1700),
       (N'Máy giặt', 3, 5000);

INSERT INTO Customers (Ten, SoDienThoai)
VALUES (N'Đinh Trường Sơn', 1234567),
       (N'Mai Thanh Minh', 1357999),
       (N'Nguyễn Hồng Hà', 2468888);

INSERT INTO CustomerItem
SELECT Customers.MaKhach, Items.MaHang, 4
FROM Customers,
     Items
WHERE Customers.Ten = N'Đinh Trường Sơn'
  AND Items.Ten = N'Tủ lạnh';

INSERT INTO CustomerItem
SELECT Customers.MaKhach, Items.MaHang, 1
FROM Customers,
     Items
WHERE Customers.Ten = N'Đinh Trường Sơn'
  AND Items.Ten = N'Máy giặt';

INSERT INTO CustomerItem
SELECT Customers.MaKhach, Items.MaHang, 1
FROM Customers,
     Items
WHERE Customers.Ten = N'Mai Thanh Minh'
  AND Items.Ten = N'Ti vi';

INSERT INTO CustomerItem
SELECT Customers.MaKhach, Items.MaHang, 1
FROM Customers,
     Items
WHERE Customers.Ten = N'Nguyễn Hồng Hà'
  AND Items.Ten = N'Điều hoà';

INSERT INTO CustomerItem
SELECT Customers.MaKhach, Items.MaHang, 1
FROM Customers,
     Items
WHERE Customers.Ten = N'Nguyễn Hồng Hà'
  AND Items.Ten = N'Tủ lạnh';