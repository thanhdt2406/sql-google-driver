# # CREATE DATABASE Test2;
# USE Test2;
# #
# # CREATE TABLE Students
# # (
# #     StudentID   INT(4),
# #     StudentName NVARCHAR(50),
# #     Age         INT(4),
# #     Email       VARCHAR(100),
# #     PRIMARY KEY (StudentID)
# # );
# #
# # CREATE TABLE Subjects
# # (
# #     SubjectID   INT(4),
# #     SubjectName NVARCHAR(50),
# #     PRIMARY KEY (SubjectID)
# # );
# #
# # CREATE TABLE Marks
# # (
# #     Mark      INT(4),
# #     SubjectID INT(4),
# #     StudentID INT(4),
# #     CONSTRAINT student_id FOREIGN KEY (StudentID) REFERENCES Students (StudentID),
# #     CONSTRAINT subject_id FOREIGN KEY (SubjectID) REFERENCES Subjects (SubjectID)
# # );
# #
# # CREATE TABLE Classes
# # (
# #     ClassID   INT(4),
# #     ClassName NVARCHAR(50),
# #     PRIMARY KEY (ClassID)
# # );
# #
# # CREATE TABLE ClassStudent
# # (
# #     StudentID INT(4),
# #     ClassID   INT(4),
# #     CONSTRAINT student_id_1 FOREIGN KEY (StudentID) REFERENCES Students (StudentID),
# #     CONSTRAINT class_id FOREIGN KEY (ClassID) REFERENCES Classes (ClassID)
# # );
#
# # INSERT INTO students
# # VALUES (1, 'Nguyen Quang An', 18, 'an@yahoo.com'),
# #        (2, 'Nguyen Cong Ving', 20, 'vinh@gmail.com'),
# #        (3, 'Nguyen Van Quyen', 19, 'quyen'),
# #        (4, 'Pham Thanh Binh', 25, 'binh@com'),
# #        (5, 'Nguyen Van Tai Em', 30, 'taiem@sport.vn');
# #
# # INSERT INTO classes
# # VALUES (1, 'C0706L'),
# #        (2, 'C0708G');
# #
# # INSERT INTO classstudent
# # VALUES (1, 1),
# #        (2, 1),
# #        (3, 2),
# #        (4, 2),
# #        (5, 2);
# #
# # INSERT INTO subjects
# # VALUES (1,'SQL'),
# #        (2,'Java'),
# #        (3,'C'),
# #        (4,'Visual Basic');
# #
# # INSERT INTO marks
# # VALUES (8,1,1),
# #        (4,2,1),
# #        (9,1,1),
# #        (7,1,3),
# #        (3,1,4),
# #        (5,2,5),
# #        (8,3,3),
# #        (1,3,5),
# #        (3,2,4);
#
# -- Hien thi danh sach tat ca cac hoc vien
# SELECT *
# FROM students;
#
# -- Hien thi danh sach tat ca cac mon hoc
# SELECT *
# FROM subjects;
#
# -- Tinh diem trung binh
# SELECT AVG(Mark) AS DIEM_TRUNG_BINH
# FROM marks;
#
# -- Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
# SELECT subjects.*
# FROM subjects,
#      marks
# WHERE marks.SubjectID = subjects.SubjectID
#   AND marks.Mark = (SELECT MAX(Mark) FROM marks);
#
# -- Danh so thu tu cua diem theo chieu giam
# SELECT ROW_NUMBER() OVER (ORDER BY Mark DESC) AS STT, marks.*
# FROM marks
# ORDER BY Mark DESC;
#
# -- Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
# ALTER TABLE subjects MODIFY COLUMN SubjectName NVARCHAR(1000);
#
# -- Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
# UPDATE subjects SET SubjectName = CONCAT('Day la mon hoc ',SubjectName);
#
# -- Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
# ALTER TABLE students ADD CONSTRAINT age_check CHECK ( Age > 15 AND Age < 50 );
#
# -- Loai bo tat ca quan he giua cac bang
# ALTER TABLE classstudent DROP FOREIGN KEY class_id;
# ALTER TABLE classstudent DROP FOREIGN KEY student_id_1;
# ALTER TABLE marks DROP FOREIGN KEY student_id;
# ALTER TABLE marks DROP FOREIGN KEY subject_id;
#
# -- Xoa hoc vien co StudentID la 1
# DELETE FROM students WHERE StudentID=1;
#
# -- Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
# ALTER TABLE students ADD COLUMN Status BIT DEFAULT 1;
#
# -- Cap nhap gia tri Status trong bang Student thanh 0
# UPDATE students SET Status = 0;
#
#
