/* ==========================================================================
   design_lab1_starter.sql
   CIS 4720 Database Management and SQL
   Design Lab 1, From a Spreadsheet to Tables

   WHAT THIS FILE IS
   The campus tutoring center keeps its records in a spreadsheet. This file
   loads that spreadsheet into a table called tutoring_sheet, exactly as the
   center keeps it, and has a numbered heading for every step of the lab.

   HOW TO RUN IT
   One statement at a time. Put the cursor on it and press Ctrl + E twice.

   LABELING AND COMMENTING IS REQUIRED
   Above every statement you write, put a short comment in your own words
   saying what it does. Some steps also ask you to answer a question in a
   comment. The comments are graded.
   ========================================================================== */


-- =================================================================
-- SETUP. Run these three first, one at a time, while you are still
-- connected to information_schema.
-- =================================================================

-- every schema on this server. tutoring_db will not be in the list yet.
show databases;

-- make yours. IF NOT EXISTS means it is safe to run twice.
create database if not exists tutoring_db;

-- switch into it, so everything below lands in the right place.
use tutoring_db;


-- ======================================================================
-- THE SPREADSHEET. One row per tutoring session. Look at the students
-- column: every student who came is crammed into one cell.
-- ======================================================================

CREATE TABLE tutoring_sheet (
    session_id   INT,
    session_date DATE,
    room         VARCHAR(10),
    tutor_id     INT,
    tutor_name   VARCHAR(40),
    tutor_email  VARCHAR(60),
    course_code  VARCHAR(10),
    course_title VARCHAR(40),
    students     VARCHAR(200)
);
INSERT INTO tutoring_sheet VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS), 1003 Chloe Nguyen (CIS)');
INSERT INTO tutoring_sheet VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting)');
INSERT INTO tutoring_sheet VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', '1001 Ana Lopez (CIS), 1004 Dev Patel (Biology), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', '1003 Chloe Nguyen (CIS), 1004 Dev Patel (Biology)');
INSERT INTO tutoring_sheet VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS)');

-- CHECK. Six rows, sessions 101 to 106.
SELECT * FROM tutoring_sheet;


-- ######################################################################
-- YOUR DESIGN LAB 1 WORK STARTS BELOW THIS LINE
--
-- LABELING AND COMMENTING IS REQUIRED. It is worth a full point.
-- ######################################################################


-- =================================================================
-- STEP 3. Ask the spreadsheet two questions
--
-- Copy the queries from the handout. Answer the question in a comment.
-- =================================================================

-- how many sessions did Ana come to? search inside the text
SELECT COUNT(*) FROM tutoring_sheet WHERE students LIKE '%Ana Lopez%';

-- how many student visits were there in total?
SELECT COUNT(*) FROM tutoring_sheet;

-- count only sees the rows, not each student listed in one cell

-- =================================================================
-- STEP 4. First normal form, one value per cell
--
-- Write the CREATE TABLE. Then run the DATA FOR STEP 4 block below it.
-- =================================================================

-- create a table with one student per session row
create table tutoring_1nf(
    session_id int not NULL,
    session_date date,
    room varchar(10),
    tutor_id int,
    tutor_name varchar(40),
    tutor_email varchar(60),
    course_code varchar(10),
    course_title varchar(40),
    student_id int not null,
    student_name varchar(40),
    student_major varchar(30),
    rating int,
    primary key (session_id, student_id)
);

show full tables;

-- ----------------------------------------------------------------------
-- DATA FOR STEP 4. Run these eleven INSERTs AFTER your CREATE TABLE for
-- tutoring_1nf. They only work if your columns are in the same order as
-- the table in the handout. One row per student per session.
-- ----------------------------------------------------------------------

INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 3);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1001, 'Ana Lopez', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1004, 'Dev Patel', 'Biology', 5);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1005, 'Elena Ruiz', 'Undeclared', 2);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 4);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1005, 'Elena Ruiz', 'Undeclared', 3);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1004, 'Dev Patel', 'Biology', 4);
INSERT INTO tutoring_1nf VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);

select * from tutoring_1nf;

-- count how many sessions each student attended
select student_name, count(*) as sessions
from tutoring_1nf
GROUP BY student_name
ORDER BY student_name;

-- =================================================================
-- STEP 5. Make a copy to break
-- =================================================================

-- create a copy of tutoring_1nf to test data problems
create table anomaly_copy as
select * from tutoring_1nf;

-- check that the copied table has 11 rows
select count(*) from anomaly_copy;

-- =================================================================
-- STEP 6. The update problem
--
-- Copy the UPDATE from the handout. Answer the question in a comment.
-- =================================================================

select * from anomaly_copy;

-- update maya's email and check for inconsistent records

-- change Maya's email, but only where session 101 is
UPDATE anomaly_copy
SET tutor_email = 'maya.chen@campus.edu'
WHERE session_id = 101;

-- what does the database now say her email is?
SELECT DISTINCT tutor_id, tutor_name, tutor_email
FROM anomaly_copy
WHERE tutor_id = 501;

-- we cannot tell which email is correct becase maya has two different emails stored

-- =================================================================
-- STEP 7. The insert problem
--
-- Write the INSERT. Copy the error into a comment.
-- =================================================================

-- try to add a new course without a tutoring session
insert into anomaly_copy (course_code, course_title) values ("CIS 4720", "Database Management");
-- error: Field 'session_id' doesn't have a default value
-- the course cannot be added because a session and student are required


-- =================================================================
-- STEP 8. The delete problem
--
-- Write the DELETE and the check. Answer the question in a comment.
-- =================================================================

-- delete session 103 from the copied table
delete from anomaly_copy where session_id = 103;

-- show which courses are still in the table
select distinct course_code, course_title
from anomaly_copy;
-- math 1600 was also deleted because it was only stored in that session

-- =================================================================
-- STEP 9. Find the dependencies, and design third normal form
--
-- Answer in comments. Use the template in the handout.
-- =================================================================

-- check if each student id has one name and major
-- each student_id has exactly one name and one major. every count is 1
SELECT student_id,
    COUNT(DISTINCT student_name) AS names,
    COUNT(DISTINCT student_major) AS majors
FROM tutoring_1nf
GROUP BY student_id;

/* The key is student_id and session_id
Column           Determined             by Kind
session_date     session_id             partial: needs only part of the key
tutor_name       tutor_id               transitive: session_id determines tutor_id, which determines tutor_name
room             session_id             partial
tutor_id         session_id             partial
tutor_email      tutor_id               transitive: session_id, then tutor_id
course_code      session_id             partial
course_title     course_code            transitive_id: session, then course_code
student_name     student_id             partial
student_major    student_id             partial
rating           session_id, student_id   full: a fact about one student in one session
*/

/* the session table still has transitive dependencies
tutor_name and tutor_email move into the tutor table
course_title moves into the course table
tutor_id is the primary key for tutor
course_code is the primary key for course
session keeps tutor_id and course_code as foreign keys
the five tables are student, tutor, course, session, and attendance
*/

-- =================================================================
-- STEP 10. Build the five tables
--
-- Order matters: a table that is pointed at must exist first.
-- =================================================================

-- create a table to store student information
create table student(
    student_id INT primary key,
    student_name varchar(40) not null,
    student_major varchar(30)
);

-- create a table to store tutor information
create table tutor(
    tutor_id int primary key,
    tutor_name varchar(40) not null,
    tutor_email varchar(60) unique
);

-- create a table to store course information
create table course(
    course_code varchar(10) primary key,
    course_title varchar(40) not null
);

-- create a table to store tutoring sessions
create table session(
    session_id int primary key,
    session_date date not null,
    room varchar(10),
    tutor_id int not null,
    course_code varchar(10) not null,
    foreign key(tutor_id) references tutor(tutor_id),
    foreign key(course_code) references course(course_code)
);

-- create a table to track students attending sessions
create table attendance(
    session_id int not null,
    student_id int not null,
    rating int,
    primary key(session_id, student_id),
    foreign key (session_id) references session (session_id),
    foreign key (student_id) references student (student_id)
);

show full tables;

-- =================================================================
-- STEP 11. Load the five tables from tutoring_1nf
-- =================================================================

-- insert student information from tutoring_1nf
insert into student(student_id, student_name, student_major)
select distinct student_id, student_name, student_major
from tutoring_1nf;

-- insert tutor information from tutoring_1nf
insert into tutor(tutor_id, tutor_name, tutor_email)
select distinct tutor_id, tutor_name, tutor_email
from tutoring_1nf;

-- insert course information from tutoring_1nf
insert into course(course_code, course_title)
select distinct course_code, course_title
from tutoring_1nf;

-- insert session information from tutoring_1nf
insert into session(session_id, session_date, room, tutor_id, course_code)
select distinct session_id, session_date, room, tutor_id, course_code
from tutoring_1nf;

-- insert attendance records from tutoring_1nf
insert into attendance(session_id, student_id, rating)
select session_id, student_id, rating
from tutoring_1nf;

-- check that the attendance table has 11 records
select count(*) from attendance;

-- =================================================================
-- STEP 12. Put the spreadsheet back together
--
-- Copy the view and the check from the handout.
-- =================================================================

-- join the five tables back together into one view

-- the five tables joined back into the 1NF shape
CREATE VIEW tutoring_rebuilt AS
SELECT se.session_id, se.session_date, se.room,
    t.tutor_id, t.tutor_name, t.tutor_email,
    c.course_code, c.course_title,
    st.student_id, st.student_name, st.student_major,
    a.rating
FROM attendance a
JOIN session se ON a.session_id = se.session_id
JOIN tutor t ON se.tutor_id = t.tutor_id
JOIN course c ON se.course_code = c.course_code
JOIN student st ON a.student_id = st.student_id;

-- how many rows match tutoring_1nf on every column?
SELECT COUNT(*)
FROM tutoring_1nf o
JOIN tutoring_rebuilt r
    ON o.session_id = r.session_id AND o.student_id = r.student_id
WHERE o.session_date = r.session_date AND o.room = r.room
    AND o.tutor_email = r.tutor_email AND o.course_title = r.course_title
    AND o.student_name = r.student_name AND o.student_major = r.student_major
    AND o.rating = r.rating;

select * from tutoring_rebuilt;

-- =================================================================
-- STEP 13. Show the three problems are gone
-- =================================================================

-- update maya's email in the tutor table
update tutor set tutor_email = 'maya.chen@campus.edu' where tutor_id = 501;

-- check that maya has only one email stored
select distinct tutor_email from tutoring_rebuilt where tutor_id = 501;
-- maya's email is stored once, so all her sessions show the same email

-- add a new course without needing a tutoring session
insert into course(course_code, course_title) values ("CIS 4720", "Database Management");
-- a new course can be added without needing a tutoring session

-- try to delete session 103
delete from session where session_id = 103;
-- session 103 cannot be deleted because attendance records still reference it
-- math 1600 is also safe because it is stored in its own course table

-- =================================================================
-- STEP 14 and 15. Push to GitHub and submit the URL
--
-- Nothing to write here. Follow the handout.
-- =================================================================
