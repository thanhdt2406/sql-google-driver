# # CREATE DATABASE Chuong8;
# USE Chuong8;
# # -- Tao cau truc bang
# # CREATE TABLE Class
# # (
# #     ClassID   INT            NOT NULL PRIMARY KEY AUTO_INCREMENT,
# #     ClassName NVARCHAR(1000) NOT NULL,
# #     StartDate DATETIME       NOT NULL,
# #     Status    BIT
# # );
# #
# # -- bang Student
# # CREATE TABLE Student
# # (
# #     StudentID   INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
# #     StudentName NVARCHAR(30) NOT NULL,
# #     Address     NVARCHAR(50),
# #     Phone       VARCHAR(20),
# #     Status      BIT,
# #     ClassID     INT          NOT NULL
# # );
# #
# # -- Bang subject
# # CREATE TABLE Subject
# # (
# #     SubID   INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
# #     SubName NVARCHAR(30) NOT NULL,
# #     Credit  TINYINT      NOT NULL DEFAULT 1 CHECK (Credit >= 1),
# #     Status  BIT                   DEFAULT 1
# # );
# # -- Bang Mark
# # CREATE TABLE Mark
# # (
# #     MarkID    INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
# #     SubID     INT NOT NULL,
# #     StudentID INT NOT NULL,
# #     Mark      FLOAT   DEFAULT 0 CHECK (Mark BETWEEN 0 AND 100),
# #     ExamTimes TINYINT DEFAULT 1,
# #     UNIQUE (SubID, StudentID)
# # );
# #
# # -- 3.
# # -- a.	Thêm ràng buộc khóa ngoại trên cột ClassID của  bảng Student, tham chiếu đến cột ClassID trên bảng Class.
# # ALTER TABLE Student
# #     ADD CONSTRAINT class_id FOREIGN KEY (ClassID) REFERENCES Class (ClassID);
# #
# # -- b.	Thêm ràng buộc cho cột StartDate của  bảng Class là ngày hiện hành.
# # ALTER TABLE Class
# #     MODIFY StartDate DATETIME DEFAULT NOW();
# #
# # -- c.Thêm ràng buộc mặc định cho cột Status của bảng Student là 1.
# # ALTER TABLE Student
# #     ALTER Status SET DEFAULT 1;
# #
# # -- d.Thêm ràng buộc khóa ngoại cho bảng Mark trên cột:
# # -- SubID trên bảng Mark tham chiếu đến cột SubID trên bảng Subject
# # -- StudentID tren bảng Mark tham chiếu đến cột StudentID của bảng Student.
# # ALTER TABLE MARK
# #     ADD CONSTRAINT sub_id FOREIGN KEY (SubID) REFERENCES Subject (SubID);
# # ALTER TABLE MARK
# #     ADD CONSTRAINT student_id FOREIGN KEY (StudentID) REFERENCES Student (StudentID);
# #
# # -- 4.
# # INSERT INTO Class (ClassName, StartDate, Status)
# # VALUES ('A1', '2008/12/20', 1),
# #        ('A2', '2008/12/22', 1),
# #        ('B3', DEFAULT, 0);
# #
# # INSERT INTO Student (StudentName, Address, Phone, Status, ClassID)
# # VALUES ('Hung', 'Ha noi', '0912113113', 1, 1),
# #        ('Hoa', 'Hai phong', NULL, 1, 1),
# #        ('Manh', 'HCM', '0123123123', 0, 2);
# #
# # INSERT INTO Subject (SubName, Credit, Status)
# # VALUES ('CF', 5, 1),
# #        ('C', 6, 1),
# #        ('HDJ', 5, 1),
# #        ('RDBMS', 10, 1);
# #
# # INSERT INTO Mark (SubID, StudentID, Mark, ExamTimes)
# # VALUES (1, 1, 8, 1),
# #        (1, 2, 10, 2),
# #        (2, 1, 12, 1);
# #
# # UPDATE student
# # SET ClassID = 2
# # WHERE StudentName = N'Hung';
# # UPDATE student
# # SET Phone = 'No phone'
# # WHERE Phone IS NULL;
# # UPDATE class
# # SET ClassName = CONCAT('New ', ClassName)
# # WHERE Status = 0;
# # UPDATE class
# # SET ClassName = REPLACE(ClassName, 'New ', 'Old ')
# # WHERE Status = 1
# #   AND ClassName LIKE 'New%';
# #
# # UPDATE class
# # SET Status = 0
# # WHERE NOT ClassID IN (
# #     SELECT DISTINCT student.ClassID
# #     FROM student);
# #
# # UPDATE class
# # SET Status = 0
# # WHERE ClassID = (
# #     SELECT DISTINCT student.ClassID
# #     FROM student
# #     WHERE student.StudentID != ALL (SELECT mark.StudentID FROM mark)
# # );
# #
# SELECT *
# FROM student
# WHERE 1 = 1
#   AND StudentName LIKE N'H%';
# 
# SELECT *
# FROM class
# WHERE 1 = 1
#   AND MONTH(StartDate) = 12;
# 
# SELECT Credit
# FROM subject
# WHERE 1 = 1
#   AND Credit = (SELECT MAX(Credit) FROM subject);
# 
# SELECT *
# FROM subject
# WHERE 1 = 1
#   AND Credit = (SELECT MAX(Credit) FROM subject);
# 
# SELECT *
# FROM subject
# WHERE 1 = 1
#   AND Credit BETWEEN 3 AND 5;
# 
# SELECT class.ClassID, ClassName, StudentName, Address
# FROM class
#          JOIN student ON 1 = 1
#     AND class.ClassID = student.ClassID;
# 
# SELECT *
# FROM subject
# WHERE 1 = 1
#   AND SubID != ALL (SELECT SubID FROM mark);
# 
# SELECT subject.*, Mark
# FROM subject
#          JOIN mark ON 1 = 1
#     AND subject.SubID = mark.SubID
#     AND Mark = (SELECT MAX(Mark) FROM mark);
# 
# SELECT student.*, (TEMP.TOTAL_MARK / TEMP.EXAM_TIMES) AS AVG_MARK
# FROM student
#          LEFT JOIN (
#     SELECT StudentID, SUM(Mark) AS TOTAL_MARK, SUM(ExamTimes) AS EXAM_TIMES
#     FROM mark
#     GROUP BY StudentID
# ) AS TEMP
#                    ON 1 = 1
#                        AND TEMP.StudentID = student.StudentID;
# 
# SELECT RANK() OVER (ORDER BY TEMP.TOTAL_MARK / TEMP.EXAM_TIMES DESC ) AS RANKING,
#        student.*,
#        (TEMP.TOTAL_MARK / TEMP.EXAM_TIMES)                            AS AVG_MARK
# FROM student
#          LEFT JOIN (
#     SELECT StudentID, SUM(Mark) AS TOTAL_MARK, SUM(ExamTimes) AS EXAM_TIMES
#     FROM mark
#     GROUP BY StudentID
# ) AS TEMP
#                    ON 1 = 1
#                        AND TEMP.StudentID = student.StudentID;
# 
# SELECT student.*, (TEMP.TOTAL_MARK / TEMP.EXAM_TIMES) AS AVG_MARK
# FROM student
#          JOIN (
#     SELECT StudentID, SUM(Mark) AS TOTAL_MARK, SUM(ExamTimes) AS EXAM_TIMES
#     FROM mark
#     GROUP BY StudentID
# ) AS TEMP
#               ON 1 = 1
#                   AND TEMP.StudentID = student.StudentID
#                   AND (TEMP.TOTAL_MARK / TEMP.EXAM_TIMES) > 10;
# 
# SELECT StudentName, SubName, Mark
# FROM mark
#          JOIN subject ON 1 = 1 AND subject.SubID = mark.SubID
#          JOIN student ON student.StudentID = mark.StudentID
# ORDER BY Mark DESC, StudentName ASC;
# 
# ALTER TABLE student
#     DROP FOREIGN KEY class_id;
# DELETE
# FROM class
# Where Status = 0;
# 
# ALTER TABLE mark
#     DROP FOREIGN KEY sub_id;
# DELETE
# FROM subject
# WHERE 1 = 1
#   AND SubID != ALL (SELECT SubID FROM mark);
# 
# ALTER TABLE mark DROP COLUMN ExamTimes;
# 
# ALTER TABLE class CHANGE COLUMN Status ClassStatus BIT;
# 
# RENAME TABLE mark TO SubjectTest;
# 
# DROP DATABASE Chuong8;