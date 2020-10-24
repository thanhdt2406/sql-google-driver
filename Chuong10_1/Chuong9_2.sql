CREATE DATABASE CHUONG9_2;
USE CHUONG9_2;

CREATE TABLE Khoa
(
    k_ID  INT PRIMARY KEY AUTO_INCREMENT,
    k_Ten VARCHAR(20) NOT NULL
);

CREATE TABLE Lop
(
    l_ID   INT PRIMARY KEY AUTO_INCREMENT,
    l_Ten  VARCHAR(20) NOT NULL,
    l_Khoa INT         NOT NULL,
    CONSTRAINT FOREIGN KEY (l_Khoa) REFERENCES Khoa (k_ID)
);

CREATE TABLE SinhVien
(
    sv_Maso     INT PRIMARY KEY AUTO_INCREMENT,
    sv_Hodem    VARCHAR(30) NOT NULL,
    sv_Ten      VARCHAR(15) NOT NULL,
    sv_NgaySinh DATETIME,
    sv_Lop      INT         NOT NULL,
    sv_DiemTB   DOUBLE(3, 1),
    CONSTRAINT FOREIGN KEY (sv_Lop) REFERENCES Lop (l_ID)
);

INSERT INTO Khoa (k_Ten)
VALUES ('CNTT'),
       ('Quoc Te'),
       ('Toan Tin'),
       ('Dien Tu');

INSERT INTO Lop (l_Ten, l_Khoa)
VALUES ('CNTT1', 1),
       ('CNTT2', 1),
       ('CNTT3', 1),
       ('QT1', 2),
       ('QT2', 2),
       ('TT1', 3),
       ('TT2', 3),
       ('DT1', 4),
       ('DT2', 4),
       ('DT3', 4);

INSERT INTO SinhVien (sv_Hodem, sv_Ten, sv_NgaySinh, sv_Lop, sv_DiemTB)
VALUES ('Minahil ', 'Roberts', '1990-06-05', 1, 2.8),
       ('Elisa ', 'Hull', '1992-05-06', 2, 5.1),
       ('Kian ', 'Foreman', '1992-12-27', 7, 2.0),
       ('Victor ', 'Dean', '1993-07-31', 4, 2.8),
       ('Ammar ', 'Wilcox', '1996-04-25', 5, 0.9),
       ('Clive ', 'Bonilla', '1997-03-12', 8, 3.2),
       ('Ioan ', 'Donovan', '1998-06-22', 2, 3.5),
       ('Vlad ', 'Krueger', '1999-09-13', 3, 3.9),
       ('Mila ', 'Gordon', '2000-08-19', 9, 8.7),
       ('Tre ', 'Weir', '2000-12-31', 6, 3.5);

--	Liệt kê danh sách các sinh viên
SELECT *
FROM SinhVien;

--	Liệt kê danh sách các sinh viên (họ tên viết liền)
SELECT sv_Maso, CONCAT(sv_Hodem, sv_Ten) AS Ho_Ten, sv_NgaySinh, sv_Lop, sv_DiemTB
FROM SinhVien;

--	Liệt kê danh sách sinh viên: Mã số, họ đệm, tên, tuổi
SELECT sv_Maso, sv_Hodem, sv_Ten, (YEAR(NOW()) - YEAR(sv_NgaySinh)) AS Tuoi
FROM SinhVien;

--	Liệt kê danh sách các lớp
SELECT *
FROM Lop;

--	Liệt kê danh sách các khoa
SELECT *
FROM Khoa;

--	Tìm những sinh viên thuộc khoa CNTT
SELECT SinhVien.*
FROM SinhVien
         JOIN Lop ON sv_Lop = l_ID
         JOIN Khoa ON l_Khoa = k_ID
    AND k_Ten = 'CNTT';

--	Số lượng sinh viên loại giỏi, loại khá, loại trung bình (trong cùng 1 query)
SELECT SUM(IF(sv_DiemTB >= 8.0, 1, 0))              AS SV_GIOI,
       SUM(IF(sv_DiemTB BETWEEN 6.5 AND 7.9, 1, 0)) AS SV_KHA,
       SUM(IF(sv_DiemTB BETWEEN 5.0 AND 6.4, 1, 0)) AS SV_TB
FROM SinhVien;

--	Số lượng sinh viên loại giỏi, khá, trung bình của từng lớp (trong cùng 1 query)
SELECT sv_Lop,
       SUM(IF(sv_DiemTB >= 8.0, 1, 0))              AS SV_GIOI,
       SUM(IF(sv_DiemTB BETWEEN 6.5 AND 7.9, 1, 0)) AS SV_KHA,
       SUM(IF(sv_DiemTB BETWEEN 5.0 AND 6.4, 1, 0)) AS SV_TB
FROM SinhVien
GROUP BY sv_Lop;

--	Tên lớp, danh sách các sinh viên của lớp sắp xếp theo điểm trung bình giảm dần
SELECT l_Ten, SinhVien.*
FROM SinhVien
         JOIN Lop ON sv_Lop = l_ID
ORDER BY sv_DiemTB DESC;

--	Tên lớp, tổng số sinh viên của lớp
SELECT l_Ten, COUNT(sv_Maso) AS SO_LUONG_SV
FROM Lop
         LEFT JOIN SinhVien ON l_ID = sv_Lop
GROUP BY l_Ten;

--	Tên khoa, tổng số sinh viên của khoa
SELECT k_Ten, SUM(TEMP.SO_LUONG_SV) AS SO_LUONG_SV
FROM Khoa
         LEFT JOIN (SELECT COUNT(sv_Maso) AS SO_LUONG_SV, l_Khoa
                    FROM Lop
                             LEFT JOIN SinhVien ON l_ID = sv_Lop
                    GROUP BY l_Ten
) AS TEMP ON k_ID = TEMP.l_Khoa
GROUP BY l_Khoa;

--	Tên khoa, tên lớp, điểm trung bình của sinh viên (chú ý: liệt kê tất cả các khoa và lớp, kể cả khoa và lớp chưa có sinh viên)
SELECT k_Ten, l_Ten, SUM(sv_DiemTB) AS DIEM_TRUNG_BINH_SV
FROM Khoa
         LEFT JOIN Lop ON k_ID = l_Khoa
         LEFT JOIN SinhVien ON l_ID = sv_Lop
GROUP BY k_Ten, l_Ten;

--	Tên khoa, tên lớp, họ tên, ngày sinh, điểm trung bình của sinh viên có điểm trung bình cao nhất lớp
SELECT k_Ten, l_Ten, CONCAT(sv_Hodem, sv_Ten) AS Ho_Ten_SV, sv_NgaySinh, MAX(sv_DiemTB) AS MAX_MARK
FROM Lop
         JOIN SinhVien ON l_ID = sv_Lop
         JOIN Khoa ON k_ID = l_Khoa
GROUP BY l_ID;

--	Tên khoa, Họ tên, ngày sinh, điểm trung bình của sinh viên có điểm trung bình cao nhất khoa
SELECT k_Ten,CONCAT(sv_Hodem, sv_Ten) AS Ho_Ten_SV, sv_NgaySinh, MAX(sv_DiemTB) AS MAX_MARK
FROM Lop
         JOIN SinhVien ON l_ID = sv_Lop
         JOIN Khoa ON k_ID = l_Khoa
GROUP BY k_ID;





