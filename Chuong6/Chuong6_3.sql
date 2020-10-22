# CREATE DATABASE Chuong6_3;
USE Chuong6_3;
#
# CREATE TABLE Student
# (
#     RN   NVARCHAR(50) NOT NULL,
#     Name NVARCHAR(30) NOT NULL,
#     Age  INT,
#     Gender BOOLEAN
# );
#
# CREATE TABLE Subjects(
#     sID NVARCHAR(20) NOT NULL ,
#     sName NVARCHAR(50) NOT NULL
# );
#
# CREATE TABLE StudentSubject(
#     RN NVARCHAR(50) NOT NULL ,
#     sID NVARCHAR(20) NOT NULL ,
#     Mark INT
# );
#
# ALTER TABLE Student ADD PRIMARY KEY (RN);
#
# ALTER TABLE Subjects ADD PRIMARY KEY (sID);
#
# ALTER TABLE studentsubject ADD CONSTRAINT mark_check CHECK ( Mark BETWEEN 0 AND 10);
#
# ALTER TABLE studentsubject ADD CONSTRAINT student_id FOREIGN KEY (RN) REFERENCES student(RN);
# ALTER TABLE studentsubject ADD CONSTRAINT subject_id FOREIGN KEY (sID) REFERENCES subjects(sID);
#
# ALTER TABLE studentsubject ADD COLUMN Date DATETIME;
#
# ALTER TABLE studentsubject DROP FOREIGN KEY subject_id;
# ALTER TABLE studentsubject DROP FOREIGN KEY student_id;
#
# ALTER TABLE student MODIFY RN INT NOT NULL AUTO_INCREMENT;
# ALTER TABLE subjects MODIFY sID INT NOT NULL AUTO_INCREMENT;
# ALTER TABLE studentsubject MODIFY RN INT NOT NULL ;
# ALTER TABLE studentsubject MODIFY sID INT NOT NULL ;
#
# INSERT INTO student(Name,Gender)
# VALUES (N'Mỹ Linh',FALSE),
#        (N'Tài Linh',FALSE),
#        (N'Mỹ Lệ',FALSE),
#        (N'Kim Tử Long',TRUE),
#        (N'Đàm Vĩnh Hưng',TRUE),
#        (N'Ngọc Oanh',NULL);
#
# INSERT INTO subjects(sName)
# VALUES ('Core Java'),
#        ('VB.Net');
# INSERT INTO subjects(sName)
# VALUES ('SQL'),
#        ('LGC'),
#        ('HTML'),
#        ('CF');
#
# DELETE FROM studentsubject WHERE Mark IS NULL ;
#
# INSERT INTO studentsubject
# SELECT RN, sID, 8, '2005728'
# FROM student,
#      subjects
# WHERE student.Name = 'Mỹ Linh'
#   AND subjects.sName = 'SQL';
#
# INSERT INTO studentsubject
# SELECT RN, sID , 3, '2005729'
# FROM student,
#      subjects
# WHERE student.Name = 'Đàm Vĩnh Hưng'
#   AND subjects.sName = 'LGC';
#
# INSERT INTO studentsubject
# SELECT RN, sID,9,'2005731'
# FROM student,
#      subjects
# WHERE student.Name = 'Kim Tử Long'
#   AND subjects.sName = 'HTML';
#
# INSERT INTO studentsubject
# SELECT RN, sID,5,'2005730'
# FROM student,
#      subjects
# WHERE student.Name = 'Tài Linh'
#   AND subjects.sName = 'SQL';
#
# INSERT INTO studentsubject
# SELECT RN, sID,10,'2005719'
# FROM student,
#      subjects
# WHERE student.Name = 'Mỹ Lệ'
#   AND subjects.sName = 'CF';
#
# INSERT INTO studentsubject
# SELECT RN, sID,9,'2005725'
# FROM student,
#      subjects
# WHERE student.Name = 'Ngọc Oanh'
#   AND subjects.sName = 'SQL';
#
# UPDATE student SET Age = 19 WHERE Name IN ('Mỹ Linh','Kim Tử Long');
# UPDATE student SET Age = 20 WHERE Name IN ('Tài Linh','Đàm Vĩnh Hưng');
# UPDATE student SET Age = 21 WHERE Name IN ('Mỹ Lệ','Ngọc Oanh');
#

SELECT 
FROM student;

SELECT COUNT() AS SO_LUONG_HOC_VIEN
FROM student;

SELECT 
FROM subjects;

SELECT COUNT() AS SO_HV_CO_DIEM_THI_TREN_5
FROM (
         SELECT DISTINCT RN
         FROM studentsubject
         WHERE Mark  5
     ) AS TEMP;

SELECT AVG(Mark) AS DIEM_THI_TRUNG_BINH
FROM studentsubject;

SELECT subjects., (TEMP.Mark  TEMP.SO_LUONG_HV) AS DIEM_TRUNG_BINH
FROM subjects,
     (
         SELECT sID, SUM(Mark) AS Mark, SUM(1) AS SO_LUONG_HV
         FROM studentsubject
         GROUP BY sID) AS TEMP
WHERE TEMP.sID = subjects.sID;

SELECT  FROM student WHERE Age = 20 AND Gender = TRUE;

SELECT RN,sID,Mark FROM studentsubject WHERE Mark = (SELECT MAX(Mark) FROM studentsubject);

SELECT  FROM studentsubject
ORDER BY Mark DESC
LIMIT 2;

SELECT Mark,Date FROM studentsubject WHERE Mark = (SELECT MAX(Mark) FROM studentsubject);



