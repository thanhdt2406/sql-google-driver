CREATE DATABASE Chuong10_2;
USE Chuong10_2;

-- Tạo bảng
CREATE TABLE Student
(
    RN   INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(20),
    Age  TINYINT
);

CREATE TABLE test
(
    TestID INT PRIMARY KEY AUTO_INCREMENT,
    Name   VARCHAR(20)
);

CREATE TABLE StudentTest
(
    RN     INT,
    TestID INT,
    Date   DATETIME,
    Mark   FLOAT
);

-- Chèn dữ liệu
INSERT INTO Student (Name, Age)
VALUES ('Nguyen Hong Ha', 20),
       ('Truong Ngoc Anh', 30),
       ('Tuan Minh', 25),
       ('Dan Truong', 22);

INSERT INTO Test(Name)
VALUES ('EPC'),
       ('DWMX'),
       ('SQL1'),
       ('SQL2');

INSERT INTO StudentTest
VALUES (1, 1, '2006/7/17', 8),
       (1, 2, '2006/7/18', 5),
       (1, 3, '2006/7/19', 7),
       (2, 1, '2006/7/17', 7),
       (2, 2, '2006/7/18', 4),
       (2, 3, '2006/7/19', 2),
       (3, 1, '2006/7/17', 10),
       (3, 3, '2006/7/18', 1);

-- Sử dụng alter để sửa đổi
ALTER TABLE Student
    ADD CONSTRAINT age_check CHECK ( Age BETWEEN 15 AND 55);

ALTER TABLE StudentTest
    ALTER Mark SET DEFAULT 0;

ALTER TABLE StudentTest
    ADD PRIMARY KEY (RN, TestID);

ALTER TABLE test
    ADD CONSTRAINT name_unique UNIQUE (Name);

# ALTER TABLE test
#     DROP CONSTRAINT name_unique;

-- Hiển thị danh sách các học viên đã tham gia thi
SELECT Student.Name AS 'Student Name', test.name AS 'Test Name', Mark, Date
FROM StudentTest
         JOIN Student ON Student.RN = StudentTest.RN
         JOIN test ON test.TestID = StudentTest.TestID;

-- Hiển thị danh sách các bạn học viên chưa thi môn nào
SELECT *
FROM Student
WHERE Student.RN != ALL (SELECT RN FROM StudentTest);

-- Hiển thị danh sách học viên phải thi lại, tên môn học phải thi lại và điểm thi(điểm phải thi lại là điểm nhỏ hơn 5)
SELECT Student.Name AS 'Student Name', Test.Name AS 'Test Name', Mark, Date
FROM StudentTest
         JOIN Student ON StudentTest.RN = Student.RN
         JOIN Test ON StudentTest.TestID = test.TestID
    AND StudentTest.Mark < 5;

-- Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi. Danh sách phải sắp xếp theo thứ tự điểm trung bình giảm dần.
SELECT Student.Name AS 'Student Name', AVG(Mark) AS Average
FROM Student
         JOIN studenttest ON Student.RN = StudentTest.RN
GROUP BY Student.RN
ORDER BY Average DESC;

-- Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất
SELECT Student.Name AS 'Student Name', AVG(Mark) AS Average
FROM Student
         JOIN StudentTest ON StudentTest.RN = Student.RN
GROUP BY StudentTest.RN
HAVING AVG(Mark) = (SELECT AVG(Mark) AS Average
                    FROM Student
                             JOIN studenttest ON Student.RN = StudentTest.RN
                    GROUP BY Student.RN
                    ORDER BY Average DESC
                    LIMIT 1);

-- Hiển thị điểm thi cao nhất của từng môn học. Danh sách phải được sắp xếp theo tên môn học
SELECT Test.Name AS 'Test Name', MAX(Mark) AS 'Max Mark'
FROM test
         JOIN studenttest ON test.TestID = studenttest.TestID
GROUP BY StudentTest.TestID;

-- Hiển thị danh sách tất cả các học viên và môn học mà các học viên đó đã thi nếu học viên chưa thi môn nào thì phần tên môn học để Null
SELECT Student.*, Test.Name AS 'Test Name'
From Student
         LEFT JOIN StudentTest ON StudentTest.RN = Student.RN
         LEFT JOIN test ON StudentTest.TestID = test.TestID;

-- Sửa (Update) tuổi của tất cả các học viên mỗi người lên một tuổi.
UPDATE Student
SET Age = Age + 1;

-- Thêm trường tên là Status có kiểu Varchar(10) vào bảng Student
ALTER TABLE Student
    ADD COLUMN Status VARCHAR(10);

-- Cập nhật(Update) trường Status sao cho những học viên nhỏ hơn 30 tuổi sẽ nhận giá trị ‘Young’, trường hợp còn lại nhận giá trị ‘Old’ sau đó hiển thị toàn bộ nội dung bảng Student lên
UPDATE Student
SET Status = IF(Age < 30, 'Young', 'Old');
SELECT *
FROM Student;

-- Hiển thị danh sách học viên và điểm thi, dánh sách phải sắp xếp tăng dần theo ngày thi
SELECT Student.Name AS 'Student Name', test.name AS 'Test Name', Mark, Date
FROM StudentTest
         JOIN Student ON Student.RN = StudentTest.RN
         JOIN test ON test.TestID = StudentTest.TestID
ORDER BY Date ASC;

-- Hiển thị các thông tin sinh viên có tên bắt đầu bằng ký tự ‘T’ và điểm thi trung bình >4.5. Thông tin bao gồm Tên sinh viên, tuổi, điểm trung bình
SELECT Student.Name, AVG(Mark) AS Average
FROM Student
         JOIN studenttest ON Student.RN = StudentTest.RN
    AND Student.Name LIKE 'T%'
GROUP BY StudentTest.RN
HAVING Average > 4.5;

-- Hiển thị các thông tin sinh viên (Mã, tên, tuổi, điểm trung bình, xếp hạng). Trong đó, xếp hạng dựa vào điểm trung bình của học viên, điểm trung bình cao nhất thì xếp hạng 1.
SELECT Student.Name AS 'Student Name', AVG(Mark) AS Average, (RANK() OVER (ORDER BY AVG(Mark) DESC )) AS RANKING
FROM Student
         JOIN studenttest ON Student.RN = StudentTest.RN
GROUP BY Student.RN
ORDER BY Average DESC;

-- Sủa đổi kiểu dữ liệu cột name trong bảng student thành nvarchar(max)
ALTER TABLE Student
    MODIFY COLUMN Name NVARCHAR(1000);

/* Cập nhật (sử dụng phương thức write) cột name trong bảng student với yêu cầu sau:
Nếu tuổi >20 -> thêm ‘Old’ vào trước tên (cột name)
Nếu tuổi <=20 thì thêm ‘Young’ vào trước tên (cột name)
*/
UPDATE Student
SET Name = IF(Age > 20, CONCAT('Old ', Name), CONCAT('Young ', Name));

-- Xóa tất cả các môn học chưa có bất kỳ sinh viên nào thi
DELETE FROM test WHERE TestID != ALL(SELECT TestID FROM StudentTest);

-- Xóa thông tin điểm thi của sinh viên có điểm <5.
DELETE
FROM Student
WHERE Student.RN IN (SELECT RN FROM StudentTest WHERE Mark < 5);