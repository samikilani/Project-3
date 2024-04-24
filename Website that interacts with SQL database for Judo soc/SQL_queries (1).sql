USE SOCIETY;

-- Query 5.1: Count the number of memberships for each belt rank
SELECT Belt_Rank, COUNT(*) AS NumberOfMemberships
FROM Membership
GROUP BY Belt_Rank;

-- Query 5.2: Select all instructors who have taught more than 1 class
SELECT * 
FROM Instructor 
WHERE Instructor_ID IN (
    SELECT Instructor_ID 
    FROM Class
    GROUP BY Instructor_ID
    HAVING COUNT(*) > 1
);

-- Query 5.3: Retrieve details of each class along with the name of the instructor
SELECT Class.Class_ID, Instructor.F_Name, Instructor.L_Name
FROM Class
JOIN Instructor ON Class.Instructor_ID = Instructor.Instructor_ID;

-- Query 5.4: Retrieve all class details along with judo team name and session moves
SELECT Class.Class_ID, JudoTeam.Team_Name, Session.Judo_Moves
FROM Class
JOIN JudoTeam ON Class.Team_ID = JudoTeam.Team_ID
JOIN Session ON Class.Session_ID = Session.Session_ID;


----Advanced Tasks/ Challenges 2 Queries

--. Students and Their Preferred Hobbies
 SELECT     s.URN,     s.Stu_FName,     s.Stu_LName,     GROUP_CONCAT(h.Hobby_Name) AS Hobbies FROM     Student s JOIN     StudentHobby sh ON s.URN = sh.URN JOIN     
 Hobby h ON sh.Hobby_ID = h.Hobby_ID GROUP BY     s.URN,     s.Stu_FName,     s.Stu_LName;


-- Find Teams with the Most Diverse Set of Sessions
SELECT     t.Team_ID,     t.Team_Name,     COUNT(DISTINCT c.Session_ID) AS NumberOfUniqueSessions FROM     JudoTeam t JOIN
  Class c ON t.Team_ID = c.Team_ID GROUP BY     t.Team_ID,     t.Team_Name ORDER BY     NumberOfUniqueSessions DESC;
