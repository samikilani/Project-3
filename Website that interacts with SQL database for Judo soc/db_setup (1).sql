DROP DATABASE IF EXISTS SOCIETY;

CREATE DATABASE SOCIETY;

USE SOCIETY;

DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
URN INT UNSIGNED NOT NULL,
Stu_FName 	VARCHAR(255) NOT NULL,
Stu_LName 	VARCHAR(255) NOT NULL,
Stu_DOB 	DATE,
Stu_Phone 	VARCHAR(12),
Stu_Type 	ENUM('UG', 'PG'),
stu_email   VARCHAR(255) NOT NULL,
PRIMARY KEY (URN));

INSERT INTO Student (URN, Stu_FName, Stu_LName, Stu_DOB, Stu_Phone, Stu_Type, stu_email) VALUES
(612345, 'Sara', 'Khan', '2002-06-20', '01483112233', 'UG', 'sara.khan612345@surrey.ac.uk'),
(612346, 'Pierre', 'Gervais', '2002-03-12', '01483223344', 'UG', 'pierre.gervais612346@surrey.ac.uk'),
(612347, 'Patrick', 'O-Hara', '2001-05-03', '01483334455', 'UG', 'patrick.o-hara612347@surrey.ac.uk'),
(612348, 'Iyabo', 'Ogunsola', '2002-04-21', '01483445566', 'UG', 'iyabo.ogunsola612348@surrey.ac.uk'),
(612349, 'Omar', 'Sharif', '2001-12-29', '01483778899', 'UG', 'omar.sharif612349@surrey.ac.uk'),
(612350, 'Yunli', 'Guo', '2002-06-07', '01483123456', 'UG', 'yunli.guo612350@surrey.ac.uk'),
(612351, 'Costas', 'Spiliotis', '2002-07-02', '01483234567', 'UG', 'costas.spiliotis612351@surrey.ac.uk'),
(612352, 'Tom', 'Jones', '2001-10-24', '01483456789', 'UG', 'tom.jones612352@surrey.ac.uk'),
(612353, 'Simon', 'Larson', '2002-08-23', '01483998877', 'UG', 'simon.larson612353@surrey.ac.uk'),
(612354, 'Sue', 'Smith', '2002-05-16', '01483776655', 'UG', 'sue.smith612354@surrey.ac.uk'),
(612557, 'Sami', 'Kilani', '2002-05-16', '01484356464', 'PG', 'sami.kilani612557@surrey.ac.uk'),
(612945, 'omar', 'Khan', '2001-06-20', '01493112233', 'UG', 'omar.khan612945@surrey.ac.uk');



DROP TABLE IF EXISTS Undergraduate;

CREATE TABLE Undergraduate (
UG_URN 	INT UNSIGNED NOT NULL,
UG_Credits   INT NOT NULL,
CHECK (60 <= UG_Credits <= 150),
PRIMARY KEY (UG_URN),
FOREIGN KEY (UG_URN) REFERENCES Student(URN)
ON DELETE CASCADE);

INSERT INTO Undergraduate VALUES
(612345, 120),
(612346, 90),
(612347, 150),
(612348, 120),
(612349, 120),
(612350, 60),
(612351, 60),
(612352, 90),
(612353, 120),
(612354, 90);

DROP TABLE IF EXISTS Postgraduate;

CREATE TABLE Postgraduate (
PG_URN 	INT UNSIGNED NOT NULL,
Thesis  VARCHAR(512) NOT NULL,
PRIMARY KEY (PG_URN),
FOREIGN KEY (PG_URN) REFERENCES Student(URN)
ON DELETE CASCADE);

INSERT INTO Postgraduate VALUES
(612557, 'Exploring Advanced Robotics');

DROP TABLE IF EXISTS Instructor;

CREATE TABLE Instructor (
    Instructor_ID INT PRIMARY KEY,
    F_Name VARCHAR(255) NOT NULL,
    L_Name VARCHAR(255) NOT NULL,
    Belt_Rank ENUM('White', 'Yellow', 'Orange', 'Green', 'Blue', 'Brown', 'Black')
);

INSERT INTO Instructor (Instructor_ID, F_Name, L_Name, Belt_Rank) VALUES (1, 'John', 'Doe', 'Black');
INSERT INTO Instructor (Instructor_ID, F_Name, L_Name, Belt_Rank) VALUES (2, 'Jane', 'Smith', 'Brown');
INSERT INTO Instructor (Instructor_ID, F_Name, L_Name, Belt_Rank) VALUES (3, 'Emily', 'Johnson', 'Black');
INSERT INTO Instructor (Instructor_ID, F_Name, L_Name, Belt_Rank) VALUES (4, 'Mike', 'Davis', 'Blue');
INSERT INTO Instructor (Instructor_ID, F_Name, L_Name, Belt_Rank) VALUES (5, 'Anne', 'Wilson', 'Green');

DROP TABLE IF EXISTS InstructorQualifications;

CREATE TABLE InstructorQualifications (
    Instructor_ID INT NOT NULL,
    Qualification VARCHAR(255) NOT NULL,
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID)
);

INSERT INTO InstructorQualifications (Instructor_ID, Qualification) VALUES
(1, 'Certified Judo Teacher'),
(1, 'Advanced Coaching Certificate'),
(2, 'Judo Champion'),
(2, 'National Competition Winner'),
(3, 'Senior Judo Instructor'),
(3, 'Judo Theory Expert'),
(4, 'Judo Sensei'),
(4, 'Technical Judo Specialist'),
(5, 'Judo Expert'),
(5, 'Black Belt Achiever');



DROP TABLE IF EXISTS JudoTeam;

CREATE TABLE JudoTeam (
    Team_ID INT UNSIGNED NOT NULL, 
    Team_Name VARCHAR(255),
    Team_Email VARCHAR(255),
    PRIMARY KEY (Team_ID)
);

INSERT INTO JudoTeam (Team_ID, Team_Name, Team_Email) VALUES (101, 'Judo Warriors', 'warriors@judo.com');
INSERT INTO JudoTeam (Team_ID, Team_Name, Team_Email) VALUES (102, 'Judo Dragons', 'dragons@judo.com');
INSERT INTO JudoTeam (Team_ID, Team_Name, Team_Email) VALUES (103, 'Judo Eagles', 'eagles@judo.com');
INSERT INTO JudoTeam (Team_ID, Team_Name, Team_Email) VALUES (104, 'Judo Tigers', 'tigers@judo.com');
INSERT INTO JudoTeam (Team_ID, Team_Name, Team_Email) VALUES (105, 'Judo Sharks', 'sharks@judo.com');


DROP TABLE IF EXISTS Session;

CREATE TABLE Session (
    Session_ID INT PRIMARY KEY,
    Judo_Moves VARCHAR(255),
    Date DATE
);

INSERT INTO Session (Session_ID, Judo_Moves, Date) VALUES (1, 'O Goshi', '2023-01-01');
INSERT INTO Session (Session_ID, Judo_Moves, Date) VALUES (2, 'Uki Goshi', '2023-01-08');
INSERT INTO Session (Session_ID, Judo_Moves, Date) VALUES (3, 'Harai Goshi', '2023-01-15');
INSERT INTO Session (Session_ID, Judo_Moves, Date) VALUES (4, 'Koshi Guruma', '2023-01-22');
INSERT INTO Session (Session_ID, Judo_Moves, Date) VALUES (5, 'Tsuri Goshi', '2023-01-29');
INSERT INTO Session (Session_ID, Judo_Moves, Date) VALUES (6, 'Kesa Gatame', '2023-04-15');
INSERT INTO Session (Session_ID, Judo_Moves, Date) VALUES (7, 'Seoi Nage', '2023-04-22');
INSERT INTO Session (Session_ID, Judo_Moves, Date) VALUES (8, 'Uchi Mata', '2023-04-29');
INSERT INTO Session (Session_ID, Judo_Moves, Date) VALUES (9, 'Ouchi Gari', '2023-05-06');
INSERT INTO Session (Session_ID, Judo_Moves, Date) VALUES (10, 'Kouchi Gari', '2023-05-13');

DROP TABLE IF EXISTS Hobby;

CREATE TABLE Hobby (
    Hobby_ID INT PRIMARY KEY,
    Hobby_Name VARCHAR(255) NOT NULL,
    Recommended_Hobby_ID INT,
    FOREIGN KEY (Recommended_Hobby_ID) REFERENCES Hobby(Hobby_ID)
);

INSERT INTO Hobby (Hobby_ID, Hobby_Name) VALUES (1, 'Reading');
INSERT INTO Hobby (Hobby_ID, Hobby_Name) VALUES (2, 'Painting');
INSERT INTO Hobby (Hobby_ID, Hobby_Name) VALUES (3, 'Cycling');
INSERT INTO Hobby (Hobby_ID, Hobby_Name) VALUES (4, 'Photography');
INSERT INTO Hobby (Hobby_ID, Hobby_Name) VALUES (5, 'Cooking');

DROP TABLE IF EXISTS Membership;

CREATE TABLE Membership(
    Membership_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    Date_Joined DATE NOT NULL,
    Monthly_Fee INT UNSIGNED DEFAULT 50,  
    Belt_Rank ENUM('White', 'Yellow', 'Orange', 'Green', 'Blue', 'Brown', 'Black'),
    Student_ID INT UNSIGNED NOT NULL UNIQUE,
    Team_ID INT UNSIGNED NOT NULL,  
    PRIMARY KEY (Membership_ID),
    FOREIGN KEY (Student_ID) REFERENCES Student(URN) ON DELETE RESTRICT,
    FOREIGN KEY (Team_ID) REFERENCES JudoTeam(Team_ID) ON DELETE RESTRICT
);

INSERT INTO Membership (Date_Joined, Belt_Rank, student_ID, Team_ID) VALUES ('2023-01-01', 'White', 612345, 101);
INSERT INTO Membership (Date_Joined, Belt_Rank, student_ID, Team_ID) VALUES ('2023-02-10', 'Yellow', 612346, 102);
INSERT INTO Membership (Date_Joined, Belt_Rank, student_ID, Team_ID) VALUES ('2023-03-15', 'Orange', 612347, 103);
INSERT INTO Membership (Date_Joined, Belt_Rank, student_ID, Team_ID) VALUES ('2023-04-20', 'Green', 612348, 104);
INSERT INTO Membership (Date_Joined, Belt_Rank, student_ID, Team_ID) VALUES ('2023-05-25', 'Blue', 612349, 105);
INSERT INTO Membership (Date_Joined, Belt_Rank, Student_ID, Team_ID) VALUES ('2023-01-01', 'White', 612353, 102);

DROP TABLE IF EXISTS Class;

CREATE TABLE Class (
    Class_ID INT PRIMARY KEY AUTO_INCREMENT,
    Instructor_ID INT,
    Team_ID INT UNSIGNED NOT NULL,
    Session_ID INT,
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID),
    FOREIGN KEY (Team_ID) REFERENCES JudoTeam(Team_ID),
    FOREIGN KEY (Session_ID) REFERENCES Session(Session_ID)
);

INSERT INTO Class (Instructor_ID, Team_ID, Session_ID) VALUES (1, 101, 1);
INSERT INTO Class (Instructor_ID, Team_ID, Session_ID) VALUES (2, 102, 2);
INSERT INTO Class (Instructor_ID, Team_ID, Session_ID) VALUES (3, 103, 3);
INSERT INTO Class (Instructor_ID, Team_ID, Session_ID) VALUES (3, 103, 4);
INSERT INTO Class (Instructor_ID, Team_ID, Session_ID) VALUES (4, 104, 5);
INSERT INTO Class (Instructor_ID, Team_ID, Session_ID) VALUES (5, 105, 6);

DROP TABLE IF EXISTS StudentHobby;

CREATE TABLE StudentHobby (
    URN INT UNSIGNED NOT NULL,
    Hobby_ID INT NOT NULL,
    FOREIGN KEY (URN) REFERENCES Student(URN),
    FOREIGN KEY (Hobby_ID) REFERENCES Hobby(Hobby_ID),
    PRIMARY KEY (URN, Hobby_ID)
);

INSERT INTO StudentHobby (URN, Hobby_ID) VALUES (612345, 1);
INSERT INTO StudentHobby (URN, Hobby_ID) VALUES (612346, 2); 

