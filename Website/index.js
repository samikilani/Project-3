const express = require('express');
const ejs = require('ejs');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const util = require('util');

const PORT = 8000;
const DB_HOST = 'localhost';
const DB_USER = 'root';
const DB_PASSWORD = ''; 
const DB_NAME = 'SOCIETY';
const DB_PORT = 3306;


var connection = mysql.createConnection({
    host: DB_HOST,
    user: DB_USER,
    password: DB_PASSWORD,
    database: DB_NAME,
    port: DB_PORT
});


connection.query = util.promisify(connection.query).bind(connection);

connection.connect(function (err) {
    if (err) {
        console.error('Error connecting: ' + err.stack);
        return;
    }
    console.log('Connected to the database');
});

const app = express();

app.set('view engine', 'ejs');
app.use(express.static('public'));
app.use(bodyParser.urlencoded({ extended: false }));


app.get('/', async (req, res) => {
    const memberCount = await connection.query('SELECT COUNT(*) as count FROM Membership');
    const instructorCount = await connection.query('SELECT COUNT(*) as count FROM Instructor');
    const teamCount = await connection.query('SELECT COUNT(*) as count FROM JudoTeam');
    const sessionCount = await connection.query('SELECT COUNT(*) as count FROM Session');

    res.render('index', {
        memberCount: memberCount[0].count,
        instructorCount: instructorCount[0].count,
        teamCount: teamCount[0].count,
        sessionCount: sessionCount[0].count
    });
});




app.get('/members', async (req, res) => {
    const members = await connection.query('SELECT * FROM Membership JOIN Student ON Membership.Student_ID = Student.URN');
    res.render('member_list', { members });
});


app.get('/members/view/:id', async (req, res) => {
        const memberId = req.params.id;
        const result = await connection.query(
            'SELECT Membership.*, Student.Stu_FName, Student.Stu_LName FROM Membership JOIN Student ON Membership.Student_ID = Student.URN WHERE Membership.Membership_ID = ?',
            [memberId]
        );        
            res.render('member_view', { member: result[0] });
});

app.get('/instructors', async (req, res) => {
    const instructors = await connection.query('SELECT * FROM Instructor');
    res.render('instructor_list', { instructors });
});
app.get('/instructors/view/:id', async (req, res) => {
    const instructorId = req.params.id;
    const instructorResult = await connection.query(
        'SELECT * FROM Instructor WHERE Instructor_ID = ?', 
        [instructorId]
    );
    if (instructorResult.length === 0) {
        return res.render('instructor_view', { instructor: null, qualifications: [] });
    }

    const instructor = instructorResult[0];
    const qualifications = await connection.query(
        'SELECT Qualification FROM InstructorQualifications WHERE Instructor_ID = ?',
        [instructorId]
    );
    res.render('instructor_view', { 
        instructor: instructor, 
        qualifications: qualifications 
    });
});






app.get('/teams', async (req, res) => {
    const teams = await connection.query('SELECT * FROM JudoTeam');
    res.render('team_list', { teams });
});

app.get('/sessions', async (req, res) => {
    const sessions = await connection.query('SELECT * FROM Session');
    res.render('session_list', { sessions });
});

app.get("/members/edit/:id", async (req, res) => {
        const member = await connection.query(
            "SELECT * FROM Membership WHERE Membership_ID = ?",
            [req.params.id]
        );
        if (member.length > 0) {
            res.render("member_edit", { member: member[0], message: "" });
    
    }
});
app.post("/members/edit/:id", async (req, res) => {
    try {
        await connection.query("UPDATE Membership SET ? WHERE Membership_ID = ?", [
            req.body,
            req.params.id,
        ]);

        const updatedMember = await connection.query(
            "SELECT * FROM Membership WHERE Membership_ID = ?",
            [req.params.id]
        );
        if (updatedMember.length > 0) {
            res.render("member_edit", {
                member: updatedMember[0],
                message: "Member updated successfully",
            });
        } else {
            res.redirect('/members');
        }
    } catch (error) {
        console.error(error);
        res.render("member_edit", {
            member: req.body, 
            message: "Error updating member",
        });
    }
});

app.get('/members/add', async (req, res) => {
    try {
        const eligibleStudents = await connection.query(
            'SELECT * FROM Student WHERE URN NOT IN (SELECT Student_ID FROM Membership)'
        );
        const teams = await connection.query('SELECT * FROM JudoTeam');
        res.render('member_add', { students: eligibleStudents, teams: teams, message: '' });
    } catch (error) {
        console.error(error);
        res.render('member_add', { students: [], teams: [], message: 'Error fetching data' });
    }
});

app.post('/members/add', async (req, res) => {
    try {
        const [student] = await connection.query(
            'SELECT * FROM Student WHERE URN = ? AND URN NOT IN (SELECT Student_ID FROM Membership)',
            [parseInt(req.body.Student_ID, 10)]
        );
        console.log(student); 

        if (student) {
            await connection.query('INSERT INTO Membership SET ?', [req.body]);
res.redirect('/members');
        } else {
            const teams = await connection.query('SELECT * FROM JudoTeam');
          
            res.render('member_add', { message: 'Student is not eligible or already a member', students: [], teams: [] });
        }
    } catch (error) {
        console.error(error);
        res.render('member_add', { message: 'Error adding member', students: [], teams: [] });
    }
});
app.get('/members/delete/:id', async (req, res) => {
    try {
        await connection.query('DELETE FROM Membership WHERE Membership_ID = ?', [req.params.id]);
        res.redirect('/members');
    } catch (error) {
        console.error(error);
        res.redirect('/members', { message: 'Error deleting member' });
    }
});
app.get('/members/search', async (req, res) => {
    try {
        const searchTerm = req.query.searchTerm;
        const results = await connection.query(
            `SELECT Membership.*, Student.Stu_FName, Student.Stu_LName 
             FROM Membership 
             JOIN Student ON Membership.Student_ID = Student.URN 
             WHERE Student.Stu_FName LIKE ? OR Student.Stu_LName LIKE ?`,
            [`%${searchTerm}%`, `%${searchTerm}%`]
        );
        res.render('member_list', { members: results });
    } catch (error) {
        console.error(error);
        res.redirect('/members');
    }
});



app.listen(PORT, () => {
    console.log(`Judo Club app listening at http://localhost:${PORT}`);
});
