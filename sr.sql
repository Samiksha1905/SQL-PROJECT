use Accenture

create table STUDENTS(
    Name varchar(200),
	student_id int primary key,
	enrollment_year int
	)

create table Semesters(
semester_id int primary key,
name varchar(50),
year int
)

create table COURSES(
    Course_name varchar(400),
	Course_id int primary key,
	Credits int
	)

create table GRADES(
    grade_id int primary key,
	student_id int,
	course_id int,
	grade char(2),
	foreign key(student_id) references Students(student_id),
	foreign key(course_id) references Courses(course_id)
	)

insert into STUDENTS values
('Amit Singh', 101, 2024),
('Devansh Deshpande', 102, 2023),
('Lavanya Mishra', 103, 2022),
('Manav Gupta', 104, 2020),
('Shweta Roy', 105, 2020),
('Meera Nair', 106, 2021)
select * from students

insert into Semesters values
(1, 'Semester 1', 2024),
(3, 'Semester 3', 2023),
(5, 'Semester 5', 2022),
(7, 'Semester 7', 2020),
(8, 'Semester 7', 2020),
(6, 'Semester 6', 2021)
select * from semesters

insert into COURSES values
('Data Structures and Algorithms', 201, 4),
('Database Management Systems', 202, 3),
('Verilog and Digital Design', 203, 3),
('Startup Design Workshop', 204, 2)
select * from courses

insert into grades values
(301, 101, 201, 'A+'),  
(302, 102, 202, 'A'),  
(303, 103, 203, 'B'), 
(304, 104, 204, 'A'),   
(305, 101, 202, 'F'), 
(306, 102, 204, 'A+')

ALTER TABLE GRADES
ALTER COLUMN grade VARCHAR(2);
select * from grades

SELECT 
    student_id,
    ROUND(SUM(grade * credits) / SUM(credits), 2) AS GPA
FROM 
    Grades g
JOIN 
    Courses c ON g.course_id = c.course_id
GROUP BY 
    student_id;

SELECT 
    c.course_name,
    s.name AS student_name,
    g.grade,
    RANK() OVER (
        PARTITION BY c.course_id
        ORDER BY 
            CASE g.grade
                WHEN 'A+' THEN 10
                WHEN 'A' THEN 9
                WHEN 'B' THEN 8
                WHEN 'C' THEN 7
                WHEN 'D' THEN 6
                ELSE 0
            END DESC
    ) AS rank_in_course
FROM GRADES g
JOIN Students s ON g.student_id = s.student_id
JOIN Courses c ON g.course_id = c.course_id


ALTER TABLE COURSES
ALTER COLUMN semester_id int



SELECT 
    s.student_id,
    s.name,
    sem.name AS semester,
    c.course_name,
    g.grade
FROM 
    Grades g
JOIN 
    Students s ON g.student_id = s.student_id
JOIN 
    Courses c ON g.course_id = c.course_id
JOIN 
    Semesters sem ON c.semester_id = sem.semester_id
ORDER BY 
    sem.semester_id, s.student_id
