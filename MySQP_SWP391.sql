DROP  database IF EXISTS  SWP391;

create database SWP391;

USE SWP391;


CREATE TABLE Account(
	accountID int auto_increment,
	username VARCHAR(255) NOT NULL UNIQUE,
	roleID int DEFAULT 1,
	password VARCHAR(255) NOT NULL,
	avatar NVARCHAR(255),
	firstname NVARCHAR(50) NOT NULL,
	lastname NVARCHAR(50) NOT NULL,
	birthday date,
	email NVARCHAR(120) NOT NULL UNIQUE,
	phone NVARCHAR(20),
	address NVARCHAR(255),
	gender int DEFAULT -1,
    typeAccount int DEFAULT -1,
	primary key (accountID)
);


CREATE TABLE Roles(
	roleID int AUTO_INCREMENT primary key,
	rolename NVARCHAR(255) not null
);





CREATE TABLE Majors(
	majorID int AUTO_INCREMENT primary key,
	keyword NVARCHAR(255) not null,
	majorNameEN NVARCHAR(255) not null,
	majorNameVN NVARCHAR(255) not null
);


CREATE TABLE Curriculum(
	CurriculumCode NVARCHAR(20),
	majorID int,
	CurriculumNameEN NVARCHAR(255) not null,
	CurriculumNameVN NVARCHAR(255) not null,
	Description TEXT not null,
	primary key (CurriculumCode)
);


CREATE TABLE Subjects(
	SubjectCode NVARCHAR(20) primary key,
	subjectName NVARCHAR(255),
	Semester int,
	NoCredit int,
	PreRequisite NVARCHAR(255)
);


CREATE TABLE Syllabus(
	SyllabusID int auto_increment,
	SubjectCode NVARCHAR(20),
	SubjectNameEN NVARCHAR(255),
	SubjectNameVN NVARCHAR(255),
	IsActive bit,
	IsApproved bit,
	DecisionNo NVARCHAR(255),
	NoCredit int,
	DegreeLevel NVARCHAR(255),
	TimeAllocation TEXT,
	Description TEXT,
	StudentTasks TEXT,
	Tools TEXT,
	ScoringScale int,
	Note TEXT,
	MinAvgMarkToPass int,
	ApprovedDate date,
    Primary KEY (syllabusID)
);


CREATE TABLE Feedback(
	fbID int auto_increment,
    accountID int NOT NULL,
    syllabusID INT not null,
    displayName NVARCHAR(100),
    email NVARCHAR(120) NOT NULL,
    title nvarchar(255),
    content text,
    Primary key(fbID)
);


CREATE TABLE Material(
	MaterialDescription TEXT,
	MaterialID int AUTO_INCREMENT,
	SyllabusID int,
	Author NVARCHAR(255),
	Publisher NVARCHAR(255),
	PublishedDate date,
	Edition NVARCHAR(255),
	ISBN NVARCHAR(255),
	IsMainMaterial NVARCHAR(255),
	IsHardCopy NVARCHAR(255),
	IsOnline NVARCHAR(255),
	Note TEXT,
	primary key(MaterialID, SyllabusID)
);


CREATE TABLE Session(
	SessionID int AUTO_INCREMENT,
	SyllabusID int,
	Topic NVARCHAR(255),
	LearningTeachingType NVARCHAR(255),
	StudentMaterials NVARCHAR(255),
	Download NVARCHAR(255),
	StudentsTasks TEXT,
	URLs NVARCHAR(255),
	primary key(SessionID)
);


CREATE TABLE Assessment(
	assessmentID int AUTO_INCREMENT primary key,
	catery NVARCHAR(255),
	SyllabusID int,
	Type NVARCHAR(255),
	Part int,
	Weight float,
	CompletionCriteria int,
	Duration NVARCHAR(255),
	QuestionType NVARCHAR(255),
	NoQuestion NVARCHAR(255),
	KnowledgeandSkill NVARCHAR(255),
	GradingGuide NVARCHAR(255),
	Note TEXT
);


CREATE TABLE ConstructiveQuestion(
	QuestionID int primary key,
	SessionID int,
	QuestionName NVARCHAR(255),
	Details NVARCHAR(255)
);


CREATE TABLE CurriculumSubject(
	CurriculumCode NVARCHAR(20),
	SubjectCode NVARCHAR(20),
	primary key(CurriculumCode, SubjectCode)
);


CREATE TABLE PO(
	CurciculumPOID int AUTO_INCREMENT primary key,
	CurriculumCode NVARCHAR(20),
	POName NVARCHAR(255),
	PODescription TEXT
);


CREATE TABLE PLO(
	PLOID int AUTO_INCREMENT primary key,
	CurriculumCode NVARCHAR(20),
	PLOName NVARCHAR(255),
	PLODescription TEXT
);


CREATE TABLE Combo(
	ComboID int AUTO_INCREMENT primary key,
	ComboName NVARCHAR(255),
	note TEXT
);


CREATE TABLE ComboSubject(
	ID int AUTO_INCREMENT primary key
);


CREATE TABLE Elective(
	ElectiveID int AUTO_INCREMENT,
	ElectiveName NVARCHAR(255),
    PRIMARY KEY(ElectiveID)
);





ALTER TABLE Feedback 
ADD CONSTRAINT fk_account foreign key(accountID) references account(accountID),
ADD CONSTRAINT fk_syllabus foreign key(syllabusID) references syllabus(SyllabusID);

ALTER TABLE Account add constraint fk_accountRole foreign key (roleID) references Roles(roleID);


ALTER TABLE Curriculum add constraint fk_majorCurriculum foreign key (majorID) references Majors(majorID);


ALTER TABLE ConstructiveQuestion add constraint fk_questionsession foreign key (SessionID) references Session(SessionID);


ALTER TABLE Material add constraint fk_syllabusmaterial foreign key (SyllabusID) references syllabus(SyllabusID);


ALTER TABLE Session add constraint fk_syllabussession foreign key (SyllabusID) references syllabus(SyllabusID);


ALTER TABLE Assessment add constraint fk_syllabusassessment foreign key (SyllabusID) references syllabus(SyllabusID);


ALTER TABLE CurriculumSubject
add constraint fk_Subject_curriculum foreign key (CurriculumCode) references Curriculum(CurriculumCode),
add constraint fk_curriculum_Subject foreign key (SubjectCode) references Subjects(subjectCode);
    


ALTER TABLE PO add constraint fk_POSubject foreign key (CurriculumCode) references Curriculum(CurriculumCode);


ALTER TABLE PLO add constraint fk_PLOSubject foreign key (CurriculumCode) references Curriculum(CurriculumCode);


ALTER TABLE Syllabus add constraint fk_Syllabus_Subject foreign key (subjectCode) references Subjects(subjectCode);



INSERT INTO Roles(rolename) VALUES('GUEST'),('STUDENT'),('TEACHER'),('REVIEWER'),('DESIGNER'),('CRDD'),('ADMIN');


INSERT INTO Account(username, password, firstname, lastname, email, roleID) VALUES ('admin', '123', 'Van', 'Tien Tu', 'tuvthe160803@fpt.edu.vn', 7);

INSERT INTO `swp391`.`subjects`
(`SubjectCode`,
`subjectName`,
`Semester`,
`NoCredit`,
`PreRequisite`)
VALUES
('OTP101','Orientation and General Training Program_Định hướng và Rèn luyện tập trung','0','0','None'),
('EAW211','English Academic Writing 1_Tiếng Anh Viết học thuật 1','1','3','None'),
('VDP201','Video Production_Sản xuất Video','4','3','None'),
('SSG103','Communication and In-Group Working Skills_Kỹ năng giao tiếp và cộng tác','1','3','None'),
('DTG111','Visual Design Tools 1_Công cụ thiết kế trực quan 1','1','3','None'),
('MED201','New Media Technology_Các loại hình Truyền thông đương đại','1','3','None'),
('MGT103','Introduction to Management_Nhập môn quản lý','1','3','None'),
('MKT101','Marketing Principles_Nguyên lý Marketing','1','3','None'),
('WDU203c','UI/UX Design_Thiết kế trải nghiệm người dùng','8','3',''),
('SSL101c','Academic Skills for University Success_Kỹ năng học tập đại học','1','3','None'),
('ACC101','Principles of Accounting_Nguyên lý kế toán','2','3','None'),
('CMC201c','Creative Writing_Sản xuất nội dung sáng tạo','2','3','None'),
('DTG121','Visual Design Tools 2_Công cụ thiết kế trực quan 2','2','3','DTG111'),
('MMP201','Media Psychology_Tâm lý học truyền thông','2','3','None'),
('SSG104','Communication and In-Group Working Skills_Kỹ năng giao tiếp và cộng tác','2','3','None'),
('CCO201','Corporate Communication_Truyền thông doanh nghiệp','3','3',''),
('MKT208c','Social media marketing_Marketing mạng xã hội','3','3','MKT101'),
('MKT304','Integrated Marketing Communications_Truyền thông marketing tích hợp','3','3','MKT101');
INSERT INTO `swp391`.`syllabus`
(`SubjectCode`,
`SubjectNameEN`,
`SubjectNameVN`,
`IsActive`,
`IsApproved`,
`DecisionNo`,
`NoCredit`,
`DegreeLevel`,
`TimeAllocation`,
`Description`,
`StudentTasks`,
`Tools`,
`ScoringScale`,
`Note`,
`MinAvgMarkToPass`,
`ApprovedDate`)
VALUES
('OTP101','Orientaiton and General Training Program','Định hướng và Rèn luyện tập trung',1,1,'',0,'	Bachelor',':5 weeks (fulltime) = 280h
* Module 1: Orientation-Định hướng
(1 week: 8h/day * 5 days = 40h)
* Module 2: Military Training-Giáo dục quốc phòng
(110 slots * 1.5h/slot = 165h)
* Module 3: Experience Program
22 slots * 1.5h = 33 h
* Module 4: Vovinam
28 slots * 1,5h/slot = 42h','Orientation and general training program includes 4 modules :
* Module 1: Orientation
Main activities of this module are:
- Organizing the opening ceremony for students.
- Organizing health check amd making students''cards.
- Arranging classes for students and organizing class meeting.
- Introducing to students about FPT corporation, FPT university, functional departments, training regulations and how to use information systems to support students'' learning.
- Sharing study skills for university students.
- Sharing about topics related to community activities. ( For example: activities towards sustainable development, volunteering activities...)
* Module 2: Military training the program prescribed by the Ministry of Education and Training.
Implementing the program prescribed by the Ministry of Education and Training.
* Module 3: Experience program
Main activities of this module are:
- Organizing research and review memoirs.
- Organizing seminars
- Organizing experiential activities for students (Towards sustainable development and volunteering for the community)
* Module 4: Vovinam
Follow the outline VOV114.
Objectives of orientation and training program are:
1) Instruct students to complete procedures before a new semester.
2) Provide students with knowledge about FPT corporation, FPT university and functional departments which support students during the period of study at the university.
3) Introduce to students about Curriculum, FU training model and regulations as well as how to use information systems to enable students to adapt new learning environment.
4) Educate students the fundamentals of military and national security, build and enrich patriotism, national pride through history lessons, seminars, documentaries, field trips to military bases and memoirs about two prolonged resistance wars of Viet Nam.
5) Train the willpower and improve physical strengths, fitness and sense of responsibilities through physical education lessons and combat practice in the field.
6) Train team spirit, disciplines, shape good attitude and behaviors towards friends, teachers and educational environment.
7) Enhance student experiences with extra-curricular activities. Strengthen the sense of community through community and volunteering activities and the ones towards the sustainable development.',
'Attend enough activities of the university.','',10,'Min to pass: Students must pass the examination and achieve the Military training certificate',0,'2022-12-22'),
('SSG103','Communication and In-group working skills','',1,1,'378/QĐ-ĐHFPT',3,'','30 sessions, 1 session = 90 minutes','This course will cover both working in groups and communication skills.
Assessment structure:
* On-going Assessment:
- Activity: 10%
- Quiz: 15%
- Group Assignment : 15%
- Group Project : 30%
* Final Exam: 30%
* Completion Criteria: Every on-going assessment component > 0, Final Exam >=4, Final Result >=5','- Attend more than 80% of contact hours in order to be accepted to the final examination
- Actively participate in class activities
- Fulfill tasks given by instructor after class
- Use their own laptop in class only for learning purpose
- Read the textbook in advance
- Access the course website (www.cms.fpt.edu.vn) for up-to-date information and material of the course, for online supports from teachers and other students and for practicing and assessment.','- Internet
- PDF reader',10,'',5,'2021-2-4'),
('EAW211','English Academic Writing 1','Viết học thuật tiếng Anh 1',1,1,'295/QĐ-ĐHFPT',3,'Advanced','Study hour (150h) = 45 contact hours (60 sessions) + 1 hour final exam + 104 hours self-study','Advance in Academic Writing helps students write assignments in academic English. Advance integrates active and critical reading, critical thinking, academic vocabulary building, academic writing style, and effective sentence structure and grammar around authentic academic texts. As students respond to these texts, they are taken through the research and writing processes they will need to master to succeed in their respective fields of study.','- Attend more than 80% of contact hours in order to be accepted to the final examination
- Actively participate in class activities
- Fulfil tasks given by instructor after class
- Use their own laptop in class only for learning purpose
- Access the course website (http://cms.fpt.edu.vn) for up-to-date information and material of the course, for online supports from teachers and other students and for practicing and assessment.','Tools: Foxit pdf editor
Internet access',10,'1) On-going assessment
- Assignments 04*15% 60%
2) Final Examination (FE) 40%
3) Final Result 100%
4) Completion Criteria:
On-going assessment >0, Final Exam Score >=4/10 & Final Result >=5/10',5,'2022-12-22'),
('VDP201','Video Production','Sản xuất video',1,1,'295/QĐ-ĐHFPT',3,'Bachelor in Business Administration','Study hour (150h)
= 45h contact hours + 105h self-study','This practicum course is designed to give students the opportunity to apply theoretical knowledge learned before to actual multimedia production situations. This course incorporates in its approach a combination of applied media aesthetics theory and hands-on production experience in Video production. Students will gain a foundation for understanding media production theory, facilitating video production processes as well as creating and evaluating media products relating to a particular issue set by the course lecturer. A component of the course will permit the introduction of current topics such as media issues, professional video production techniques, changing media technology, and job market information.','-Attend more than 80% of contact hours in order to be accepted to the final examination','',10,'',5,'2022-12-22'),
('DTG111','Visual Design Tools 2D','Công cụ thiết kế trực quan 1',1,1,'870/QĐ-ĐHFPT',3,'Bachelor','Study hour (150h)
= 45h contact hours + 105h self-study','The course empowerC14ommon Adobe 2D tools for Multimedia designers, which are Illustrator, Photoshop, InDesign and Xd, so that they can finalize their 2D designs better and able to deliver completed professional product to customers
Through practical assignments, students have chances to apply knowledge on colors, typography etc. in other courses along with computers and other tools to creaate graphic applications.','- Read textbook and install software before coming to class
- Complete assignments in class, submit online thoughout LMS or Classroom platform.
- Frequently visit fap, LMS or Google classroom for update instrucions and requirements.
- Actively participate into class, review and comments to classmate works, ask instructor questions, bring into class everyday samples for references.
- Complete homework and other requirements by instructors
- Using laptop in class only for taking note, research and doing assignment purposes
- No talking, surfing, chatting, gaming, facebooking, using phone etc. while the teacher giving instruction.
- Present at least 80% class attendance in order to pass the course.','1. The school prepare: (Installed)
- Classroom with chairs, desks, large monitor with HDMI connection for demo/presentation

2. Student prepare:
- Note/Sketchbooks, pens and pencils
- Laptop for graphic design with Adobe Photoshop, Illustrator, Indesign and Xd installed',10,'',5,'2022-8-17'),
('MED201','New Media Technology','Các loại hình Truyền thông đương đại',1,1,'1485/QĐ-ĐH-FPT',3,'Bachelor','	Study hour (150h)
= 45h contact hours + 1h final exam + 104h self-study','Description: This course will give you a thorough explanation of how media technologies develop, operate, converge, and affect society in order to think critically about the media and its effects on culture. It provides a comprehensive introduction to today''s global media environment and the ongoing developments in technology, culture, and critical theory that continue to transform this rapidly evolving industry and affect your everyday life. Our emphasis is on the social relations of power and connectivity that are shaped by new media as practices of communication. Specific topics that will be explored include: the latest developments and trends in social media, e-publishing, policy changes for Internet governance, online privacy protection, online ad exchanges, the changing video game industry, and much more. By studying this course, students will develop knowledge and skills in creative thinking, communication, collaboration, planning, critical analysis, and digital and ethical citizenship.
Teaching methods: Direct Instruction, Inquiry-based Learning, Cooperative Learning, Case Study Analysis','- Students must attend more than 80% of contact slots in order to be accepted to the final examination.
- Student is responsible to do all exercises, assignments and labs given by instructor in class or at home and submit on time
- Use laptop in class only for learning purpose','- Textbook
- Computer',10,'',5,'2022-12-22'),
('MGT103','Introduction to Management','Nhập môn quản lý',1,1,'1485/QĐ-ĐH-FPT',3,'Bachelor','Study hour (150h) = 45h (60 sessions) contact hours + 1h final exam + 104h self-study','The course explores and focuses around the managerial functions of management, including planning, organizing, leading and controlling. The course is designed to provide basic knowledge and skills required in management and give students a comprehensive insight into human relations componnents that characterise any managerial roles, regardless of industry or functions. Various aspects of management theories will be examined and linked to current management practice in the world and Vietnam. Learning in the class will be facilitated through the use of interactive tools such as group exercise, case study discussion, role-play/activities, and projects.','- Attend more than 80% of contact hours in order to be accepted to the final examination
- Actively participate in class activities- Fulfill tasks given by instructor after class
- Use their own laptop in class only for learning purpose
- Read the textbook in advance','',10,'',5,'2022-12-22'),
('MKT101','Marketing Principles','Nguyên lý Marketing',1,1,'1009/QĐ-ĐHFPT dated 01/09/2021',3,'Bachelor in Business Administration','Study hour (150h) = 45h (60 sessions) contact hours + 1h final exam + 104h self-study','	The course is designed to provide students with a strong foundation in marketing based on five key activities: (1) identifying customer needs, (2) providing customers with the right products or service to meet their needs, (3) assuring availability to customers through the right distribution channels, (4) using promotional activities in ways that motivate purchase as effectively as possible, (5) setting an appropriate price that maximizes firm profitability while maintaining customer satisfaction.','- Attend more than 80% of contact hours in order to be accepted to the final examination
- Actively participate in class activities
- Fulfill tasks given by instructor after class
- Use their own laptop in class only for learning purpose
- Read the textbook in advance
- Access the course website (www.flm.fpt.edu.vn) for up-to-date information and material of the course, for online supports from teachers and other students and for practicing and assessment.','',10,'',5,'2022-12-22'),
('WDU203c','UI/UX Design','Thiết kế trải nghiệm người dùng',1,1,'1341/QĐ-ĐHFPT dated 22/11/2021',3,'Bachelor','Online: 84 hours+6 slot offline','	Integrate UX Research and UX Design to create great products through understanding user needs, rapidly generating prototypes, and evaluating design concepts. Students will gain hands-on experience with taking a product from initial concept, through user research, ideation and refinement, formal analysis, prototyping, and user testing, applying perspectives and methods to ensure a great user experience at every step. This course concludes with a capstone project, in which learners will incorporate UX Research and Design principles to design a complete product, taking it from an initial concept to an interactive prototype.','1. Complete the online courses and get all specialization certifications to be allowed to take Final Exam
2. Final Exam included Final Theory Exam (TE): 100%
3. Student gets 0.165 bonus points for each course completed on time.
4. Completion Criteria: Final TE Score >=4 & (Final TE Score + bonus) >= 5','- Internet',10,'',5,'2021-11-22'),
('SSL101c','Academic Skills for University Success','Kỹ năng học tập ở Đại học',1,1,'1009/QĐ-ĐHFPT',3,'Bachelor','42 hours online + 9hrs offline (6 slots) + 1hr exam','Upon finishing the course, students can:
1) Knowledge: Understand
- Method to develop your Information & Digital Literacy Skills
- Method to develop your Problem Solving and Creativity Skills
- How to develop your Critical Thinking Skills
- How to develop your Communication Skills
2) Able to (ABET)
- Access, search, filter, manage and organize Information by using a variety of digital tools, from wide variety of source for use in academic study.
- Critically evaluate the reliability of sources and use digital tools for referencing in order to avoid plagiarism.
- Demonstrate awareness of ethical issues related to academic integrity surrounding the access and use of information
- Develop a toolkit to be able to identify real problems and goals within ill-defined problem & Recognize and apply analytical & creative problem solving technique
- Use a variety of thinking tools to improve critical thinking
- Identify types of argument, and bias within arguments
- Demonstrate, negotiate, and further understanding through spoken, written, visual, and conversational modes
- Effectively formulate arguments and communicate research findings through the process of researching, composing, and editing
3) Others: (ABET)
- Improve study skills (academic reading, information searching, ...)','1. Join the online course (spec.) when being invited by the admin.
2. Enroll in each MOOC of spec., regularly study MOOCs at least 5hrs/week by watching videos, reading materials, taking quizzes, doing assignments... as required
3. Respect the Coursera Code of Conduct, at https://learner.coursera.help/hc/en-us/articles/208280036-Coursera-Code-of-Conduct
3. Keep online learning progress promptly (bonus will be awarded)
4. Communicate and discuss in forum
5. Attend off-line sessions in the Campus (Optional)
6. Must complete all MOOCs of spec. with certification in order to take the Final Exam at Campus','Online Spec. https://www.coursera.org/specializations/academic-skills; University of Sydney, including:
- MOOC1: Introduction to Information & Digital Literacy for University Success , https://www.coursera.org/learn/digital-literacy/home/welcome
- MOOC2: Introduction to Problem-Solving Skill for University Success, https://www.coursera.org/learn/problem-solving-skills/home/welcome
- MOOC3: Critical Thinking Skills for University Success, https://www.coursera.org/learn/critical-thinking-skills/home/welcome
- MOOC4: Communication Skills for University Success, https://www.coursera.org/learn/communication-skills/home/welcome
- MOOC5: Academic Skills for University Success: Capstone, https://www.coursera.org/learn/academic-skills-project/home/welcome',10,'1) Ongoing assessment:
Student gets 0.2 bonus points for each course completed on time. The total bonus point is not greater than 1.
2) Theoretical Exam (TE)
3) Final Result (FR) =min (10, TE + Bonus)
4) Completion Criteria: TE>=4 and FR>=5',5,'2022-11-24'),
('ACC101','Principles of Accounting','Nguyên lý kế toán',1,1,'870/QĐ-ĐHFPT',3,'Bachelor in Business Administration','Study hour (150h) = 45h (60 sessions) contact hours + 1h final exam + 104h self-study','Main objectives:
<br>Upon completion of this course, students should:
<br>1. Have clear understanding of ideas, principles, and techniques of accounting
<br>2. Have the knowledge and tools to better understand business performance issues, and the decisions and problems faced by managers;
<br>3. Understand the important role of accounting and finance in all organizations, in all jobs, and its link with the development of increasingly sophisticated IT systems.
<br>Specific objectives :
<br>1. Recognize and organize accounting transactions
<br>2. Classify and calculate correctly in terms of revenue, cost, profit or loss in an account
<br>3. Be able to prepare comprehensive and accurate financial statements
<br>4. Learn how to prepare comprehensive and realistic budget plans.
<br>5. Have the ability to appraise the efficiency of the project

<br>Description:
<br>The main content is structured into twelve chapters covering Financial Accounting, Management Accounting and Business Finance.
<br>Topics include: business transaction, financial statement format and analysis, inventory and account receivable, type of assets and liability, costing classification, master budget and capital budgeting','- Class attendance is strongly encouraged. Attend more than 80% of class hours in order to be accepted to the final examination
<br>- Actively participate in class activities
<br>- Fulfill tasks given by instructor after class
<br>- Use their own laptop in class only for learning purpose
<br>- Read the textbook in advance
<br>- Access the course website (http://flm.fpt.edu.vn) for up-to-date information and material of the course, for online supports from teachers and other students and for practicing and assessment.','',10,'',5,'2022-8-17'),
('CMC201c','Creative Writing','Sản xuất nội dung sáng tạo',1,1,'889/QĐ-ĐHFPT dated 03/09/2020',3,'Bachelor','55 hours online + 9 hrs offline + 1hr exam','Upon finishing the course, students can:
<br>1) Knowledge: Understand
<br>- Method to develop the craft of plot
<br>- Method to develop the craft of Character
<br>- How to develop the craft of Setting and Description
<br>- How to develop the Craft of Style
<br>2) Able to (ABET k)
<br>- Learn how to outline and structure a plot, discuss narrative arc, pacing and reversals and reveal the inevitable surprise: connecting the beginning, middle and end.
<br>- How to build and bring to life complex, vivid and unforgettable characters.
<br>- How to describe the physical world in sharp, sensory detail.
<br>- Apply the use of metaphor and imagery, and demonstrate how clarity, grace, and inventiveness in word choice.
<br>3) Others: (ABET i)
<br>- Improve study skills (academic reading, information searching, ...)','1. Join the online course (spec.) when being invited by the admin.
<br>2. Enroll in each MOOC of spec., regularly study MOOCs at least 5hrs/week by watching videos, reading materials, doing assignments... as required
<br>3. Respect the Coursera Code of Conduct, at https://learner.coursera.help/hc/en-us/articles/208280036-Coursera-Code-of-Conduct
<br>3. Keep online learning progress promptly (bonus will be awarded)
<br>4. Communicate and discuss in forum
<br>5. Attend off-line sessions in the Campus (Optional)
<br>6. Must complete all MOOCs of spec. with certification in order to take the Final Exam at Campus -> submit the individual assignment to complete the course.','',10,'1) Ongoing assessment:
Student gets 0.2 bonus points for each course completed on time. The total bonus point is not greater than 1.
<br>2) Theoretical Exam (TE)
<br>3) 3) Final Result (FR) =min (10, TE + Bonus)
4) Completion Criteria: TE>=4 and FR>=5',5,'2020-3-9'),
('DTG121','Visual Design Tools 2','Công cụ thiết kế trực quan 2',1,1,'378/QĐ-ĐHFPT dated 02/04/2021',3,'Bachelor','Study hour (150h)
= 45h contact hours + 105h self-study','Description: The course empowers students to master 2 advance tools for graphic and multimedia designers, which are InDesign and Figma, so that they can finalize their layout and interactive design better.
Through practical assignments, students have chances to apply knowledge on layout, colors, typography etc. in other courses along with computers and tools to create and finalize graphic applications.

<br>Teaching method:
<br>- Under lecturer’s instruction, through a series of instruction sessions, work analysis and personal exercises, students will be equipped with knowledge and skills to develop and complete a magazine layout and a functional apps interface.','- Read textbook and install software before coming to class
<br>- Complete assignments in class, submit online thoughout LMS or Classroom platform.
<br>- Frequently visit fap, LMS or Google classroom for update instrucions and requirements.
<br>- Actively participate into class, review and comments to classmate works, ask instructor questions, bring into class everyday samples for references.
<br>- Complete homework and other requirements by instructors
<br>- Using laptop in class only for taking note, research and doing assignment purposes
<br>- No talking, surfing, chatting, gaming, facebooking, using phone etc. while the teacher giving instruction.
<br>- Present at least 80% class attendance in order to pass the course.','1. The school prepare: (Installed)
<br>- Classroom with chairs, desks, large monitor with HDMI connection for demo/presentation
<br>- Internet connection.

2. Student prepare:
<br>- Note/Sketchbooks, pens and pencils
<br>- Laptop for graphic design with Adobe Creative apps installed',10,'',5,'2022-8-17'),
('MMP201','MEDIA PSYCHOLOGY','Tâm lý học truyền thông',1,1,'1485/QĐ-ĐH-FPT',3,'Bachelor','Study hour (150h)
= 45h contact hours + 1h final exam + 104h self-study','-Objective: Understand and can be applied the cognitive psychology theories of mass comunication.
<br>-Description: This course will focus on a range of psychological theories, processes, and principles in the context of mass communication. Students will explore the application of these theories and principles to several prominent issues will be discussed. Such issues may include politics, sex, and violence, to lesser-studied topics, such as sports, music, emotion, and technology of various media. In addition, this course examines how our experiences with media affect the way we acquire knowledge about the world, and how this knowledge influences our attitudes and behavior.
<br>-Teaching method: Presentation, Disscussion, teamwork, critical thinking.','- Students must attend more than 80% of contact slots in order to be accepted to the final examination.
<br>- Student is responsible to do all exercises, assignments and labs given by instructor in class or at home and submit on time
<br>- Use laptop in class only for learning purpose
<br>- Promptly access to the FU CMS at http://cms.fpt.edu.vn for up-to-date course information','',10,'',5,'2022-12-22'),
('SSG104','Communication and In-Group Working Skills','Kỹ năng giao tiếp và cộng tác',1,1,'',3,'Bachelor','Study hour (150h) = 45 contact hours (60 sessions) + 0.5 hour final exam + 104.5 hours self-study','This course covers both working in groups and communication skills. The course covers theories of communication, working in group, and activities for students to practice applying the theories in academic and working contexts.','- Students must attend more than 80% of contact slots in order to be accepted to the final examination.
<br>- Student is responsible to do all exercises, assignments and labs given by instructor in class or at home and submit on time
<br>- Use laptop in class only for learning purpose
<br>- Promptly access to the FU CMS at http://cmshn.fpt.edu.vn for up-to-date course information','- Internet',10,'	Progress marks:
<br>- 03 Activity: 15% (5% each activity)
<br>- 02 Group Assignment: 20% (10% each assignment)
<br>- 01 Participation: 10%
<br>- 01 Quiz: 5%
<br>- 01 Group Project: 30% (part 1: proposal, part 2: product, part 3: presentation/report; 10% each)
<br>- 01 Final exam: 20%
<br>Conditions to pass: Final exam >= 4
<br>Grade Average >= 5/10',5,'2022-12-22'),
('CCO201','Corporate Communication','Truyền thông doanh nghiệp',1,1,'',3,'Bachelor level','Study hour (150h)
= 45h contact hours + 0,6667 h final exam + 104,3333 h self-study','This course provides a comprehensive introduction to corporate communications and public relations: it is for anyone with an interest in corporate communication, or anyone seeking to understand the growing importance of communication for corporations. Corporations increasingly need communication to survive, as they need to entertain relations with a variety of stakeholders to prosper. This includes not only external factors to the organization – customers, governments and civil ociety organizations, but also stakeholders within corporations themselves, such as employees, managers and investors.

The first weeks of the course focus on the basics of corporate communication: what
is it, and what are its historical roots? This is important, as it demonstrates how the
position of communication is increasingly considered to be managerial function – and
as such should be involved in the key decision-making processes. After these
introductory weeks, we turn to two core theories of corporate communication:
stakeholder theory and corporate identity. These form the basis for much of the more
specific and applied topics covered in the following weeks. In the last two weeks
before the midterm exam, we discuss how corporations can construct communication
campaigns – which will be useful as you will be tasked with creating your own
communication campaign during the course. After the midterm exam, we tackle
specific topics of corporate communication, such as employee communications, how
corporations interact with media and journalists, and how corporations should
communicate in times of crisis.','- Attend more than 80% of contact hours in order to be accepted to the final examination
- Actively participate in class activities
- Fulfill tasks given by instructor
- Use their own laptop in class only for learning purpose
- Read the textbook in advance','',10,'',5,'2022-12-22'),
('MKT208c','Social Media Marketing','Marketing mạng xã hội',1,1,'378/QĐ-ĐHFPT dated 02/04/2021',3,'Bachelor','Online: 52 hours+ 6 slots offline (optional)','The Social Media Marketing Specialization is designed to achieve two objectives. It gives students the social analytics tools, and training to help them become an influencer on social media. The course also gives the knowledge and resources to build a complete social media marketing strategy – from consumer insights to final justification metrics.
Note: Student gets 0.165 bonus points for each course completed on time.','Access the specialization on Coursera and complete all courses'' requirements to earn a certificate of completion for the specialization, in order to be qualified for the Final Exam.','Internet access',10,'',5,'2021-4-2'),
('MKT304','Intergrated Marketing Communications','Truyền thông Marketing tích hợp',1,1,'1009/QĐ-ĐHFPT dated 01/09/2021',3,'Bachelor in Business Administration','Study hour (150h) = 45h (60 sessions) contact hours + 1h final exam + 104h self-study','The course aims to provide students a solid foundation on different aspects of advertising and other major integrated marketing communications tools, and the role of these tools in the marketing process. In particular, attention will be given to discussions on (1) understanding the communication processes of consumers and marketers, (2) conducting situation analyses of business and social environments, (3) devising effective creative strategies for achieving marketing objectives, and (4) implementing and evaluating the creative strategy.','- Attend more than 80% of contact hours in order to be accepted to the final examination
- Actively participate in class activities
- Fulfil tasks given by intructor after class
- Use their own laptop in class only for learning purpose
- Read the textbook in advance
- Access the course website (www.flm.fpt.edu.vn) for up-to-date information and material of the course, for online supports from teachers and other students and for practicing and assessment.','',10,'',5,'2022-8-17');

INSERT INTO `swp391`.`majors`
(
`keyword`,
`majorNameEN`,
`majorNameVN`)
VALUES
('SE','Software Engineering Major','chuyên ngành Kỹ thuật phần mềm'),
('MKT','Marketing Major','chuyên ngành Marketing'),
('MC','Multimedia Communication Major','chuyên ngành QTTTĐPT'),
('TM','Tourism and Travel Management Major','chuyên ngành Quản trị Du lịch & Lữ hành'),
('GD','Digital Art & Design Major','chuyên ngành Thiết kế Mỹ thuật số'),
('FIN','Finance Major','chuyên ngành Tài chính'),
('IS','Information System Major','chuyên ngành Hệ thống thông tin'),
('AI','Artificial Intelligence Major','chuyên ngành Trí tuệ nhân tạo'),
('HM','Hotel Management Major','chuyên ngành Quản trị Khách sạn'),
('IA','Information Assurance','chuyên ngành An Toàn Thông Tin'),
('IoT','Internet of Things','chuyên ngành Internet Vạn Vật'),
('HM','Hotel Management Major','chuyên ngành Quản trị Khách sạn');
INSERT INTO `swp391`.`curriculum`
(`CurriculumCode`,
`majorID`,
`CurriculumNameEN`,
`CurriculumNameVN`,
`Description`)
VALUES
('BBA_MC_K16B',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
General objectives:
The program of Bachelor of Business Administration, Multimedia communication specialty aims to train bachelors with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty, being able to work in the international environment, and laying the foundation to pursue further study and research in multimedia communication.
Specific objectives:
PO1: Help students develop physically, mentally, intellectually, morally and deepen national pride by equipping them with general knowledge of politics, law, economy, society, physical education, music and national defense education.
PO2: Provide students with foundational knowledge of business administration and in-depth knowledge of multimedia communication.
PO3: Helps students combine knowledge of communication and multimedia art, and be able to apply knowledge of information technology in producing communication products.
PO4: Provide knowledge of the entire process of strategic and communication planning for businesses, etc.
PO5: Help learners practice essential skills such as proficiently using words, images, sounds, and content creation skills in the process of producing communication products.
PO6: Orientate students towards the right attitudes and work ethics, abilities to think creatively, work well in groups and independently and abilities to solve problems related to multimedia communication effectively, and be capable of lifelong learning for personal and professional development.
PO7: Help students use English fluently and a second language at a basic level.
Job positions after graduation:
Graduates of the Multimedia communication specialty have diverse job opportunities such as:
• Content creation specialist/director;
• Communication specialist/director;
• Advertising and public relations specialist;
• Reporters, editors for television, radio, print newspapers, magazines;
• Multimedia research analyst;
• Take charge of media startups/agency, media product production;
• Startup CEO in the field of multimedia communication.
• Researchers / Lecturers / Postgraduates: can carry out research activities in centers that conduct research in the field of Multimedia communication.
Upon graduation, bachelors can pursue further study to obtain a master''s degree in Business Administration and Communication, Multimedia Content Creation.

1. Mục tiêu của chương trình
Mục tiêu chung:
Mục tiêu của chương trình cử nhân Quản trị Kinh doanh (QTKD), chuyên ngành Quản trị Truyền thông đa phương tiện nhằm đào tạo người học có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến chuyên ngành được đào tạo, làm việc được trong môi trường quốc tế, tạo tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn về chuyên ngành QTTTĐPT.
Mục tiêu cụ thể:
PO1: Phát triển về thể chất, tinh thần, trí tuệ, nhân sinh quan, lòng tự hào dân tộc thông qua việc trang bị cho người học những kiến thức tổng quát về lý luận chính trị, pháp luật, kinh tế, xã hội, giáo dục thể chất, âm nhạc, giáo dục quốc phòng.
PO2: Cung cấp cho người học những kiến thức cơ bản trong quản trị kinh doanh và kiến thức chuyên sâu về Quản trị truyền thông đa phương tiện.
PO3: Giúp người học kết hợp các kiến thức về truyền thông và mỹ thuật đa phương tiện, đồng thời ứng dụng được các kiến thức về công nghệ thông tin trong quá trình sản xuất các sản phẩm truyền thông.
PO4: Người học sẽ được bao quát toàn bộ quá trình xây dựng chiến lược, hoạch định truyền thông cho doanh nghiệp...
PO5: Giúp người học rèn luyện những kỹ năng thiết yếu như sử dụng thành thạo ngôn từ, hình ảnh, âm thanh và kỹ năng tạo lập nội dung trong quá trình sản xuất các sản phẩm truyền thông.
PO6: Hướng người học có thái độ và đạo đức nghề nghiệp đúng đắn, có khả năng tư duy sáng tạo, làm việc nhóm, làm việc độc lập và có năng lực giải quyết các vấn đề liên quan tới quản trị truyền thông đa phương tiện một cách hiệu quả, có khả năng tự học tập suốt đời để phát triển bản thân và công việc.
PO7: Giúp người học sử dụng thành thạo tiếng Anh và một ngoại ngữ hai ở mức cơ bản.
Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành Quản trị Truyền thông Đa phương tiện sẽ có nhiều cơ hội làm việc đa dạng như:
• Chuyên viên/giám đốc sáng tạo nội dung;
• Chuyên viên/giám đốc truyền thông;
• Chuyên viên quảng cáo và quan hệ công chúng;
• Phóng viên, biên tập viên truyền hình, phát thanh, báo in, tạp chí;
• Chuyên gia nghiên cứu truyền thông đa phương tiện;
• Phụ trách các start up/agency về truyền thông, sản xuất sản phẩm truyền thông;
• CEO của các start up về lĩnh vực truyền thông đa phương tiện do mình sáng lập.
• Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực QTTTĐPT.
Sau khi tốt nghiệp, các cử nhân có thể học tiếp để lấy bằng cao học về Quản trị Kinh doanh và Truyền thông, Sản xuất nội dung Đa phương tiện.'),
('BBA_MC_K16C',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a ) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply specialized knowledge of SE specialty into practical work
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in study, work and life
1.2 Specific objectives:
Graduates of the IT training program/SE specialty must demonstrate the following:
PO1. Having basic knowledge of social sciences, politics and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.
PO2. Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.
PO3. Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society);
PO4. Can use English well in study and work and a second foreign language in normal communication.
PO5. Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.

1.3. Job positions after graduation:
Graduates of Software Engineering can choose for themselves the following jobs:
✔ Application development programmers
✔ Business analysts
✔ Software quality assurance engineers
✔ Software process engineers
✔ Software project administrators

2. Program Learning Outcomes

3. Volume of learning of the course: 145 credits, excluding Preparation English, Military Training, compulsory and elective training activities.

4. Enrollment object
✔ In accordance with regulations on formal university enrollment; college enrollment of the Ministry of Education and Training.
✔ In accordance with regulations on enrollment of FPT university.

5. Training process, graduating conditions
✔ In accordance with regulations on formal university and college training of the Ministry of Education and Training.
✔ In accordance with regulations on training of FPT University.

6. Evaluation method
✔ In accordance with regulations on examination and assessment in the training regulations of FPT University.

1. Mục tiêu đào tạo
1.1 Mục tiêu chung:
Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT)/chuyên ngành Kỹ thuật phần mềm (KTPM) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.
1.2 Mục tiêu cụ thể:
Sinh viên tốt nghiệp chương trình đào tạo phải thể hiện được những điều sau đây:
PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.
PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.
PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu);
PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.
PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

1.3. Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành Kỹ thuật phần mềm có thể lựa chọn cho mình những công việc như:
✔ Lập trình viên phát triển ứng dụng
✔ Chuyên viên phân tích nghiệp vụ
✔ Kỹ sư đảm bảo chất lượng phần mềm
✔ Kỹ sư quy trình sản xuất phần mềm
✔ Quản trị viên dự án phần mềm

2. Chuẩn đầu ra

3. Khối lượng kiến thức toàn khóa

4. Đối tượng tuyển sinh
✔ Theo quy chế tuyển sinh đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế tuyển sinh của trường Đại học FPT.

5. Quy trình đào tạo, điều kiện tốt nghiệp
✔ Thực hiện theo quy chế đào tạo đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế đào tạo của trường Đại học FPT.

6. Cách thức đánh giá
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.'),
('BIT_IA_K16C',10,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. TRAINING OBJECTIVES

1.1. General objectives:

Training Information Technology (IT)/ Information Assurance (IA) engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialties.
The training program aims to:
a ) To equip students with fundamental knowledge of the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialties;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply fundamental knowledge and specialized knowledge into practical work;
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in study, work and life.

1.2 Specific objectives:
Graduates of the IT training program/IA specialty must demonstrate the following:
PO1. Having basic knowledge of social sciences, politics and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.

PO2. Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.

PO3. Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society);

PO4. Can use English well in study and work and a second foreign language in normal communication.

PO5. Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.

- Job placement after graduation:
Engineers graduating IA specialty have diverse employment opportunities with a number of typical positions such as:
✔ Network and database security administrators;
✔ Engineers in testing and evaluating information assurance for networks and systems;
✔ Engineers in reviewing vulnerabilities, weaknesses and handling information assurance incidents;
✔ Developer in programming and developing applications to ensure information assurance;
✔ Counselor in analyzing, consulting, designing safety information systems.

2. PROGRAM LEARNING OUTCOMES

3. VOLUME OF LEARNING OF THE COURSE: 145 credits, excluding Preparation English, Military Training, compulsory and elective training activities.

4. ENROLLMENT OBJECT
✔ In accordance with regulations on formal university enrollment; college enrollment of the Ministry of Education and Training.
✔ In accordance with regulations on enrollment of FPT university.

5. TRAINING PROCESS, GRADUATING CONDITIONS
✔ In accordance with regulations on formal university and college training of the Ministry of Education and Training.
✔ In accordance with regulations on training of FPT University.

6. EVALUATION METHOD
✔ In accordance with regulations on examination and assessment in the training regulations of FPT University.

1. MỤC TIÊU ĐÀO TẠO

1.1 Mục tiêu chung:

Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT), chuyên ngành An toàn thông tin (ATTT) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.

1.2 Mục tiêu cụ thể:

Sinh viên tốt nghiệp chương trình đào tạo CNTT phải thể hiện được những điều sau đây:

PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.

PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.

PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu).

PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.

PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

- Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành ATTT có cơ hội việc làm đa dạng với một số vị trí điển hình như:
✔ Chuyên viên quản trị an ninh mạng, cơ sở dữ liệu;
✔ Chuyên viên kiểm tra, đánh giá an toàn thông tin cho mạng và hệ thống;
✔ Chuyên gia rà soát lỗ hổng, điểm yếu và xử lý sự cố an toàn thông tin;
✔ Chuyên gia lập trình và phát triển ứng dụng đảm bảo an toàn thông tin;
✔ Chuyên viên phân tích, tư vấn, thiết kế hệ thống thông tin đảm bảo an toàn.


2. CHUẨN ĐẦU RA

3. KHỐI LƯỢNG KIẾN THỨC TOÀN KHOÁ: 145 tín chỉ, chưa kể Tiếng Anh chuẩn bị, Giáo dục Quốc phòng, các hoạt động rèn luyện bắt buộc và tự chọn.

4. ĐỐI TƯỢNG TUYỂN SINH
✔ Theo quy chế tuyển sinh đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế tuyển sinh của trường Đại học FPT.

5. QUY TRÌNH ĐÀO TẠO, ĐIỀU KIỆN TỐT NGHIỆP
✔ Thực hiện theo quy chế đào tạo đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế đào tạo của trường Đại học FPT.

6. CÁCH THỨC ĐÁNH GIÁ
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.'),
('BIT_IA_K16B',10,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. TRAINING OBJECTIVES

1.1. General objectives:

Training Information Technology (IT)/ Information Assurance (IA) engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialties.
The training program aims to:
a) To equip students with fundamental knowledge of the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialties;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply fundamental knowledge and specialized knowledge into practical work;
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in study, work and life.

1.2 Specific objectives:
Graduates of the IT training program/IA specialty must demonstrate the following:
PO1. Having basic knowledge of social sciences, politics and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.

PO2. Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.

PO3. Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society);

PO4. Can use English well in study and work and a second foreign language in normal communication.

PO5. Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.

- Job placement after graduation:
Engineers graduating IA specialty have diverse employment opportunities with a number of typical positions such as:
✔ Network and database security administrators;
✔ Engineers in testing and evaluating information assurance for networks and systems;
✔ Engineers in reviewing vulnerabilities, weaknesses and handling information assurance incidents;
✔ Developer in programming and developing applications to ensure information assurance;
✔ Counselor in analyzing, consulting, designing safety information systems.

2. PROGRAM LEARNING OUTCOMES

3. VOLUME OF LEARNING OF THE COURSE: 145 credits, excluding Preparation English, Military Training, compulsory and elective training activities.

4. ENROLLMENT OBJECT
✔ In accordance with regulations on formal university enrollment; college enrollment of the Ministry of Education and Training.
✔ In accordance with regulations on enrollment of FPT university.

5. TRAINING PROCESS, GRADUATING CONDITIONS
✔ In accordance with regulations on formal university and college training of the Ministry of Education and Training.
✔ In accordance with regulations on training of FPT University.

6. EVALUATION METHOD
✔ In accordance with regulations on examination and assessment in the training regulations of FPT University.

1. MỤC TIÊU ĐÀO TẠO

1.1 Mục tiêu chung:

Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT), chuyên ngành An toàn thông tin (ATTT) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.

1.2 Mục tiêu cụ thể:

Sinh viên tốt nghiệp chương trình đào tạo CNTT phải thể hiện được những điều sau đây:

PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.

PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.

PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu).

PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.

PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

- Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành ATTT có cơ hội việc làm đa dạng với một số vị trí điển hình như:
✔ Chuyên viên quản trị an ninh mạng, cơ sở dữ liệu;
✔ Chuyên viên kiểm tra, đánh giá an toàn thông tin cho mạng và hệ thống;
✔ Chuyên gia rà soát lỗ hổng, điểm yếu và xử lý sự cố an toàn thông tin;
✔ Chuyên gia lập trình và phát triển ứng dụng đảm bảo an toàn thông tin;
✔ Chuyên viên phân tích, tư vấn, thiết kế hệ thống thông tin đảm bảo an toàn.


2. CHUẨN ĐẦU RA

3. KHỐI LƯỢNG KIẾN THỨC TOÀN KHOÁ: 145 tín chỉ, chưa kể Tiếng Anh chuẩn bị, Giáo dục Quốc phòng, các hoạt động rèn luyện bắt buộc và tự chọn.

4. ĐỐI TƯỢNG TUYỂN SINH
✔ Theo quy chế tuyển sinh đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế tuyển sinh của trường Đại học FPT.

5. QUY TRÌNH ĐÀO TẠO, ĐIỀU KIỆN TỐT NGHIỆP
✔ Thực hiện theo quy chế đào tạo đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế đào tạo của trường Đại học FPT.

6. CÁCH THỨC ĐÁNH GIÁ
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.'),
('BBA_MKT_K16B',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (16 subjects – 55 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (10 subjects – 37 credits): Provide the general knowledge of marketing, including behavior, services, integrated marketing, branding, and marketing in the internet era. Equip students with all the tools for marketing, selling, brand developing activities, and independent research in marketing field.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and skills in two minors: Digital marketing tools and Brand and event management.

Upon graduation, students can build their career in the fields of digital marketing, market research, advertising and public relations, event organizing, sales, marketing management, and start-up.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) Trường Đại học FPT nhằm đào tạo người học thành các nhà chuyên môn trong các lĩnh vực quản trị kinh doanh, nhà quản lý, doanh nhân tiềm năng năng động và sáng tạo làm việc được trong môi trường quốc tế, tạo tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.


Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (16 môn – 55 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (10 môn – 37 tín chỉ): Cung cấp các kiến thức chung về các lĩnh vực marketing gồm hành vi, dịch vụ, marketing tích hợp, thương hiệu và marketing thời đại internet. Trang bị cho người học các công cụ phục vụ hoạt động marketing, bán hàng, phát triển thương hiệu, và nghiên cứu độc lập trong lĩnh vực marketing.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức và kỹ năng chuyên sâu về hai lĩnh vực: Công cụ marketing số và quản trị thương hiệu và sự kiện.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.'),
('BBA_MKT_K16C',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (16 subjects – 55 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (10 subjects – 37 credits): Provide the general knowledge of marketing, including behavior, services, integrated marketing, branding, and marketing in the internet era. Equip students with all the tools for marketing, selling, brand developing activities, and independent research in marketing field.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and skills in two minors: Digital marketing tools and Brand and event management.

Upon graduation, students can build their career in the fields of digital marketing, market research, advertising and public relations, event organizing, sales, marketing management, and start-up.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) Trường Đại học FPT nhằm đào tạo người học thành các nhà chuyên môn trong các lĩnh vực quản trị kinh doanh, nhà quản lý, doanh nhân tiềm năng năng động và sáng tạo làm việc được trong môi trường quốc tế, tạo tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.


Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (16 môn – 55 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (10 môn – 37 tín chỉ): Cung cấp các kiến thức chung về các lĩnh vực marketing gồm hành vi, dịch vụ, marketing tích hợp, thương hiệu và marketing thời đại internet. Trang bị cho người học các công cụ phục vụ hoạt động marketing, bán hàng, phát triển thương hiệu, và nghiên cứu độc lập trong lĩnh vực marketing.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức và kỹ năng chuyên sâu về hai lĩnh vực: Công cụ marketing số và quản trị thương hiệu và sự kiện.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.'),
('BIT_GD_K16B',5,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. Training Objectives
General objective: Training Bachelor of Information Technology, Digital Art & Design specialty with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty, being able to work in the international environment, and laying the foundation to pursue further study and research in Digital Art & Design.
Specific objectives:
PO1: Develop physically, mentally, intellectually, morally and deepen national pride by equipping students with general knowledge of politics, law, economy, society, physical education, music and national defense education.
PO2: Provide students with fundamental knowledge of the IT industry as well as methodologies and in-depth technologies of the Digital Art & Design major.
PO3: Help students use modern digital-oriented tools, equipment and softwares proficiently. Train students to flexibly apply knowledge and skills in the visual arts and come up with effective and appropriate visual communication solutions.
PO4: Shape the right attitudes and work ethics, abilities to think creatively, work well in groups and independently and abilities to solve problems related to digital art and design effectively, and be capable of lifelong learning for personal and professional development.
PO5: Help students use English fluently and a second language at a basic level.
Job positions after graduation:
Graduates of the Digital Art & Design major can take charge of the following position:
- Designer of the company, the design dew, advertising agencies, marketing, television, games (games).
- Expert 2D, 3D, visual effects, sound effects.
- User experience design experts.
- Design team leader.
- Creative director.
- Researchers / Lecturers / Postgraduates: can carry out research activities in centers that conduct research in the field of digital art and design.
1. Mục tiêu đào tạo
Mục tiêu chung: Đào tạo cử nhân ngành Công nghệ thông tin (CNTT), chuyên ngành Thiết kế mỹ thuật số có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến chuyên ngành được đào tạo, làm việc được trong môi trường quốc tế, tạo tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn về chuyên ngành TKMTS.
Mục tiêu cụ thể:
PO1: Phát triển về thể chất, tinh thần, trí tuệ, nhân sinh quan, lòng tự hào dân tộc thông qua trang bị cho người học những kiến thức tổng quát về lý luận chính trị, pháp luật, kinh tế, xã hội, giáo dục thể chất, âm nhạc, giáo dục quốc phòng.
PO2: Cung cấp cho người học những kiến thức cơ bản của ngành cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành Thiết kế mỹ thuật số.
PO3: Giúp người học sử dụng thành thạo các công cụ, thiết bị, phần mềm hiện đại theo định hướng kỹ thuật số. Đồng thời, ứng dụng linh hoạt kiến thức, kỹ năng về nghệ thuật thị giác, đưa ra giải pháp truyền thông thị giác hiệu quả và phù hợp với thời đại.
PO4: Hình thành cho người học thái độ và đạo đức nghề nghiệp đúng đắn, có khả năng tư duy sáng tạo, làm việc nhóm, làm việc độc lập và có năng lực giải quyết các vấn đề liên quan tới thiết kế mỹ thuật số một cách hiệu quả, có khả năng tự học tập suốt đời để phát triển bản thân và công việc,
PO5: Giúp người học sử dụng thành thạo tiếng Anh và một ngoại ngữ hai ở mức cơ bản.
Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành Thiết kế Mỹ thuật số có thể đảm nhiệm một số công việc sau:
- Họa sĩ thiết kế trong các công ty, các xưởng thiết kế, công ty quảng cáo, marketing, truyền hình, trò chơi (game).
- Chuyên gia 2D, 3D, hiệu ứng hình ảnh, âm thanh.
- Chuyên gia thiết kế trải nghiệm người dùng (UX).
- Trưởng nhóm thiết kế.
- Giám đốc sáng tạo.
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.
IsActive: True'),
('BIT_GD_K16C',5,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. Training Objectives
General objective: Training Bachelor of Information Technology, Digital Art & Design specialty with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty, being able to work in the international environment, and laying the foundation to pursue further study and research in Digital Art & Design.
Specific objectives:
PO1: Develop physically, mentally, intellectually, morally and deepen national pride by equipping students with general knowledge of politics, law, economy, society, physical education, music and national defense education.
PO2: Provide students with fundamental knowledge of the IT industry as well as methodologies and in-depth technologies of the Digital Art & Design major.
PO3: Help students use modern digital-oriented tools, equipment and softwares proficiently. Train students to flexibly apply knowledge and skills in the visual arts and come up with effective and appropriate visual communication solutions.
PO4: Shape the right attitudes and work ethics, abilities to think creatively, work well in groups and independently and abilities to solve problems related to digital art and design effectively, and be capable of lifelong learning for personal and professional development.
PO5: Help students use English fluently and a second language at a basic level.
Job positions after graduation:
Graduates of the Digital Art & Design major can take charge of the following position:
- Designer of the company, the design dew, advertising agencies, marketing, television, games (games).
- Expert 2D, 3D, visual effects, sound effects.
- User experience design experts.
- Design team leader.
- Creative director.
- Researchers / Lecturers / Postgraduates: can carry out research activities in centers that conduct research in the field of digital art and design.
1. Mục tiêu đào tạo
Mục tiêu chung: Đào tạo cử nhân ngành Công nghệ thông tin (CNTT), chuyên ngành Thiết kế mỹ thuật số có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến chuyên ngành được đào tạo, làm việc được trong môi trường quốc tế, tạo tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn về chuyên ngành TKMTS.
Mục tiêu cụ thể:
PO1: Phát triển về thể chất, tinh thần, trí tuệ, nhân sinh quan, lòng tự hào dân tộc thông qua trang bị cho người học những kiến thức tổng quát về lý luận chính trị, pháp luật, kinh tế, xã hội, giáo dục thể chất, âm nhạc, giáo dục quốc phòng.
PO2: Cung cấp cho người học những kiến thức cơ bản của ngành cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành Thiết kế mỹ thuật số.
PO3: Giúp người học sử dụng thành thạo các công cụ, thiết bị, phần mềm hiện đại theo định hướng kỹ thuật số. Đồng thời, ứng dụng linh hoạt kiến thức, kỹ năng về nghệ thuật thị giác, đưa ra giải pháp truyền thông thị giác hiệu quả và phù hợp với thời đại.
PO4: Hình thành cho người học thái độ và đạo đức nghề nghiệp đúng đắn, có khả năng tư duy sáng tạo, làm việc nhóm, làm việc độc lập và có năng lực giải quyết các vấn đề liên quan tới thiết kế mỹ thuật số một cách hiệu quả, có khả năng tự học tập suốt đời để phát triển bản thân và công việc,
PO5: Giúp người học sử dụng thành thạo tiếng Anh và một ngoại ngữ hai ở mức cơ bản.
Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành Thiết kế Mỹ thuật số có thể đảm nhiệm một số công việc sau:
- Họa sĩ thiết kế trong các công ty, các xưởng thiết kế, công ty quảng cáo, marketing, truyền hình, trò chơi (game).
- Chuyên gia 2D, 3D, hiệu ứng hình ảnh, âm thanh.
- Chuyên gia thiết kế trải nghiệm người dùng (UX).
- Trưởng nhóm thiết kế.
- Giám đốc sáng tạo.
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.'),
('BBA_FIN_K16B',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (16 subjects – 55 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (10 subjects – 37 credits): Provide the general knowledge of financial markets and investment behavior, and in-depth knowledge of financial models, asset pricing, and financial risk management. Equip students with skills and tools for financial analyses, financial decision making, and independent research in finance field.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and skills in two minors: Investment finance and Corporate finance.

Upon graduation, students can build their career in the fields of financial analyses, financial advisory, financial brokerage, accounting, auditing, financial management, and start-up.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Tài chính củaTrường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về quản trị tài chính, nhà quản lý, doanh nhân tiềm năng. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực tài chinh và trong môi trường quốc tế, tạo tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (16 môn – 55 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (10 môn – 37 tín chỉ): Cung cấp các kiến thức chung về thị trường tài chính và hành vi đầu tư, các kiến thức chuyên sâu về mô hình tài chính, định giá tài chính và quản trị rủi ro tài chính. Trang bị cho người học các kỹ năng và công cụ để phân tích tài chính, ra quyết định đầu tư, và nghiên cứu độc lập trong lĩnh vực tài chính.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức và kỹ năng chuyên sâu về hai lĩnh vực: Tài chính đầu tư và tài chính doanh nghiệp.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.'),
('BBA_FIN_K16C',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (16 subjects – 55 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (10 subjects – 37 credits): Provide the general knowledge of financial markets and investment behavior, and in-depth knowledge of financial models, asset pricing, and financial risk management. Equip students with skills and tools for financial analyses, financial decision making, and independent research in finance field.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and skills in two minors: Investment finance and Corporate finance.

Upon graduation, students can build their career in the fields of financial analyses, financial advisory, financial brokerage, accounting, auditing, financial management, and start-up.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Tài chính củaTrường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về quản trị tài chính, nhà quản lý, doanh nhân tiềm năng. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực tài chinh và trong môi trường quốc tế, tạo tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (16 môn – 55 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (10 môn – 37 tín chỉ): Cung cấp các kiến thức chung về thị trường tài chính và hành vi đầu tư, các kiến thức chuyên sâu về mô hình tài chính, định giá tài chính và quản trị rủi ro tài chính. Trang bị cho người học các kỹ năng và công cụ để phân tích tài chính, ra quyết định đầu tư, và nghiên cứu độc lập trong lĩnh vực tài chính.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức và kỹ năng chuyên sâu về hai lĩnh vực: Tài chính đầu tư và tài chính doanh nghiệp.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.'),
('BBA_IB_K16B',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (16 subjects – 55 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (10 subjects – 37 credits): Provide the general knowledge of international business, international supply chains, international finance and payment, and cultural aspects in international business. Equip students with skills including negotiation, business strategy analyses, processes and techniques in international business, and independent research in international business field.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and skills in two minors: International business and Logistics and Supply chain management.

Upon graduation, students can build their career in the fields of international financial analyses and investment, export and import, transportation and logistics, supply chain management, international marketing, business and procurement, and start-up.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Kinh doanh quốc tế củaTrường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về kinh doanh quốc tế, nhà quản lý, doanh nhân tiềm năng. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực kinh doanh quốc tế và trong môi trường quốc tế, tạo tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (16 môn – 55 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (10 môn – 37 tín chỉ): Cung cấp các kiến thức chung về kinh doanh quốc tế, chuỗi cung ứng quốc tế, các kiến thức về tài chính và thanh toán quốc tế, và các yếu tố văn hóa trong kinh doanh quốc tế. Trang bị cho người học các kỹ năng đàm phán, phân tích các chiến lược kinh doanh, các thủ tục và nghiệp vụ kinh doanh quốc tế, và nghiên cứu độc lập trong lĩnh vực kinh doanh quốc tế.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức và kỹ năng chuyên sâu về hai lĩnh vực: Kinh doanh quốc tế và Logistics và quản trị chuỗi cung ứng.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.'),
('BBA_IB_K16C',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (16 subjects – 55 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (10 subjects – 37 credits): Provide the general knowledge of international business, international supply chains, international finance and payment, and cultural aspects in international business. Equip students with skills including negotiation, business strategy analyses, processes and techniques in international business, and independent research in international business field.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and skills in two minors: International business and Logistics and Supply chain management.

Upon graduation, students can build their career in the fields of international financial analyses and investment, export and import, transportation and logistics, supply chain management, international marketing, business and procurement, and start-up.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Kinh doanh quốc tế củaTrường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về kinh doanh quốc tế, nhà quản lý, doanh nhân tiềm năng. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực kinh doanh quốc tế và trong môi trường quốc tế, tạo tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (16 môn – 55 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (10 môn – 37 tín chỉ): Cung cấp các kiến thức chung về kinh doanh quốc tế, chuỗi cung ứng quốc tế, các kiến thức về tài chính và thanh toán quốc tế, và các yếu tố văn hóa trong kinh doanh quốc tế. Trang bị cho người học các kỹ năng đàm phán, phân tích các chiến lược kinh doanh, các thủ tục và nghiệp vụ kinh doanh quốc tế, và nghiên cứu độc lập trong lĩnh vực kinh doanh quốc tế.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức và kỹ năng chuyên sâu về hai lĩnh vực: Kinh doanh quốc tế và Logistics và quản trị chuỗi cung ứng.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.'),
('BIT_SE_K16B',1,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a ) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply specialized knowledge of SE specialty into practical work
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in study, work and life
1.2 Specific objectives:
Graduates of the IT training program/SE specialty must demonstrate the following:
PO1. Having basic knowledge of social sciences, politics and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.
PO2. Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.
PO3. Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society);
PO4. Can use English well in study and work and a second foreign language in normal communication.
PO5. Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.

1.3. Job positions after graduation:
Graduates of Software Engineering can choose for themselves the following jobs:
✔ Application development programmers
✔ Business analysts
✔ Software quality assurance engineers
✔ Software process engineers
✔ Software project administrators

2. Program Learning Outcomes

3. Volume of learning of the course: 145 credits, excluding Preparation English, Military Training, compulsory and elective training activities.

4. Enrollment object
✔ In accordance with regulations on formal university enrollment; college enrollment of the Ministry of Education and Training.
✔ In accordance with regulations on enrollment of FPT university.

5. Training process, graduating conditions
✔ In accordance with regulations on formal university and college training of the Ministry of Education and Training.
✔ In accordance with regulations on training of FPT University.

6. Evaluation method
✔ In accordance with regulations on examination and assessment in the training regulations of FPT University.

1. Mục tiêu đào tạo
1.1 Mục tiêu chung:
Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT)/chuyên ngành Kỹ thuật phần mềm (KTPM) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.
1.2 Mục tiêu cụ thể:
Sinh viên tốt nghiệp chương trình đào tạo phải thể hiện được những điều sau đây:
PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.
PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.
PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu);
PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.
PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

1.3. Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành Kỹ thuật phần mềm có thể lựa chọn cho mình những công việc như:
✔ Lập trình viên phát triển ứng dụng
✔ Chuyên viên phân tích nghiệp vụ
✔ Kỹ sư đảm bảo chất lượng phần mềm
✔ Kỹ sư quy trình sản xuất phần mềm
✔ Quản trị viên dự án phần mềm

2. Chuẩn đầu ra

3. Khối lượng kiến thức toàn khóa

4. Đối tượng tuyển sinh
✔ Theo quy chế tuyển sinh đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế tuyển sinh của trường Đại học FPT.

5. Quy trình đào tạo, điều kiện tốt nghiệp
✔ Thực hiện theo quy chế đào tạo đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế đào tạo của trường Đại học FPT.

6. Cách thức đánh giá
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.'),
('BIT_SE_K16C',1,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a ) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply specialized knowledge of SE specialty into practical work
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in study, work and life
1.2 Specific objectives:
Graduates of the IT training program/SE specialty must demonstrate the following:
PO1. Having basic knowledge of social sciences, politics and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.
PO2. Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.
PO3. Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society);
PO4. Can use English well in study and work and a second foreign language in normal communication.
PO5. Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.

1.3. Job positions after graduation:
Graduates of Software Engineering can choose for themselves the following jobs:
✔ Application development programmers
✔ Business analysts
✔ Software quality assurance engineers
✔ Software process engineers
✔ Software project administrators

2. Program Learning Outcomes

3. Volume of learning of the course: 145 credits, excluding Preparation English, Military Training, compulsory and elective training activities.

4. Enrollment object
✔ In accordance with regulations on formal university enrollment; college enrollment of the Ministry of Education and Training.
✔ In accordance with regulations on enrollment of FPT university.

5. Training process, graduating conditions
✔ In accordance with regulations on formal university and college training of the Ministry of Education and Training.
✔ In accordance with regulations on training of FPT University.

6. Evaluation method
✔ In accordance with regulations on examination and assessment in the training regulations of FPT University.

1. Mục tiêu đào tạo
1.1 Mục tiêu chung:
Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT)/chuyên ngành Kỹ thuật phần mềm (KTPM) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.
1.2 Mục tiêu cụ thể:
Sinh viên tốt nghiệp chương trình đào tạo phải thể hiện được những điều sau đây:
PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.
PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.
PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu);
PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.
PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

1.3. Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành Kỹ thuật phần mềm có thể lựa chọn cho mình những công việc như:
✔ Lập trình viên phát triển ứng dụng
✔ Chuyên viên phân tích nghiệp vụ
✔ Kỹ sư đảm bảo chất lượng phần mềm
✔ Kỹ sư quy trình sản xuất phần mềm
✔ Quản trị viên dự án phần mềm

2. Chuẩn đầu ra

3. Khối lượng kiến thức toàn khóa

4. Đối tượng tuyển sinh
✔ Theo quy chế tuyển sinh đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế tuyển sinh của trường Đại học FPT.

5. Quy trình đào tạo, điều kiện tốt nghiệp
✔ Thực hiện theo quy chế đào tạo đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế đào tạo của trường Đại học FPT.

6. Cách thức đánh giá
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.'),
('BIT_IS_K16B',7,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Information System (IS) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply specialized knowledge of IS specialty into practical work
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in study, work and life
1.2 Specific objectives:
Graduates of the IT training program/IS specialty must demonstrate the following:
PO1. Having basic knowledge of social sciences, politics and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.
PO2. Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.
PO3. Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society);
PO4. Can use English well in study and work and a second foreign language in normal communication.
PO5. Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.

1.3. Job positions after graduation:
Graduates of Information Systems have diverse employment opportunities with some typical job positions such as:
✔ Administrators of the database systems
✔ Information system designers, analysts, consultants
✔ Specialists developing applications for information systems
✔ Experts specializing in deploying and operating ERP and CRM systems
✔ Managers of information/knowledge systems

2. Program Learning Outcomes

3. Volume of learning of the course: 145 credits, excluding Preparation English, Military Training, compulsory and elective training activities.

4. Enrollment object
✔ In accordance with regulations on formal university enrollment; college enrollment of the Ministry of Education and Training.
✔ In accordance with regulations on enrollment of FPT university.

5. Training process, graduating conditions
✔ In accordance with regulations on formal university and college training of the Ministry of Education and Training.
✔ In accordance with regulations on training of FPT University.

6. Evaluation method
✔ In accordance with regulations on examination and assessment in the training regulations of FPT University.

1. Mục tiêu đào tạo
1.1 Mục tiêu chung:
Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT)/chuyên ngành Hệ thống thông tin (IS) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.
1.2 Mục tiêu cụ thể:
Sinh viên tốt nghiệp chương trình đào tạo CNTT phải thể hiện được những điều sau đây:

1.3. Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành Hệ thống thông tin có cơ hội việc làm rất đa dạng với một số vị trí công việc điển hình như:
✔ Quản trị viên các hệ cơ sở dữ liệu;
✔ Chuyên viên phân tích, tư vấn, thiết kế hệ thống thông tin;
✔ Chuyên viên phát triển ứng dụng cho hệ thống thông tin;
✔ Chuyên viên triển khai, vận hành các hệ thống ERP, CRM;
✔ Quản trị hệ thống thông tin và tri thức.

2. Chuẩn đầu ra

3. Khối lượng kiến thức toàn khóa

4. Đối tượng tuyển sinh
✔ Theo quy chế tuyển sinh đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế tuyển sinh của trường Đại học FPT.

5. Quy trình đào tạo, điều kiện tốt nghiệp
✔ Thực hiện theo quy chế đào tạo đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế đào tạo của trường Đại học FPT.

6. Cách thức đánh giá
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.'),
('BIT_IS_K16C',7,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Information System (IS) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply specialized knowledge of IS specialty into practical work
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in study, work and life
1.2 Specific objectives:
Graduates of the IT training program/IS specialty must demonstrate the following:
PO1. Having basic knowledge of social sciences, politics and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.
PO2. Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.
PO3. Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society);
PO4. Can use English well in study and work and a second foreign language in normal communication.
PO5. Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.

1.3. Job positions after graduation:
Graduates of Information Systems have diverse employment opportunities with some typical job positions such as:
✔ Administrators of the database systems
✔ Information system designers, analysts, consultants
✔ Specialists developing applications for information systems
✔ Experts specializing in deploying and operating ERP and CRM systems
✔ Managers of information/knowledge systems

2. Program Learning Outcomes

3. Volume of learning of the course: 145 credits, excluding Preparation English, Military Training, compulsory and elective training activities.

4. Enrollment object
✔ In accordance with regulations on formal university enrollment; college enrollment of the Ministry of Education and Training.
✔ In accordance with regulations on enrollment of FPT university.

5. Training process, graduating conditions
✔ In accordance with regulations on formal university and college training of the Ministry of Education and Training.
✔ In accordance with regulations on training of FPT University.

6. Evaluation method
✔ In accordance with regulations on examination and assessment in the training regulations of FPT University.

1. Mục tiêu đào tạo
1.1 Mục tiêu chung:
Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT)/chuyên ngành Hệ thống thông tin (IS) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.
1.2 Mục tiêu cụ thể:
Sinh viên tốt nghiệp chương trình đào tạo CNTT phải thể hiện được những điều sau đây:

1.3. Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành Hệ thống thông tin có cơ hội việc làm rất đa dạng với một số vị trí công việc điển hình như:
✔ Quản trị viên các hệ cơ sở dữ liệu;
✔ Chuyên viên phân tích, tư vấn, thiết kế hệ thống thông tin;
✔ Chuyên viên phát triển ứng dụng cho hệ thống thông tin;
✔ Chuyên viên triển khai, vận hành các hệ thống ERP, CRM;
✔ Quản trị hệ thống thông tin và tri thức.

2. Chuẩn đầu ra

3. Khối lượng kiến thức toàn khóa

4. Đối tượng tuyển sinh
✔ Theo quy chế tuyển sinh đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế tuyển sinh của trường Đại học FPT.

5. Quy trình đào tạo, điều kiện tốt nghiệp
✔ Thực hiện theo quy chế đào tạo đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế đào tạo của trường Đại học FPT.

6. Cách thức đánh giá
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.'),
('BIT_AI_K16B',8,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Artificial Intelligence (AI) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply specialized knowledge of AI specialty into practical work
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in study, work and life
1.2 Specific objectives:
Graduates of the IT training program/AI specialty must demonstrate the following:
PO1. Having basic knowledge of social sciences, politics and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.
PO2. Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.
PO3. Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society);
PO4. Can use English well in study and work and a second foreign language in normal communication.
PO5. Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.

1.3. Job positions after graduation:
Engineers graduating AI specialty have diverse employment opportunities with a number of typical positions such as:
✔ AI application development engineers
✔ Automation system and robot developer
✔ Data architects
✔ Researchers in the Artificial Intelligence field

2. Program Learning Outcomes

3. Volume of learning of the course: 145 credits, excluding Preparation English, Military Training, compulsory and elective training activities.

4. Enrollment object
✔ In accordance with regulations on formal university enrollment; college enrollment of the Ministry of Education and Training.
✔ In accordance with regulations on enrollment of FPT university.

5. Training process, graduating conditions
✔ In accordance with regulations on formal university and college training of the Ministry of Education and Training.
✔ In accordance with regulations on training of FPT University.

6. Evaluation method
✔ In accordance with regulations on examination and assessment in the training regulations of FPT University.

1. Mục tiêu đào tạo
1.1 Mục tiêu chung:
Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT)/chuyên ngành Trí tuệ nhân tạo (TTNT) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.
1.2 Mục tiêu cụ thể:
Sinh viên tốt nghiệp chương trình đào tạo phải thể hiện được những điều sau đây:
PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.
PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.
PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu);
PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.
PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

1.3. Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành Trí tuệ nhân tạo có cơ hội việc làm đa dạng với một số vị trí điển hình như:
✔ Kỹ sư phát triển ứng dụng AI
✔ Kỹ sư phát triển hệ thống tự động hóa, robot
✔ Kiến trúc sư dữ liệu
✔ Chuyên gia nghiên cứu chuyên sâu về trí tuệ nhân tạo

2. Chuẩn đầu ra

3. Khối lượng kiến thức toàn khóa

4. Đối tượng tuyển sinh
✔ Theo quy chế tuyển sinh đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế tuyển sinh của trường Đại học FPT.

5. Quy trình đào tạo, điều kiện tốt nghiệp
✔ Thực hiện theo quy chế đào tạo đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế đào tạo của trường Đại học FPT.

6. Cách thức đánh giá
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.'),
('BIT_AI_K16C',8,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Artificial Intelligence (AI) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply specialized knowledge of AI specialty into practical work
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in study, work and life
1.2 Specific objectives:
Graduates of the IT training program/AI specialty must demonstrate the following:
PO1. Having basic knowledge of social sciences, politics and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.
PO2. Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.
PO3. Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society);
PO4. Can use English well in study and work and a second foreign language in normal communication.
PO5. Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.

1.3. Job positions after graduation:
Engineers graduating AI specialty have diverse employment opportunities with a number of typical positions such as:
✔ AI application development engineers
✔ Automation system and robot developer
✔ Data architects
✔ Researchers in the Artificial Intelligence field

2. Program Learning Outcomes

3. Volume of learning of the course: 145 credits, excluding Preparation English, Military Training, compulsory and elective training activities.

4. Enrollment object
✔ In accordance with regulations on formal university enrollment; college enrollment of the Ministry of Education and Training.
✔ In accordance with regulations on enrollment of FPT university.

5. Training process, graduating conditions
✔ In accordance with regulations on formal university and college training of the Ministry of Education and Training.
✔ In accordance with regulations on training of FPT University.

6. Evaluation method
✔ In accordance with regulations on examination and assessment in the training regulations of FPT University.

1. Mục tiêu đào tạo
1.1 Mục tiêu chung:
Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT)/chuyên ngành Trí tuệ nhân tạo (TTNT) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.
1.2 Mục tiêu cụ thể:
Sinh viên tốt nghiệp chương trình đào tạo phải thể hiện được những điều sau đây:
PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.
PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.
PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu);
PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.
PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

1.3. Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành Trí tuệ nhân tạo có cơ hội việc làm đa dạng với một số vị trí điển hình như:
✔ Kỹ sư phát triển ứng dụng AI
✔ Kỹ sư phát triển hệ thống tự động hóa, robot
✔ Kiến trúc sư dữ liệu
✔ Chuyên gia nghiên cứu chuyên sâu về trí tuệ nhân tạo

2. Chuẩn đầu ra

3. Khối lượng kiến thức toàn khóa

4. Đối tượng tuyển sinh
✔ Theo quy chế tuyển sinh đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế tuyển sinh của trường Đại học FPT.

5. Quy trình đào tạo, điều kiện tốt nghiệp
✔ Thực hiện theo quy chế đào tạo đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế đào tạo của trường Đại học FPT.

6. Cách thức đánh giá
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.'),
('BBA_TM_K16B',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (16 subjects – 55 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (10 subjects – 37 credits): Provide the general and in-depth knowledge of tourism and travel management and operation, psychology and behavior of tourists, Vietnamese and and culture, Vietnamese tourism geography. Equip students with skills including entrepreneurship, applied statistics, tour and event organization, and independent research in tourism and travel management.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and skills in two minors: Tour operation and Tour guide.

Upon graduation, students can build their career in tourism businesses, tour consultancy and organization, event and teambuilding organization, tourism promotion, international relation, tourism education, and start-ups in tourism and travel management.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Quản trị Dịch vụ Du lịch và Lữ hành củaTrường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về du lịch và lữ hành, các hướng dẫn viên, các nhà quản lý và điều hành dịch vụ du lịch và lữ hành. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực du lịch và lữ hành và trong môi trường quốc tế hoặc tạo tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (16 môn – 55 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (10 môn – 37 tín chỉ): Cung cấp các kiến thức chung và chuyên sâu về vận hành và quản trị kinh doanh du lịch và lữ hành, kiến thức về tâm lý và hành vi tiêu dung của khách du lịch, kiến thức lịch sử và văn hóa Việt Nam, địa lý du lịch Viêt Nam. Trang bị cho người học kỹ năng về tư duy kinh doanh, các công cụ thống kê ứng dụng, các nghiệp vụ du lịch và tổ chức sự kiện, và kỹ năng nghiên cứu độc lập trong lĩnh vực du lịch và lữ hành.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức và kỹ năng chuyên sâu về hai lĩnh vực: Điều hành tour và Hướng dẫn du lịch.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.'),
('BBA_TM_K16C',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (16 subjects – 55 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (10 subjects – 37 credits): Provide the general and in-depth knowledge of tourism and travel management and operation, psychology and behavior of tourists, Vietnamese and and culture, Vietnamese tourism geography. Equip students with skills including entrepreneurship, applied statistics, tour and event organization, and independent research in tourism and travel management.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and skills in two minors: Tour operation and Tour guide.

Upon graduation, students can build their career in tourism businesses, tour consultancy and organization, event and teambuilding organization, tourism promotion, international relation, tourism education, and start-ups in tourism and travel management.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Quản trị Dịch vụ Du lịch và Lữ hành củaTrường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về du lịch và lữ hành, các hướng dẫn viên, các nhà quản lý và điều hành dịch vụ du lịch và lữ hành. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực du lịch và lữ hành và trong môi trường quốc tế hoặc tạo tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (16 môn – 55 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (10 môn – 37 tín chỉ): Cung cấp các kiến thức chung và chuyên sâu về vận hành và quản trị kinh doanh du lịch và lữ hành, kiến thức về tâm lý và hành vi tiêu dung của khách du lịch, kiến thức lịch sử và văn hóa Việt Nam, địa lý du lịch Viêt Nam. Trang bị cho người học kỹ năng về tư duy kinh doanh, các công cụ thống kê ứng dụng, các nghiệp vụ du lịch và tổ chức sự kiện, và kỹ năng nghiên cứu độc lập trong lĩnh vực du lịch và lữ hành.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức và kỹ năng chuyên sâu về hai lĩnh vực: Điều hành tour và Hướng dẫn du lịch.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.'),
('BIT_IoT_K16B',11,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. TRAINING OBJECTIVES

1.1. General objectives:

Training Information Technology (IT)/Internet of Things (IoT) engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialties.
The training program aims to:
a) To equip students with fundamental knowledge of the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialties;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply fundamental knowledge and specialized knowledge into practical work;
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in the study, work and life.

1.2 Specific objectives:
Graduates of the IT training program/IoT specialty must demonstrate the following:
PO1. Having basic knowledge of social sciences, politics, and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.

PO2. Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.

PO3. Mastering professional skills and soft skills of 21st-century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society);

PO4. Can use English well in study and work and a second foreign language in normal communication.

PO5. Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative, and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.

- Job placement after graduation:
Engineers graduating IoT specialty have diverse employment opportunities with a number of typical positions such as:
✔ Developer for IoT application;
✔ Specialist for software development and embedded systems;
✔ Integrated system architect.

2. PROGRAM LEARNING OUTCOMES

3. VOLUME OF LEARNING OF THE COURSE: 145 credits, excluding Preparation English, Military Training, compulsory and elective training activities.

4. ENROLLMENT OBJECT
✔ In accordance with regulations on formal university enrollment; college enrollment of the Ministry of Education and Training.
✔ In accordance with regulations on enrollment of FPT University.

5. TRAINING PROCESS, GRADUATING CONDITIONS
✔ In accordance with regulations on formal university and college training of the Ministry of Education and Training.
✔ In accordance with regulations on the training of FPT University.

6. EVALUATION METHOD
✔ In accordance with regulations on examination and assessment in the training regulations of FPT University.

1. MỤC TIÊU ĐÀO TẠO

1.1 Mục tiêu chung:

Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT), chuyên ngành Internet vạn vật (IoT) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.

1.2 Mục tiêu cụ thể:
Sinh viên tốt nghiệp chương trình đào tạo CNTT phải thể hiện được những điều sau đây:

PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.

PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.

PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu).

PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.

PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

- Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành IoT có cơ hội việc làm đa dạng với một số vị trí điển hình như:
✔ Chuyên viên phát triển ứng dụng IoT
✔ Chuyên viên phát triển phần mềm, hệ thống nhúng
✔ Chuyên gia tích hợp hệ thống thông minh từ đơn giản đến phức tạp.

2. CHUẨN ĐẦU RA

3. KHỐI LƯỢNG KIẾN THỨC TOÀN KHOÁ: 145 tín chỉ, chưa kể Tiếng Anh chuẩn bị, Giáo dục Quốc phòng, các hoạt động rèn luyện bắt buộc và tự chọn.

4. ĐỐI TƯỢNG TUYỂN SINH
✔ Theo quy chế tuyển sinh đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế tuyển sinh của trường Đại học FPT.

5. QUY TRÌNH ĐÀO TẠO, ĐIỀU KIỆN TỐT NGHIỆP
✔ Thực hiện theo quy chế đào tạo đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế đào tạo của trường Đại học FPT.

6. CÁCH THỨC ĐÁNH GIÁ
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.'),
('BIT_IoT_K16C',11,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. TRAINING OBJECTIVES

1.1. General objectives:

Training Information Technology (IT)/Internet of Things (IoT) engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialties.
The training program aims to:
a) To equip students with fundamental knowledge of the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialties;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply fundamental knowledge and specialized knowledge into practical work;
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in the study, work and life.

1.2 Specific objectives:
Graduates of the IT training program/IoT specialty must demonstrate the following:
PO1. Having basic knowledge of social sciences, politics, and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.

PO2. Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.

PO3. Mastering professional skills and soft skills of 21st-century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society);

PO4. Can use English well in study and work and a second foreign language in normal communication.

PO5. Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative, and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.

- Job placement after graduation:
Engineers graduating IoT specialty have diverse employment opportunities with a number of typical positions such as:
✔ Developer for IoT application;
✔ Specialist for software development and embedded systems;
✔ Integrated system architect.

2. PROGRAM LEARNING OUTCOMES

3. VOLUME OF LEARNING OF THE COURSE: 145 credits, excluding Preparation English, Military Training, compulsory and elective training activities.

4. ENROLLMENT OBJECT
✔ In accordance with regulations on formal university enrollment; college enrollment of the Ministry of Education and Training.
✔ In accordance with regulations on enrollment of FPT University.

5. TRAINING PROCESS, GRADUATING CONDITIONS
✔ In accordance with regulations on formal university and college training of the Ministry of Education and Training.
✔ In accordance with regulations on the training of FPT University.

6. EVALUATION METHOD
✔ In accordance with regulations on examination and assessment in the training regulations of FPT University.

1. MỤC TIÊU ĐÀO TẠO

1.1 Mục tiêu chung:

Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT), chuyên ngành Internet vạn vật (IoT) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.

1.2 Mục tiêu cụ thể:
Sinh viên tốt nghiệp chương trình đào tạo CNTT phải thể hiện được những điều sau đây:

PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.

PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.

PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu).

PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.

PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

- Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành IoT có cơ hội việc làm đa dạng với một số vị trí điển hình như:
✔ Chuyên viên phát triển ứng dụng IoT
✔ Chuyên viên phát triển phần mềm, hệ thống nhúng
✔ Chuyên gia tích hợp hệ thống thông minh từ đơn giản đến phức tạp.

2. CHUẨN ĐẦU RA

3. KHỐI LƯỢNG KIẾN THỨC TOÀN KHOÁ: 145 tín chỉ, chưa kể Tiếng Anh chuẩn bị, Giáo dục Quốc phòng, các hoạt động rèn luyện bắt buộc và tự chọn.

4. ĐỐI TƯỢNG TUYỂN SINH
✔ Theo quy chế tuyển sinh đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế tuyển sinh của trường Đại học FPT.

5. QUY TRÌNH ĐÀO TẠO, ĐIỀU KIỆN TỐT NGHIỆP
✔ Thực hiện theo quy chế đào tạo đại học, cao đẳng hệ chính quy của Bộ Giáo dục và Đào tạo.
✔ Theo quy chế đào tạo của trường Đại học FPT.

6. CÁCH THỨC ĐÁNH GIÁ
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.'),
('BBA_HM_K16C',9,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','	The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (15 subjects – 52 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (11 subjects – 40 credits): Provide the general and in-depth knowledge of Hotel operation and management; Sales and marketing in hotel business; Hotel revenue management, Event organization. Equip students with management skills in hotel services and working skills in a multicultural environment.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and practical skills in the areas of: Accommodation management; Restaurant management; Event organization.

Upon graduation, students can build their career in the fields of tourism, accommodation management, restaurant&bars , and event management.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Quản trị khách sạn của Trường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về quản trị khách sạn, nhà quản lý, doanh nhân tiềm năng. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực quản trị khách sạn và trong môi trường quốc tế hoặc có tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (15 môn – 52 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (11 môn – 40 tín chỉ): Cung cấp các kiến thức chung và chuyên sâu về quản trị và vận hành lưu trú, bán hàng và marketing trong kinh doanh khách sạn, quản trị doạnh thu khách sạn, tổ chức sự kiện. Trang bị cho người học các kỹ năng tổ chức, quản lý vận hành các dịch vụ khách sạn và các kỹ năng làm việc trong môi trường đa văn hóa.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức chuyên sâu và nghiệp vụ thực tế về các lĩnh vực: Quản trị lưu trú; Quản trị nhà hàng; và Tổ chức sự kiện.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.'),
('BBA_HM_K16B',9,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (15 subjects – 52 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (11 subjects – 40 credits): Provide the general and in-depth knowledge of Hotel operation and management; Sales and marketing in hotel business; Hotel revenue management, Event organization. Equip students with management skills in hotel services and working skills in a multicultural environment.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and practical skills in the areas of: Accommodation management; Restaurant management; Event organization.

Upon graduation, students can build their career in the fields of tourism, accommodation management, restaurant&bars , and event management.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Quản trị khách sạn của Trường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về quản trị khách sạn, nhà quản lý, doanh nhân tiềm năng. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực quản trị khách sạn và trong môi trường quốc tế hoặc có tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (15 môn – 52 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (11 môn – 40 tín chỉ): Cung cấp các kiến thức chung và chuyên sâu về quản trị và vận hành lưu trú, bán hàng và marketing trong kinh doanh khách sạn, quản trị doạnh thu khách sạn, tổ chức sự kiện. Trang bị cho người học các kỹ năng tổ chức, quản lý vận hành các dịch vụ khách sạn và các kỹ năng làm việc trong môi trường đa văn hóa.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức chuyên sâu và nghiệp vụ thực tế về các lĩnh vực: Quản trị lưu trú; Quản trị nhà hàng; và Tổ chức sự kiện.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.');




