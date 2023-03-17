DROP  database IF EXISTS  SWP391;

create database SWP391;

USE SWP391;


CREATE TABLE Account(
	accountID int auto_increment,
	username VARCHAR(255) UNIQUE,
	roleID int DEFAULT 1,
	password VARCHAR(255),
	avatar NVARCHAR(255),
	fullname NVARCHAR(100) NOT NULL,
	email NVARCHAR(120) NOT NULL UNIQUE,
	phone NVARCHAR(20),
	address NVARCHAR(255),
    typeAccount int DEFAULT -1,
    isActive bit DEFAULT 1,
	primary key (accountID)
);


CREATE TABLE Roles(
	roleID int AUTO_INCREMENT primary key,
	rolename NVARCHAR(255) not null
);


CREATE TABLE Decision(
	decisionID int auto_increment not null primary key,
	DecisionNo NVARCHAR(30) not null unique,
    DecisionName NVARCHAR(255),
    ApprovedDate DATE,
    Note TEXT,
    CreateDate DATE,
    isActive bit Default 1,
    FileName NVARCHAR(255)
);


CREATE TABLE Majors(
	majorID int AUTO_INCREMENT primary key,
	keyword NVARCHAR(255) not null,
	majorNameEN NVARCHAR(255) not null,
	majorNameVN NVARCHAR(255) not null,
    isActive bit DEFAULT 1
);


CREATE TABLE Curriculum(
	CurID int AUTO_INCREMENT,
	CurriculumCode NVARCHAR(40),
	majorID int,
	CurriculumNameEN NVARCHAR(255) not null,
	CurriculumNameVN NVARCHAR(255) not null,
    DecisionNo NVARCHAR(30),
	Description TEXT not null,
    isApprove bit default 1,
	primary key (CurID)
);


CREATE TABLE Subjects(
	SubjectID INT AUto_increment primary key,
	SubjectCode NVARCHAR(20) UNIQUE,
	subjectName NVARCHAR(255),
	Semester int,
	NoCredit int,
    isActive bit DEFAULT 1,
    ComboID int,
    createBy int,
    FOREIGN KEY(createBy) REFERENCES Account(accountID)
);



CREATE TABLE Syllabus(
	SyllabusID int auto_increment,
	SubjectID int,
	SubjectNameEN NVARCHAR(255),
	SubjectNameVN NVARCHAR(255),
	IsActive bit DEFAULT 1,
	IsApproved bit DEFAULT 1,
	DecisionNo NVARCHAR(30),
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
    PreRequisite text,
    createBy int,
    FOREIGN KEY(createBy) REFERENCES Account(accountID),
    Primary KEY (syllabusID)
);



CREATE TABLE PreRequisite(
	PreID INT auto_increment PRIMARY KEY,
    SyllabusID INT,
    SubjectID int,
    subjectPre text
);


CREATE TABLE Feedback(
	fbID int auto_increment,
    accountID int NOT NULL,
    syllabusID INT not null,
    title nvarchar(255),
    content text,
    isActive bit DEFAULT 1,
    Primary key(fbID)
);


CREATE TABLE Material(
	MaterialID int AUTO_INCREMENT,
	MaterialDescription TEXT,
	SyllabusID int,
	Author NVARCHAR(255),
	Publisher NVARCHAR(255),
	PublishedDate NVARCHAR(255),
	Edition NVARCHAR(255),
	ISBN NVARCHAR(255),
	IsMainMaterial bit,
	IsHardCopy bit,
	IsOnline bit,
	Note TEXT,
    isActive bit DEFAULT 1,
	primary key(MaterialID)
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
	SyllabusID int,
	category NVARCHAR(255),
	Type NVARCHAR(255),
	Part int,
	Weight nvarchar(100),
	CompletionCriteria varchar(20),
	Duration NVARCHAR(255),
	QuestionType TEXT,
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
	CurID int,
	SubjectID int,
	primary key(CurID, SubjectID)
);


CREATE TABLE PO(
	id int AUTO_INCREMENT primary key,
	POName NVARCHAR(255),
	PODescription TEXT,
    isActive bit DEFAULT 1
);


CREATE TABLE PLO(
	id int AUTO_INCREMENT primary key,
	PLOName NVARCHAR(255),
	PLODescription TEXT,
    isActive bit DEFAULT 1
);


CREATE TABLE Combo(
	ComboID int AUTO_INCREMENT primary key,
	ComboName NVARCHAR(255),
    isActive bit DEFAULT 1,
	note TEXT
);


CREATE TABLE CLO(
	cloID int AUTO_INCREMENT,
    syID int,
    cloName varchar(100),
    cloDetails nvarchar(255),
    loDetails TEXT,
	PRIMARY KEY(cloID)
);



CREATE TABLE ComboSubject(
	ComboID int,
    SubjectID int,
    primary key(ComboID,SubjectID)
);


CREATE TABLE Elective(
	ElectiveID int AUTO_INCREMENT,
	ElectiveNameVN NVARCHAR(255),
    ElectiveNameEN NVARCHAR(255),
    note NVARCHAR(255),
    isActive bit DEFAULT 1,
    PRIMARY KEY(ElectiveID)
);

CREATE TABLE ElectiveSubject(
ElectiveID int,
SubjectID int,
primary key(ElectiveID, SubjectID)
);

CREATE TABLE CurriculumElective(
ElectiveID int,
CurID int,
primary key(ElectiveID, CurID)
);

CREATE TABLE ComboCurriculum(
ComboID int,
CurID int,
primary key(ComboID, CurID)
);

ALTER TABLE CLO add constraint fk_clo_syllabus foreign key(syID) references Syllabus(SyllabusID);

ALTER TABLE PreRequisite add constraint fk_prerequisite foreign key (SubjectID) references Subjects(SubjectID),
						add constraint fk_prerequisite_syllabus foreign key (SyllabusID) references Syllabus(SyllabusID);

ALTER TABLE Feedback 
ADD CONSTRAINT fk_account foreign key(accountID) references account(accountID),
ADD CONSTRAINT fk_syllabus foreign key(syllabusID) references syllabus(SyllabusID);

ALTER TABLE Account add constraint fk_accountRole foreign key (roleID) references Roles(roleID);

ALTER TABLE CurriculumElective
add constraint fk_curriculum_Elective foreign key (CurID) references Curriculum(CurID),
add constraint fk_Elective_curriculum foreign key (ElectiveID) references Elective(ElectiveID);

ALTER TABLE ElectiveSubject add constraint fk_elective_subject foreign key (ElectiveID) references Elective(ElectiveID),
add constraint fk_subject_elective foreign key (SubjectID) references Subjects(SubjectID);

ALTER TABLE ComboCurriculum add constraint fk_combo_curriculum foreign key (ComboID) references Combo(ComboID),
add constraint fk_curriculum_combo foreign key (CurID) references Curriculum(CurID);

ALTER TABLE Curriculum add constraint fk_majorCurriculum foreign key (majorID) references Majors(majorID),
						add constraint fk_decisionCurriculum foreign key (DecisionNo) references Decision(DecisionNo);
                        


ALTER TABLE ConstructiveQuestion add constraint fk_questionsession foreign key (SessionID) references Session(SessionID);

ALTER TABLE Curriculum add constraint fk_decision_curriculum foreign key (DecisionNo) references Decision(DecisionNo);

ALTER TABLE Material add constraint fk_syllabusmaterial foreign key (SyllabusID) references syllabus(SyllabusID);


ALTER TABLE Session add constraint fk_syllabussession foreign key (SyllabusID) references syllabus(SyllabusID);


ALTER TABLE Assessment add constraint fk_syllabusassessment foreign key (SyllabusID) references syllabus(SyllabusID);


ALTER TABLE CurriculumSubject
add constraint fk_Subject_curriculum foreign key (CurID) references Curriculum(CurID),
add constraint fk_curriculum_Subject foreign key (SubjectID) references Subjects(SubjectID);
    
ALTER TABLE Subjects add constraint fk_subjectcombo foreign key (ComboID) references Combo(ComboID);

ALTER TABLE Syllabus add constraint fk_Syllabus_Subject foreign key (SubjectID) references Subjects(SubjectID);



INSERT INTO Roles(rolename) VALUES('GUEST'),('STUDENT'),('TEACHER'),('REVIEWER'),('DESIGNER'),('CRDD'),('HEAD-CRDD'),('ADMIN');


INSERT INTO Account(username, password, fullname, email, roleID) 
VALUES ('admin', '202CB962AC59075B964B07152D234B70', 'Van Tien Tu', 'tuvthe160803@fpt.edu.vn', 8),
		('user', '202CB962AC59075B964B07152D234B70', 'USER 1', '1tuvthe160803@fpt.edu.vn', 1),
        ('student', '202CB962AC59075B964B07152D234B70', 'USER 2', '2tuvthe160803@fpt.edu.vn', 2),
        ('teacher', '202CB962AC59075B964B07152D234B70', 'USER 3', '3tuvthe160803@fpt.edu.vn', 3),
        ('reviewer', '202CB962AC59075B964B07152D234B70', 'USER 4', '4tuvthe160803@fpt.edu.vn', 4),
        ('designer', '202CB962AC59075B964B07152D234B70', 'USER 5', '5tuvthe160803@fpt.edu.vn', 5),
        ('crdd', '202CB962AC59075B964B07152D234B70', 'USER 6', '6tuvthe160803@fpt.edu.vn', 6),
        ('headcrdd', '202CB962AC59075B964B07152D234B70', 'USER 7', '7tuvthe160803@fpt.edu.vn', 7),
        ('user8', '202CB962AC59075B964B07152D234B70', 'USER 8', '8tuvthe160803@fpt.edu.vn', 1),
        ('user9', '202CB962AC59075B964B07152D234B70', 'USER 9', '9tuvthe160803@fpt.edu.vn', 1),
        ('user10', '202CB962AC59075B964B07152D234B70', 'USER 10', '10tuvthe160803@fpt.edu.vn', 1),
        ('user11', '202CB962AC59075B964B07152D234B70', 'USER 11', '11tuvthe160803@fpt.edu.vn', 1),
        ('user12', '202CB962AC59075B964B07152D234B70', 'USER 12', '12tuvthe160803@fpt.edu.vn', 1),
        ('user13', '202CB962AC59075B964B07152D234B70', 'USER 13', '13tuvthe160803@fpt.edu.vn', 1),
        ('user14', '202CB962AC59075B964B07152D234B70', 'USER 14', '14tuvthe160803@fpt.edu.vn', 1),
        ('user15', '202CB962AC59075B964B07152D234B70', 'USER 15', '15tuvthe160803@fpt.edu.vn', 1),
        ('user16', '202CB962AC59075B964B07152D234B70', 'USER 16', '16tuvthe160803@fpt.edu.vn', 1),
        ('user17', '202CB962AC59075B964B07152D234B70', 'USER 17', '17tuvthe160803@fpt.edu.vn', 1);


INSERT INTO `swp391`.`decision`(decisionNo, decisionName, approvedDate, note, createDate, isActive, fileName)
VALUES 	(N'1095/QĐ-ĐHFPT', N'QĐ Về việc bổ sung các học phần Trải nghiệm khởi nghiệp vào Chương trình đào tạo đại học hệ chính quy', '2022-11-28', null, '2022-12-02', 1, ''), 
		(N'1076/QĐ-ĐHFPT', N'Ban hành điều chỉnh CTĐT', '2022-11-24', null, '2022-11-24', 1, ''), 
		(N'973/QĐ-ĐHFPT', N'Ban hành điều chỉnh CTĐT từ kì Spring 2023', '2022-10-26', null, '2022-10-28', 1, ''), 
		(N'669/QĐ-ĐH-FPT', N'Quyết định điều chỉnh CTĐT từ kì Fall 2022', '2022-05-08', null, '2022-08-15', 1, ''),
		(N'336/QĐ-DHFPT', N'Ban hành điều chỉnh CTĐT kì Spring 2022', '2022-04-27', null, '2022-04-27', 1, ''), 
		(N'201/QĐ-ĐHFPT', N'Phê duyệt điều chỉnh chương trình đào tạo đại học hệ chính quy ngành Công nghệ thông tin các khóa sinh viên từ K15A (Chuyên ngành Kỹ thuật phần mềm, Hệ thống thông tin, An toàn thông tin, Internet vạn vật) và các khóa sinh viên từ K15A ...', '2022-03-08', null, '2022-03-17', 1, ''), 
		(N'200/QĐ-ĐHFPT', N'Phê duyệt Điều chỉnh chương trình đào tạo đại học hệ chính quy ngành Quản trị Kinh doanh từ K15 (Chuyên ngành Tài chính, Marketing, Kinh doanh quốc tế, Quản trị khách sạn, Quản trị du lịch và lữ hành)', '2022-03-08', null, '2022-03-17', 1, ''), 
		(N'199/QĐ-ĐHFPT', N'Phê duyệt Điều chỉnh chương trình đào tạo đại học hệ chính quy ngành Quản trị Kinh doanh, chuyên ngành Quản trị truyền thông đa phương tiện từ Khóa 15A', '2022-03-08', null, '2022-03-17', 1, ''), 
		(N'1039/QĐ-ĐHFPT', N'Chương trình TACB-k15', '2019-08-09', N'Ban hành lại, thêm TRS401, level 4 trong TACB 24/10/2019 QĐ_FA19', '2021-11-13', 1, ''), 
		(N'1042/QĐ-ĐHFPT', N'1042/QĐ-ĐHFPT', '2019-08-10', N'Bổ sung theo flm', '2021-11-13', 1, ''), 
		(N'1145/QĐ-ĐHFPT', N'1145/QĐ-ĐHFPT', '2016-12-30', N'Bổ sung theo flm', '2021-11-13', 1, ''), 
		(N'1189/QĐ-ĐHFPT', N'Ban hành đề cương chi tiết học kì Spring 2023', '2022-12-22', null, '2022-12-22', 1, ''),
        (N'1009/QĐ-ĐHFPT', N'QĐ 1009/QĐ-ĐHFPT Ban hành bổ sung, điều chỉnh đề cương chi tiết hệ đại học chính quy triển khai trong Học kỳ Fall 2021', '2021-09-01', N'1 SU21', '2021-11-13', 1, ''), 
		(N'1341/QĐ-ĐHFPT', N'QĐ 1341/QĐ-ĐHFPT Ban hành đề cương chi tiết hệ đại học chính quy triển khai trong học kỳ Spring 2022', '2021-11-22', null, '2021-12-13', 1, ''), 
		(N'1485/QĐ-ĐH-FPT', N'Ban hành bổ sung, điều chỉnh đề cương chi tiết hệ đại học chính quy triển khai trong Học kỳ Spring 2022', '2021-12-31', null, '2021-12-31', 1, ''), 
		(N'889/QĐ-ĐHFPT', N'QĐ 889/QĐ-ĐHFPT Ban hành bổ sung, điều chỉnh một số đề cương chi tiết hệ đại học chính quy triển khai trong học kỳ Fall 2020 theo Quyết định số 823/QĐ-ĐHFPT', '2020-09-03', N'FA2020', '2021-11-13', 1, ''), 
		(N'333/QĐ-ĐHFPT', N'333/QĐ-ĐHFPT', '2017-04-20', N'Bổ sung theo flm', '2021-11-13', 1, ''), 
		(N'05/QĐ-ĐHFPT', N'05/QĐ-ĐHFPT', '2020-01-03', N'Bổ sung theo flm', '2021-11-13', 1, ''), 
		(N'796/QĐ-ĐHFPT', N'QĐ 796/QĐ-ĐHFPT Ban hành đề cương thực tập (OJT) của các ngành đào tạo hệ đại học chính quy và phiếu đánh giá sinh viên kỳ OJT của Đại học FPT triển khai từ Khóa 15 học kỳ Fall 2021', '2021-07-21', N'1 SU21', '2021-11-13', 1, ''), 
		(N'295/QĐ-ĐHFPT', N'295/QĐ-ĐHFPT', '2022-07-04', N'Add by import excel', '2022-04-06', 1, ''),
        (N'670/QĐ-ĐHFPT', N'Ban hành đề cương chi tiết học kì Fall 2022', '2022-08-05', null, '2022-08-05', 1, ''),
        (N'378/QĐ-ĐHFPT', N'QĐ 378/QĐ-ĐHFPT Ban hành đề cương chi tiết hệ đại học chính quy triển khai trong học kỳ Summer 2021', '2021-02-04', N'SP21', '2021-11-13', 1, ''),
        (N'703/QĐ-ĐH-FPT', N'Ban hành điều chỉnh đề cương kì Fall 2022', '2022-08-17', null, '2022-08-19', 1, ''),
        (N'1077/QĐ-ĐHFPT', N'Ban hành đề cương chi tiết học kì Spring 2022', '2022-11-24', null, '2022-11-25', 1, '');

INSERT INTO `swp391`.`combo`
(`ComboName`,
`note`)
VALUES
('Default',''),
('PHE_COM1: Vovinam BBA_MC_K16B',''),
('PHE_COM2: Cờ Vua BBA_MC_K16B',''),
('MC_COM1: Creative Content Production_Sản xuất nội dung truyền thông BBA_MC_K16B',''),
('MC_COM2: Public Relations_Quan hệ công chúng BBA_MC_K16B',''),
('MC_COM3: Digital marketing_Marketing số BBA_MC_K16B','');




INSERT INTO `swp391`.`subjects`
(`SubjectCode`,
`subjectName`,
`Semester`,
`NoCredit`,
`ComboID`,
`createBy`)
VALUES
('OTP101','Orientation and General Training Program_Định hướng và Rèn luyện tập trung','6','0',1, 7),
('EAW211','English Academic Writing 1_Tiếng Anh Viết học thuật 1','1','3',1, 7),
('VDP201','Video Production_Sản xuất Video','4','3',1, 7),
('SSG103','Communication and In-Group Working Skills_Kỹ năng giao tiếp và cộng tác','1','3',1, 8),
('DTG111','Visual Design Tools 1_Công cụ thiết kế trực quan 1','1','3',1, 8),
('MED201','New Media Technology_Các loại hình Truyền thông đương đại','1','3',1, 8),
('MGT103','Introduction to Management_Nhập môn quản lý','1','3',1, 7),
('MKT101','Marketing Principles_Nguyên lý Marketing','1','3',1, 8),
('WDU203c','UI/UX Design_Thiết kế trải nghiệm người dùng','8','3',1, 8),
('SSL101c','Academic Skills for University Success_Kỹ năng học tập đại học','1','3',1, 8),
('ACC101','Principles of Accounting_Nguyên lý kế toán','2','3',1, 8),
('CMC201c','Creative Writing_Sản xuất nội dung sáng tạo','2','3',1, 8),
('DTG121','Visual Design Tools 2_Công cụ thiết kế trực quan 2','2','3',1, 8),
('MMP201','Media Psychology_Tâm lý học truyền thông','2','3',1, 8),
('SSG104','Communication and In-Group Working Skills_Kỹ năng giao tiếp và cộng tác','2','3',1, 8),
('CCO201','Corporate Communication_Truyền thông doanh nghiệp','3','3',1, 8),
('MKT208c','Social media marketing_Marketing mạng xã hội','3','3',1, 8),
('MKT304','Integrated Marketing Communications_Truyền thông marketing tích hợp','3','3',1, 8),
('VOV114','Vovinam 1','0','3',2, 8),
('VOV124','Vovinam 2','1','3',2, 8),
('VOV134','Vovinam 3','2','3',2, 8),
('COV111','Cờ Vua 1','0','3',3, 8),
('COV121','Cờ Vua 2','1','3',3, 8),
('COV131','Cờ Vua 3','2','3',3, 8),
('ĐTR102','Traditional musical instrument_Nhạc cụ truyền thống-Đàn Tranh','0','3',4, 8),
('ĐTB102','Traditional musical instrument_Nhạc cụ truyền thống-Đàn Tỳ bà','0','3',4, 8),
('ĐNH102','Traditional musical instrument_Nhạc cụ truyền thống-Đàn Nhị','0','3',4, 8),
('ĐNG102','Traditional musical instrument_Nhạc cụ truyền thống-Đàn Nguyệt','0','3',4, 8),
('ĐBA102','Traditional musical instrument_Nhạc cụ truyền thống-Đàn Bầu','0','3',4, 8),
('ĐSA102','Traditional musical instrument_Nhạc cụ truyền thống-Sáo trúc','0','3',4, 8),
('TRG102','Traditional musical instrument_Nhạc cụ truyền thống-Trống dân tộc','0','3',4, 8);

INSERT INTO `swp391`.`syllabus`
(`SubjectID`,
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
`ApprovedDate`,
`createBy`)
VALUES
(1,'Orientaiton and General Training Program','Định hướng và Rèn luyện tập trung',1,1,'670/QĐ-ĐHFPT',0,'	Bachelor',':5 weeks (fulltime) = 280h<br/>
* Module 1: Orientation-Định hướng<br/>
(1 week: 8h/day * 5 days = 40h)<br/>
* Module 2: Military Training-Giáo dục quốc phòng<br/>
(110 slots * 1.5h/slot = 165h)<br/>
* Module 3: Experience Program<br/>
22 slots * 1.5h = 33 h<br/>
* Module 4: Vovinam<br/>
28 slots * 1,5h/slot = 42h','Orientation and general training program includes 4 modules :<br/>
* Module 1: Orientation<br/>
Main activities of this module are:<br/>
- Organizing the opening ceremony for students.<br/>
- Organizing health check amd making students''cards.<br/>
- Arranging classes for students and organizing class meeting.<br/>
- Introducing to students about FPT corporation, FPT university, functional departments, training regulations and how to use information systems to support students'' learning.<br/>
- Sharing study skills for university students.<br/>
- Sharing about topics related to community activities. ( For example: activities towards sustainable development, volunteering activities...)<br/>
* Module 2: Military training the program prescribed by the Ministry of Education and Training.<br/>
Implementing the program prescribed by the Ministry of Education and Training.<br/>
* Module 3: Experience program<br/>
Main activities of this module are:<br/>
- Organizing research and review memoirs.<br/>
- Organizing seminars<br/>
- Organizing experiential activities for students (Towards sustainable development and volunteering for the community)<br/>
* Module 4: Vovinam<br/>
Follow the outline VOV114.<br/>
Objectives of orientation and training program are:<br/>
1) Instruct students to complete procedures before a new semester.<br/>
2) Provide students with knowledge about FPT corporation, FPT university and functional departments which support students during the period of study at the university.<br/>
3) Introduce to students about Curriculum, FU training model and regulations as well as how to use information systems to enable students to adapt new learning environment.<br/>
4) Educate students the fundamentals of military and national security, build and enrich patriotism, national pride through history lessons, seminars, documentaries, field trips to military bases and memoirs about two prolonged resistance wars of Viet Nam.<br/>
5) Train the willpower and improve physical strengths, fitness and sense of responsibilities through physical education lessons and combat practice in the field.<br/>
6) Train team spirit, disciplines, shape good attitude and behaviors towards friends, teachers and educational environment.<br/>
7) Enhance student experiences with extra-curricular activities. Strengthen the sense of community through community and volunteering activities and the ones towards the sustainable development.',
'Attend enough activities of the university.','',10,'Min to pass: Students must pass the examination and achieve the Military training certificate',0,'2022-12-22', 7),
(4,'Communication and In-group working skills','',1,1,'378/QĐ-ĐHFPT',3,'','30 sessions, 1 session = 90 minutes','This course will cover both working in groups and communication skills.
Assessment structure:<br/>
* On-going Assessment:<br/>
- Activity: 10%<br/>
- Quiz: 15%<br/>
- Group Assignment : 15%<br/>
- Group Project : 30%<br/>
* Final Exam: 30%<br/>
* Completion Criteria: Every on-going assessment component > 0, Final Exam >=4, Final Result >=5','- Attend more than 80% of contact hours in order to be accepted to the final examination<br/>
- Actively participate in class activities<br/>
- Fulfill tasks given by instructor after class<br/>
- Use their own laptop in class only for learning purpose<br/>
- Read the textbook in advance<br/>
- Access the course website (www.cms.fpt.edu.vn) for up-to-date information and material of the course, for online supports from teachers and other students and for practicing and assessment.','- Internet
- PDF reader',10,'',5,'2021-2-4', 7),
(2,'English Academic Writing 1','Viết học thuật tiếng Anh 1',1,1,'1189/QĐ-ĐHFPT',3,'Advanced','Study hour (150h) = 45 contact hours (60 sessions) + 1 hour final exam + 104 hours self-study','Advance in Academic Writing helps students write assignments in academic English. Advance integrates active and critical reading, critical thinking, academic vocabulary building, academic writing style, and effective sentence structure and grammar around authentic academic texts. As students respond to these texts, they are taken through the research and writing processes they will need to master to succeed in their respective fields of study.','- Attend more than 80% of contact hours in order to be accepted to the final examination<br/>
- Actively participate in class activities<br/>
- Fulfil tasks given by instructor after class<br/>
- Use their own laptop in class only for learning purpose<br/>
- Access the course website (http://cms.fpt.edu.vn) for up-to-date information and material of the course, for online supports from teachers and other students and for practicing and assessment.','Tools: Foxit pdf editor
Internet access',10,'1) On-going assessment<br/>
- Assignments 04*15% 60%<br/>
2) Final Examination (FE) 40%<br/>
3) Final Result 100%<br/>
4) Completion Criteria:<br/>
On-going assessment >0, Final Exam Score >=4/10 & Final Result >=5/10',5,'2022-12-22', 7),
(3,'Video Production','Sản xuất video',1,1,'295/QĐ-ĐHFPT',3,'Bachelor in Business Administration','Study hour (150h)
= 45h contact hours + 105h self-study','This practicum course is designed to give students the opportunity to apply theoretical knowledge learned before to actual multimedia production situations. This course incorporates in its approach a combination of applied media aesthetics theory and hands-on production experience in Video production. Students will gain a foundation for understanding media production theory, facilitating video production processes as well as creating and evaluating media products relating to a particular issue set by the course lecturer. A component of the course will permit the introduction of current topics such as media issues, professional video production techniques, changing media technology, and job market information.','-Attend more than 80% of contact hours in order to be accepted to the final examination','',10,'',5,'2022-12-22', 8),
(5,'Visual Design Tools 2D','Công cụ thiết kế trực quan 1',1,1,'703/QĐ-ĐH-FPT',3,'Bachelor','Study hour (150h)
= 45h contact hours + 105h self-study','The course empowerC14ommon Adobe 2D tools for Multimedia designers, which are Illustrator, Photoshop, InDesign and Xd, so that they can finalize their 2D designs better and able to deliver completed professional product to customers
Through practical assignments, students have chances to apply knowledge on colors, typography etc. in other courses along with computers and other tools to creaate graphic applications.','- Read textbook and install software before coming to class<br/>
- Complete assignments in class, submit online thoughout LMS or Classroom platform.<br/>
- Frequently visit fap, LMS or Google classroom for update instrucions and requirements.<br/>
- Actively participate into class, review and comments to classmate works, ask instructor questions, bring into class everyday samples for references.<br/>
- Complete homework and other requirements by instructors<br/>
- Using laptop in class only for taking note, research and doing assignment purposes<br/>
- No talking, surfing, chatting, gaming, facebooking, using phone etc. while the teacher giving instruction.<br/>
- Present at least 80% class attendance in order to pass the course.','1. The school prepare: (Installed)<br/>
- Classroom with chairs, desks, large monitor with HDMI connection for demo/presentation<br/>

2. Student prepare:<br/>
- Note/Sketchbooks, pens and pencils<br/>
- Laptop for graphic design with Adobe Photoshop, Illustrator, Indesign and Xd installed',10,'',5,'2022-8-17', 8),
(6,'New Media Technology','Các loại hình Truyền thông đương đại',1,1,'1189/QĐ-ĐHFPT',3,'Bachelor','	Study hour (150h)
= 45h contact hours + 1h final exam + 104h self-study','Description: This course will give you a thorough explanation of how media technologies develop, operate, converge, and affect society in order to think critically about the media and its effects on culture. It provides a comprehensive introduction to today''s global media environment and the ongoing developments in technology, culture, and critical theory that continue to transform this rapidly evolving industry and affect your everyday life. Our emphasis is on the social relations of power and connectivity that are shaped by new media as practices of communication. Specific topics that will be explored include: the latest developments and trends in social media, e-publishing, policy changes for Internet governance, online privacy protection, online ad exchanges, the changing video game industry, and much more. By studying this course, students will develop knowledge and skills in creative thinking, communication, collaboration, planning, critical analysis, and digital and ethical citizenship.<br/>
Teaching methods: Direct Instruction, Inquiry-based Learning, Cooperative Learning, Case Study Analysis','- Students must attend more than 80% of contact slots in order to be accepted to the final examination.<br/>
- Student is responsible to do all exercises, assignments and labs given by instructor in class or at home and submit on time<br/>
- Use laptop in class only for learning purpose','- Textbook<br/>
- Computer',10,'',5,'2022-12-22', 8),
(7,'Introduction to Management','Nhập môn quản lý',1,1,'1189/QĐ-ĐHFPT',3,'Bachelor','Study hour (150h) = 45h (60 sessions) contact hours + 1h final exam + 104h self-study','The course explores and focuses around the managerial functions of management, including planning, organizing, leading and controlling. The course is designed to provide basic knowledge and skills required in management and give students a comprehensive insight into human relations componnents that characterise any managerial roles, regardless of industry or functions. Various aspects of management theories will be examined and linked to current management practice in the world and Vietnam. Learning in the class will be facilitated through the use of interactive tools such as group exercise, case study discussion, role-play/activities, and projects.','- Attend more than 80% of contact hours in order to be accepted to the final examination<br/>
- Actively participate in class activities- Fulfill tasks given by instructor after class<br/>
- Use their own laptop in class only for learning purpose<br/>
- Read the textbook in advance','',10,'',5,'2022-12-22', 8),
(8,'Marketing Principles','Nguyên lý Marketing',1,1,'1189/QĐ-ĐHFPT',3,'Bachelor in Business Administration','Study hour (150h) = 45h (60 sessions) contact hours + 1h final exam + 104h self-study','	The course is designed to provide students with a strong foundation in marketing based on five key activities: (1) identifying customer needs, (2) providing customers with the right products or service to meet their needs, (3) assuring availability to customers through the right distribution channels, (4) using promotional activities in ways that motivate purchase as effectively as possible, (5) setting an appropriate price that maximizes firm profitability while maintaining customer satisfaction.','- Attend more than 80% of contact hours in order to be accepted to the final examination<br/>
- Actively participate in class activities<br/>
- Fulfill tasks given by instructor after class<br/>
- Use their own laptop in class only for learning purpose<br/>
- Read the textbook in advance<br/>
- Access the course website (www.flm.fpt.edu.vn) for up-to-date information and material of the course, for online supports from teachers and other students and for practicing and assessment.','',10,'',5,'2022-12-22', 7),
(9,'UI/UX Design','Thiết kế trải nghiệm người dùng',1,1,'1341/QĐ-ĐHFPT',3,'Bachelor','Online: 84 hours+6 slot offline','	Integrate UX Research and UX Design to create great products through understanding user needs, rapidly generating prototypes, and evaluating design concepts. Students will gain hands-on experience with taking a product from initial concept, through user research, ideation and refinement, formal analysis, prototyping, and user testing, applying perspectives and methods to ensure a great user experience at every step. This course concludes with a capstone project, in which learners will incorporate UX Research and Design principles to design a complete product, taking it from an initial concept to an interactive prototype.','1. Complete the online courses and get all specialization certifications to be allowed to take Final Exam<br/>
2. Final Exam included Final Theory Exam (TE): 100%<br/>
3. Student gets 0.165 bonus points for each course completed on time.<br/>
4. Completion Criteria: Final TE Score >=4 & (Final TE Score + bonus) >= 5','- Internet',10,'',5,'2021-11-22', 8),
(10,'Academic Skills for University Success','Kỹ năng học tập ở Đại học',1,1,'1077/QĐ-ĐHFPT',3,'Bachelor','42 hours online + 9hrs offline (6 slots) + 1hr exam','Upon finishing the course, students can:<br/>
1) Knowledge: Understand<br/>
- Method to develop your Information & Digital Literacy Skills<br/>
- Method to develop your Problem Solving and Creativity Skills<br/>
- How to develop your Critical Thinking Skills<br/>
- How to develop your Communication Skills<br/>
2) Able to (ABET)<br/>
- Access, search, filter, manage and organize Information by using a variety of digital tools, from wide variety of source for use in academic study.<br/>
- Critically evaluate the reliability of sources and use digital tools for referencing in order to avoid plagiarism.<br/>
- Demonstrate awareness of ethical issues related to academic integrity surrounding the access and use of information<br/>
- Develop a toolkit to be able to identify real problems and goals within ill-defined problem & Recognize and apply analytical & creative problem solving technique<br/>
- Use a variety of thinking tools to improve critical thinking<br/>
- Identify types of argument, and bias within arguments<br/>
- Demonstrate, negotiate, and further understanding through spoken, written, visual, and conversational modes<br/>
- Effectively formulate arguments and communicate research findings through the process of researching, composing, and editing<br/>
3) Others: (ABET)<br/>
- Improve study skills (academic reading, information searching, ...)','1. Join the online course (spec.) when being invited by the admin.<br/>
2. Enroll in each MOOC of spec., regularly study MOOCs at least 5hrs/week by watching videos, reading materials, taking quizzes, doing assignments... as required<br/>
3. Respect the Coursera Code of Conduct, at https://learner.coursera.help/hc/en-us/articles/208280036-Coursera-Code-of-Conduct<br/>
3. Keep online learning progress promptly (bonus will be awarded)<br/>
4. Communicate and discuss in forum<br/>
5. Attend off-line sessions in the Campus (Optional)<br/>
6. Must complete all MOOCs of spec. with certification in order to take the Final Exam at Campus','Online Spec. https://www.coursera.org/specializations/academic-skills; University of Sydney, including:<br/>
- MOOC1: Introduction to Information & Digital Literacy for University Success , https://www.coursera.org/learn/digital-literacy/home/welcome<br/>
- MOOC2: Introduction to Problem-Solving Skill for University Success, https://www.coursera.org/learn/problem-solving-skills/home/welcome<br/>
- MOOC3: Critical Thinking Skills for University Success, https://www.coursera.org/learn/critical-thinking-skills/home/welcome<br/>
- MOOC4: Communication Skills for University Success, https://www.coursera.org/learn/communication-skills/home/welcome<br/>
- MOOC5: Academic Skills for University Success: Capstone, https://www.coursera.org/learn/academic-skills-project/home/welcome',10,'1) Ongoing assessment:<br/>
Student gets 0.2 bonus points for each course completed on time. The total bonus point is not greater than 1.<br/>
2) Theoretical Exam (TE)<br/>
3) Final Result (FR) =min (10, TE + Bonus)<br/>
4) Completion Criteria: TE>=4 and FR>=5',5,'2022-11-24', 8),
(11,'Principles of Accounting','Nguyên lý kế toán',1,1,'703/QĐ-ĐH-FPT',3,'Bachelor in Business Administration','Study hour (150h) = 45h (60 sessions) contact hours + 1h final exam + 104h self-study','Main objectives:
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
<br>- Access the course website (http://flm.fpt.edu.vn) for up-to-date information and material of the course, for online supports from teachers and other students and for practicing and assessment.','',10,'',5,'2022-8-17', 8),
(12,'Creative Writing','Sản xuất nội dung sáng tạo',1,1,'889/QĐ-ĐHFPT',3,'Bachelor','55 hours online + 9 hrs offline + 1hr exam','Upon finishing the course, students can:
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
4) Completion Criteria: TE>=4 and FR>=5',5,'2020-3-9', 7),
(13,'Visual Design Tools 2','Công cụ thiết kế trực quan 2',1,1,'703/QĐ-ĐH-FPT',3,'Bachelor','Study hour (150h)
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
<br>- Laptop for graphic design with Adobe Creative apps installed',10,'',5,'2022-8-17', 8),
(14,'MEDIA PSYCHOLOGY','Tâm lý học truyền thông',1,1,'1189/QĐ-ĐHFPT',3,'Bachelor','Study hour (150h)
= 45h contact hours + 1h final exam + 104h self-study','-Objective: Understand and can be applied the cognitive psychology theories of mass comunication.
<br>-Description: This course will focus on a range of psychological theories, processes, and principles in the context of mass communication. Students will explore the application of these theories and principles to several prominent issues will be discussed. Such issues may include politics, sex, and violence, to lesser-studied topics, such as sports, music, emotion, and technology of various media. In addition, this course examines how our experiences with media affect the way we acquire knowledge about the world, and how this knowledge influences our attitudes and behavior.
<br>-Teaching method: Presentation, Disscussion, teamwork, critical thinking.','- Students must attend more than 80% of contact slots in order to be accepted to the final examination.
<br>- Student is responsible to do all exercises, assignments and labs given by instructor in class or at home and submit on time
<br>- Use laptop in class only for learning purpose
<br>- Promptly access to the FU CMS at http://cms.fpt.edu.vn for up-to-date course information','',10,'',5,'2022-12-22', 8),
(15,'Communication and In-Group Working Skills','Kỹ năng giao tiếp và cộng tác',1,1,'1189/QĐ-ĐHFPT',3,'Bachelor','Study hour (150h) = 45 contact hours (60 sessions) + 0.5 hour final exam + 104.5 hours self-study','This course covers both working in groups and communication skills. The course covers theories of communication, working in group, and activities for students to practice applying the theories in academic and working contexts.','- Students must attend more than 80% of contact slots in order to be accepted to the final examination.
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
<br>Grade Average >= 5/10',5,'2022-12-22', 8),
(16,'Corporate Communication','Truyền thông doanh nghiệp',1,1,'1189/QĐ-ĐHFPT',3,'Bachelor level','Study hour (150h)
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
- Read the textbook in advance','',10,'',5,'2022-12-22', 8),
(17,'Social Media Marketing','Marketing mạng xã hội',1,1,'378/QĐ-ĐHFPT',3,'Bachelor','Online: 52 hours+ 6 slots offline (optional)','The Social Media Marketing Specialization is designed to achieve two objectives. It gives students the social analytics tools, and training to help them become an influencer on social media. The course also gives the knowledge and resources to build a complete social media marketing strategy – from consumer insights to final justification metrics.
Note: Student gets 0.165 bonus points for each course completed on time.','Access the specialization on Coursera and complete all courses'' requirements to earn a certificate of completion for the specialization, in order to be qualified for the Final Exam.','Internet access',10,'',5,'2021-4-2', 8),
(18,'Intergrated Marketing Communications','Truyền thông Marketing tích hợp',1,1,'703/QĐ-ĐH-FPT',3,'Bachelor in Business Administration','Study hour (150h) = 45h (60 sessions) contact hours + 1h final exam + 104h self-study','The course aims to provide students a solid foundation on different aspects of advertising and other major integrated marketing communications tools, and the role of these tools in the marketing process. In particular, attention will be given to discussions on (1) understanding the communication processes of consumers and marketers, (2) conducting situation analyses of business and social environments, (3) devising effective creative strategies for achieving marketing objectives, and (4) implementing and evaluating the creative strategy.','- Attend more than 80% of contact hours in order to be accepted to the final examination
- Actively participate in class activities
- Fulfil tasks given by intructor after class
- Use their own laptop in class only for learning purpose
- Read the textbook in advance
- Access the course website (www.flm.fpt.edu.vn) for up-to-date information and material of the course, for online supports from teachers and other students and for practicing and assessment.','',10,'',5,'2022-8-17', 8);


INSERT INTO `swp391`.`clo`
(`syID`,
`cloName`,
`cloDetails`,
`loDetails`)
VALUES
(1, '1', 'CLO1', 'Know general information about FPT university and the roles of functional department supporting students during the studying period.' ),
(1, '2', 'CLO2', 'Define training models and regulations of FPT university, know the curriculum that the students will study and information systems to support students\' learning. Understand study skills for university students.' ),
(1, '3', 'CLO3', 'Indicate the fundermentals of military and national security and practice the basic skills in military training and Vovinam. Enhance fitness, sense of patriotism and national pride as well as the awareness of constructing and protecting the nation.' ),
(1, '4', 'CLO4', 'Develop soft skills such as team spirit, disciplines and positive attitude in different environment.' ),
(1, '5', 'CLO5', 'Experience plentiful activities in order to develop personalities, life skills and sense of community.' ),


(2, '1', 'CLO1', 'Establish relationships between class members and group organization' ),
(2, '2', 'CLO10', 'Understand leadership theories and model of leadership effectiveness.' ),
(2, '3', 'CLO11', 'Describe and identify importance of verbal and nonverbal in teamwork and how to use them effectiveness' ),
(2, '4', 'CLO12', 'Understand how conflicts appear in groups and how to manage them in cohesion.' ),
(2, '5', 'CLO13', 'Develop a professtional meeting and practice dealing the behavior problems of members in the meeting time.' ),
(2, '6', 'CLO14', 'Apply of parliamentary principles and summary the basic procedures when organizing the meeting.' ),
(2, '7', 'CLO15', 'Identify words and develop clear, concise,logical, coherent,and effective paragraphs.' ),
(2, '8', 'CLO16', 'Format business letters using the full block,modified block,and simplified styles.' ),
(2, '9', 'CLO17', 'Format memos and e-mail properly.' ),
(2, '10', 'CLO18', 'Prepare competently a variety of positive and neutral messages using the direct plan.' ),
(2, '11', 'CLO19', 'Prepare effective negative messages for a variety of purposes using the indirect plan' ),
(2, '12', 'CLO2', 'Form a group and conduct group work' ),
(2, '13', 'CLO20', 'Write messages that are used for the various stages of collection' ),
(2, '14', 'CLO21', 'Write formal and informal reports' ),
(2, '15', 'CLO22', 'Prepare targeted and general résumés in chronological, functional,or combination format.' ),
(2, '16', 'CLO23', 'Prepare for a successful job interview' ),
(2, '17', 'CLO24', 'Review the knowledge learned and practice overview' ),
(2, '18', 'CLO3', 'Define common teamwork skills such as group communication, membership, leadership, planning and conducting meeting, verbal and nonverbal communication, conflict and cohesion,' ),
(2, '19', 'CLO4', 'Identify key elements, advantages, disavantages and the nature of group communication.' ),
(2, '20', 'CLO5', 'Describe stages of group development and types of group norms.' ),
(2, '21', 'CLO6', 'Explain why member join, stay or leave groups through theory of needs.' ),
(2, '22', 'CLO7', 'Determine group roles and how each role helps hinders groups from achieving a common goal.' ),
(2, '23', 'CLO8', 'Describe and apply strategies for reducing communication apprehensions.' ),
(2, '24', 'CLO9', 'Analyse ways to become effective and powerful leaders.' ),


(3, '1', 'CLO1', '*Identify 6 stages of the writing process ; * apply four strategies for learning vocabulary; *identify nouns and noun phrases; *learn about parallel structure; * write an exploratory paragraph following 6 stages of the writing process' ),
(3, '2', 'CLO2', '* Explain past, present, and future tenses; use four strategies for learning vocabulary; identify features of informal style; *write about critical thinking; * learn about assessing the reliability of sources; *write personal narratives about your past, present, and future tenses' ),
(3, '3', 'CLO3', '*Distinguish opinion from fact; *support argument with reasons, examples, and evidence; *apply language of opinion, argument, and concession in the writing; *present a closing position; *corporate APA, MLA in-text citation; *write an argumentative paragraph using personal language' ),
(3, '4', 'CLO4', '*Write topic sentences and keep paragraphs unified; identify logical fallacies;* write compound and complex sentences; use Latinate verbs in academic writing* rewrite a paragraph to avoid logical fallacies' ),
(3, '5', 'CLO5', '	*Distinguish three more key features of paragraphs: coherence, cohesion, and concluding sentences; *apply conjunctive adverbs and reference words in the writing; * write relative clauses and participle phrases; identify logical fallacies based on generalization; *write 2 paragraphs: one presenting the positive sides of a given topic, one presenting the negative aspects' ),
(3, '6', 'LO6', '	*Recognize plagiarism and quote directly; *integrate their awareness of plagiarism into writing practice; *apply language of attribution, reporting verbs, and passive voice; *corporate citation in the writing; * write two paragraphs with at least 2 citations from a reliable academic source, incorporate the author\'s ideas by paraphrasing one and directly quoting the other' ),


(4, '1', 'CLO1', 'Demonstrate an understanding of the theories and practices involved in video production.'),
(4, '2', 'CLO10', 'Master the methods to use a variety of lighting instruments, lighting support, grip, and equipment to demonstrate skills in lighting' ),
(4, '3', 'CLO11', 'Interpret the importance and impact of background on video quality and learn how to leverage video background' ),
(4, '4', 'CLO12', 'Demonstrate an understanding of the communicative capacity of video graphics to learn how to showcase an effective transference of ideas' ),
(4, '5', 'CLO13', 'Interpret the design and format of video and audio recording systems to control image quality' ),
(4, '6', 'CLO14', 'Master the mechanics of editing and the subtle effects of the editor’s choices to form a convincing, persuasive presentation' ),
(4, '7', 'CLO2', 'Define basic video production terms to understand the process of video production' ),
(4, '8', 'CLO3', 'Differentiate crew’s roles of the Film Production Team' ),
(4, '9', 'CLO4', 'Understand how people can organize the process of video production' ),
(4, '10', 'CLO5', 'Gain insight into necessary production techniques and their functions' ),
(4, '11', 'CLO6', 'Interpret the importance of script in production and the process of making script' ),
(4, '12', 'CLO7', 'Master camera main features and the methods of using camera to shoot videos' ),
(4, '13', 'CLO8', 'Master the methods to choose and motivate the actors' ),
(4, '14', 'CLO9', 'Demonstrate the ability to accomplish production tasks incorporating a practical understanding of audio production' ),


(5, '1', 'CLO1', '2D graphic, vector-based appliction, bitmap-based application and layout application.'),
(5, '2', 'CLO2', 'Using application tools to create graphic design works, logo, characters, editing images, layout.'),
(5, '3', 'CLO3', 'With assignments as case study, students know how to create typography, color study, and value study works'),
(5, '4', 'CLO4', 'Operate and master vector skills to draw, edit, colorize, making shapes and form.'),
(5, '5', 'CLO5', 'Operate and master bitmap skills to edit photo, collaging, cut and clone, manipulation.'),
(5, '6', 'CLO6', 'Design simple 2D graphic works such as logo, flyer, icon set, poster, small magazine.'),
(5, '7', 'CLO7', 'Create a web design using combined text, vector illustration and bitmap works.');






INSERT INTO `swp391`.`material`
(`SyllabusID`,
`MaterialDescription`,
`Author`,
`Publisher`,
`PublishedDate`,
`Edition`,
`ISBN`,
`IsMainMaterial`,
`IsHardCopy`,
`IsOnline`,
`Note`,
`isActive`)
VALUES
(1, 'Introductory documents aout FPT Group and FPT University', null, null, null, null, null, 0, 0, 0, null, 1),
(1, '"Hồi ký: Từ nhân dân mà ra"', null, null, null, null, null, 0, 0, 0, null, 1),
(1, '"Hồi ký: Những điều đọng lại qua hai cuộc chiến tranh"', null, null, null, null, null, 0, 0, 0, null, 1),
(1, '"Hồi ký: Tổng hành dinh"', null, null, null, null, null, 0, 0, 0, null, 1),

(2, 'Working in Groups', 'Isa N.Engleberg and Dianna R.Wynn', 'Pearson/Allyn & Bacon', null, null, null, 1, 1, 0, null, 1),
(2, 'Business Communication', 'Krizan, et al.', 'Thomson South-Western', null, null, null, 1, 1, 0, null, 1),

(3, 'Main book and its resource:<br>
Advance in Academic Writing 1- English for Academic Purposes<br>
Package, including:<br>
For Student:<br>
1) ST: Student’s Book (hardcopy or EText and My ELAB)<br>
2) http://cms.fpt.edu.vn<br>
For Teacher:<br>
3) Student’s Book (hardcopy or ETEXT and My ELAB)<br>
4) My ELAB Documents', null, 'Pearson', 2019, null, 9780134663326, 1, 1, 0, null, 1),
(3, 'Longman Academic Writing Series 4 - Pearson', null, 'Pearson', null, '(fifth Edition)', null, 1, 1, 0, null, 1),

(4, 'Video Production Handbook', 'Gerald Millerson and Jim Owens', 'Focal Press', 2008, null, 'ASIN:B00DT6B8PI', 1, 0, 1, 'Link: https://library.books24x7.com', 1),
(4, 'https://www.lynda.com/learning-paths/Video/become-a-video-editor', null, null, null, null, null, 0, 0, 1, null, 1),
(4, 'https://www.lynda.com/learning-paths/Video/improve-your-video-lighting-skills', null, null, null, null, null, 0, 0, 1, null, 1),
(4, 'https://www.lynda.com/learning-paths/Video/become-a-film-producer', null, null, null, null, null, 0, 0, 1, null, 1),

(5, 'Adobe Design Basics', 'Thomas Payne', 'Adobe Education Exchange', 2020, null, '9781714208852', 1, 0, 1, 'Nguồn sách Creative Commons licensing', 1),
(5, 'Adobe Photoshops CC<br/>
https://helpx.adobe.com/pdf/photoshop_reference.pdf', null, 'Adobe', 2019, '20th', null, 0, 0, 1, null, 1),
(5, 'Adobe Design Basics', 'Thomas Payne', 'Adobe Education Exchange', 2019, '20th', null, 0, 0, 1, null, 1),
(5, 'Adobe Design Basics', 'Thomas Payne', 'Adobe Education Exchange', 2019, '20th', null, 0, 0, 1, null, 1),

(6, 'Media Now: Understanding Media, Culture, and Technology', 'Joseph Straubhaar, Robert LaRose, Lucinda Davenport', 'Cengage', 2017, '10th', '978-1305950849', 1, 1, 0, null, 1),
(6, 'https://www.brandsvietnam.com/', null, null, null, null, null, 0, 0, 1, null, 1),
(6, 'https://www.makeitnoise.com/', null, null, null, null, null, 0, 0, 1, null, 1),
(6, 'https://blog.marketo.com/', null, null, null, null, null, 0, 0, 1, null, 1),
(6, 'https://blog.hubspot.com/', null, null, null, null, null, 0, 0, 1, null, 1),

(7, 'Fundamentals of Management', 'Ricky W.Griffin', 'Cengage', 2019, '9th', '978-1305970229', 1, 1, 0, null, 1),
(7, 'Essentials of Management', 'Adrew.J. DuBrin', 'Cengage', 2011, '9th', null, 0, 1, 0, null, 1),
(7, 'AE Fundamentals of Management', 'Ricky Griffin', 'Cengage', 2021, '10th', 'ISBN-13: 9789814986236 | ISBN-10: 9814986232', 1, 1, 0, 'Chọn một trong 2 ấn bản. Ưu tiên mua ấn bản mới nhất', 1),

(8, 'Principles of Marketing', 'Kotler, Philip and Armstrong, Gary', 'Pearson', 2020, '18th Edition', null, 1, 1, 0, 'Chọn một trong 2 quyển. Ưu tiên mua ấn bản mới nhất', 1),
(8, 'Principles of Marketing: A global perspective', 'Kotler, Philip and Armstrong, Gary', 'Pearson', 2009, null, null, 1, 1, 0, null, 1),
(8, 'Principles of Marketing', 'Philip Kotler and Gary Armstrong', 'Prentice Hall', 2012, '14th ed', null, 1, 1, 0, null, 1),

(9, 'https://learner.coursera.help/hc/en-us/articles/208280036-Coursera-Code-of-Conduct', null, 'Coursera', null, null, null, 0, 0, 1, null, 1),
(9, 'https://www.coursera.org/learn/introtoux-principles-and-processes', null, null, null, null, null, 1, 0, 1, 'MOOC 1: Introduction to User Experience Principles and Processes', 1),
(9, 'https://www.coursera.org/learn/understanding-user-needs', null, null, null, null, null, 1, 0, 1, '	MOOC 2: Understanding User Needs', 1),
(9, 'https://www.coursera.org/learn/evaluating-designs-with-users', null, null, null, null, null, 1, 0, 1, 'MOOC 3: Evaluating Designs with Users', 1),
(9, 'https://www.coursera.org/learn/ux-design-concept-wireframe', null, null, null, null, null, 1, 0, 1, 'MOOC 4: UX Design: From Concept to Prototype', 1),
(9, 'https://www.coursera.org/learn/ux-research-at-scale', null, null, null, null, null, 1, 0, 1, 'MOOC 5: UX Research at Scale: Surveys, Analytics, Online Testing', 1),
(9, 'https://www.coursera.org/learn/user-experience-capstone', null, null, null, null, null, 1, 0, 1, 'MOOC 6: UX (User Experience) Capstone', 1),
(9, 'https://www.coursera.org/specializations/michiganux', null, null, null, null, null, 1, 0, 1, 'SPEC: User Experience Research and Design', 1),

(10, 'https://www.coursera.org/specializations/academic-skills', null, 'Coursera', null, null, null, 1, 0, 1, 'SPEC: Academic Skills for University Success Specialization', 1),
(10, 'https://www.coursera.org/learn/digital-literacy', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 01: Introduction to Information & Digital Literacy for University Success', 1),
(10, 'https://www.coursera.org/learn/problem-solving-skills', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 02: Introduction to Problem-Solving Skill for University Success', 1),
(10, 'https://www.coursera.org/learn/critical-thinking-skills', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 03: Critical Thinking Skills for University Success', 1),
(10, 'https://www.coursera.org/learn/communication-skills', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 04: Communication Skills for University Success', 1),
(10, 'https://www.coursera.org/learn/academic-skills-project', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 05: Academic Skills for University Success: Capstone', 1),

(11, 'Fundamental accounting principles', 'Wild, Larson, Chiappetta', 'Mc Graw-Hill', 2013, null, null, 1, 1, 0, null, 1),
(11, 'Principles of Accounting', 'Wild, Larson, Chiappetta', 'Mc Graw-Hill', 2009, null, null, 1, 1, 0, null, 1),
(11, 'Fundamental accounting principles', 'John J. Wild, Winston Kwok, Sundar Venkatesh', 'Mc Graw-Hill', null, '3rd', '9789814923378', 1, 1, 0, 'Chọn một trong ba sách. Ưu tiên ấn bản mới nhất.', 1),

(12, 'https://www.coursera.org/specializations/creative-writing', null, 'Coursera', null, null, null, 1, 0, 1, 'SPEC: Creative Writing Specialization', 1),
(12, 'https://www.coursera.org/learn/craft-of-plot', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 01: Creative Writing: The Craft of Plot', 1),
(12, 'https://www.coursera.org/learn/craft-of-character', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 02: Creative Writing: The Craft of Character', 1),
(12, 'https://www.coursera.org/learn/craft-of-setting-and-description', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 03: Creative Writing: The Craft of Setting and Description', 1),
(12, 'https://www.coursera.org/learn/craft-of-style', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 04: Creative Writing: The Craft of Style', 1),
(12, 'https://www.coursera.org/learn/story-writing-project', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 05: Capstone: Your Story', 1),

(13, 'Adobe Design Basics', 'Thomas Payne', 'Adobe Education Exchange', 2020, '2020', '9781714208852', 1, 0, 1, 'Nguồn sách Creative Commons licensing', 1),
(13, 'Introduction to UX & UI Design<br/>
https://edex.adobe.com/en/resource/v3b9bc716', 'unknown', 'Adobe', 2018, 'CC', null, 0, 0, 1, null, 1),
(13, 'Adobe Indesign CC<br/>
https://helpx.adobe.com/content/dam/help/en/pdf/indesign_reference.pdf', 'unknown', 'Adobe', 2019, '20th', null, 0, 0, 1, null, 1),
(13, 'Design & Layout', 'Roger C. Parker', 'NXB Trẻ', 2010, '1st', null, 0, 1, 0, 'MOOC 05: Capstone: Your Story', 1),

(14, 'A Cognitive Psychology of Mass Communication', 'Richard Jackson Harris, Fred W. Sanborn', 'Routledge', 2019, '7th', '9781138046276', 1, 1, 0, 'Chọn 1 trong 2 Giáo trình (ưu tiên mua Giáo trình mới)', 1),
(14, 'A Cognitive Psychology of Mass Communication', 'Richard Jackson Harris, Fred W. Sanborn', 'Routledge', 2013, '6th', '9780415537056', 1, 1, 0, 'Chọn 1 trong 2 Giáo trình (ưu tiên mua Giáo trình mới)', 1),

(15, 'Problem Solving in Teams and Groups', 'Cameron W. Piercy', 'University of Kansas Libraries', null, null, null, 1, 0, 1, 'https://open.umn.edu/opentextbooks/textbooks/problem-solving-in-teams-and-groups', 1), 
(15, 'College Success', 'N/A', 'Lumen Learning courseware', null, null, null, 1, 0, 1, 'https://courses.lumenlearning.com/lumencollegesuccessxtraining2/ or https://courses.lumenlearning.com/lumencollegesuccessxtraining/', 1), 
(15, 'Business communication for success', 'N/A', 'University of Minnesota i', null, '2th', null, 1, 0, 1, 'https://www.oercommons.org/courses/basics-of-written-business-communication/view', 1), 
(15, 'Working in group 7th ed.', null, 'Pearson', null, null, null, 0, 1, 0, null, 1), 
(15, 'Business communication 7th ed.', null, 'Thomson-South Western', null, null, null, 0, 1, 0, null, 1), 
(15, 'PowerPoint Slides', null, null, null, null, null, 0, 0, 0, null, 1),

(16, 'Corporate Communication: A Guide to Theory and Practice', 'Joep P. Cornelissen', 'SAGE Publications Ltd', 2017, '5th', null, 1, 1, 0, null, 1),
(16, 'https.//hbr.org (Corporate Communication – HBR/ Harvard Business review)', null, null, null, null, null, 0, 0, 1, null, 1),
(16, 'https.//network.bepress.com (Business and Corporate Communications – open access section)', null, null, null, null, null, 0, 0, 1, null, 1),
(16, 'www. apps.prsa.org (create an account to view articles)', null, null, null, null, null, 0, 0, 0, null, 1),
(16, 'www.insituteforpr.org', null, null, null, null, null, 0, 0, 0, null, 1),

(17, 'https://www.coursera.org/specializations/social-media-marketing', null, 'Coursera', null, null, null, 1, 0, 1, '	Spec: https://www.coursera.org/specializations/social-media-marketing', 1),
(17, 'https://www.coursera.org/learn/social-marketing-capstone', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 6: Social Marketing Capstone Project', 1),
(17, 'https://www.coursera.org/learn/business-of-social', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 5: The Business of Social', 1),
(17, 'https://www.coursera.org/learn/social-imc', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 4: Content, Advertising & Social IMC', 1),
(17, 'https://www.coursera.org/learn/nurture-market-strategies', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 3: Engagement & Nurture Marketing Strategies', 1),
(17, 'https://www.coursera.org/learn/importance-of-listening', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 2: The Importance of Listening', 1),
(17, 'https://www.coursera.org/learn/what-is-social', null, 'Coursera', null, null, null, 1, 0, 1, 'MOOC 1: What is Social?', 1),

(18, 'Advertising and Promotion: An Integrated Marketing Communications Perspective', 'George E. Belch and Michael A. Belch', 'Irwin/McGraw-Hill', 2012, '9th', null, 1, 1, 0, null, 1),
(18, 'Additional readings on AdAge.com, Harvard Business Review, BusinessWeek', null, null, null, null, null, 0, 0, 1, null, 1),
(18, 'ISE Advertising and Promotion: An Integrated Marketing Communications Perspective', 'George E. Belch, Michael A. Belch', 'McGraw-Hill Education', 2021, '12th', 'ISBN13: 9781260570991', 1, 1, 0, 'Chọn một trong 2 quyển. Ưu tiên mua ấn bản mới nhất', 1);




INSERT INTO `swp391`.`prerequisite`
(`SyllabusID`,`SubjectID`,
`subjectPre`)
VALUES
(1, 1, null),
(3, 2, 'EAS202'),
(3, 2, 'ASG203'),
(4, 3, 'CDP391'),
(2, 4, null),
(5, 5, null),
(6, 6, 'MAD211'),
(7, 7, null),
(8, 8, null),
(9, 9, null),
(10, 10, null),
(11, 11, null),
(12, 12, null),
(13, 13, null),
(14, 14, null),
(15, 15, null),
(16, 16, null),
(17, 17, 8),
(18, 18, null);

INSERT INTO `swp391`.`assessment`
(`SyllabusID`,
`category`,
`Type`,
`Part`,
`Weight`,
`CompletionCriteria`,
`Duration`,
`QuestionType`,
`NoQuestion`,
`KnowledgeandSkill`,
`GradingGuide`,
`Note`)
VALUES
(2, 'Activity', 'on-going', 1, '10.0%', '>0', '"Option1: along the course Option2: Follow lecturer\'s proposal "',
 '"Option1: Participation Option2: Questions or Activities proposed by lecturer "', 'N/A', '"Option1: Based on student\'s class participation
Option2: Follow lecturer\'s proposal"', '"Option1: Class participation
Option2: Follow lecturer\'s proposal"', 'Lecturer selects appropriate assessment types according to the applied teaching method'),
(2, 'Group Assignment', 'on-going', 1, '15.0%', '>0', '	"Option1: 90\' Option2: Follow lecturer\'s proposal "', '"Option1: Each student group consists of 5 to 7 people, working together to develop a social project to be carried out in the real life. Student must draft and finalize their plan into a project proposal, then present it in front of classmates and lecturer. Option2: Questions or Activities proposed by lecturer"', 'N/A', 'Based on all the chapter in the textbook', '"Option1: Presentation in class
Option2: Follow lecturer\'s proposal"', 'Lecturer selects appropriate assessment types according to the applied teaching method'),
(2, 'Group Project', 'on-going', 1, '30.0%', '>0', '"Option1: along the course Option2: Follow lecturer\'s proposal "', '"Option1: Group projects are prepared from group assignment. Students work on a group project, based on the approved project proposal After carrying the project out the community, students must write a report of the entire project process and class presentations at the end of the semster. The presentations must reflect the ability to follow the oral presentation guidelines discussed in the textbook Option2: Questions or Activities proposed by lecturer"', 'N/A', 'All Course', '"Option1: Group products, reports on paper, and oral presentations on class
Option2: Follow lecturer\'s proposal"', 'Lecturer selects appropriate assessment types according to the applied teaching method'),
(2, 'Quiz 2', 'on-going', 1, '7.0%', '>0', 'Option1:30\'-60\' Option2 : Follow lecturer\'s proposal', '"Option1: Multiple choice or Essay Option2: Questions or Activities proposed by lecturer "', '"Option1: MC: 30-50 questions; Or Essay: 1-2 questions Option2: Follow lecturer\'s proposal"', 'Test the acquired knowledge in chapters 6-12.', '"Option1: EOS
Option2: Follow lecturer\'s proposal"','Lecturer selects appropriate assessment types according to the applied teaching method'),
(2, 'Quiz 1', 'on-going', 1, '8.0%', '>0', 'Option1: 30\'-60\' Option 2: Follow lecturer\'s proposal', '"Option1: Multiple choice or Essay Option2: Questions or Activities proposed by lecturer"','"Option1: MC: 30-50 questions; Or Essay: 1-2 questions Option2: Follow lecturer\'s proposal"', 'Test the acquired knowledge in chapters 1-5.', '"Option1: EOS
Option2: Follow lecturer\'s proposal"', 'Lecturer selects appropriate assessment types according to the applied teaching method'),
(2, 'Final Exam', 'final exam', 1, '30.0%', 4, '60\'', 'multiple choice questions', '50', null, 'Cover materials from the textbook, class discussions/lectures. All chapters covered in class.', null);


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
`Description`,
`DecisionNo`)
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
Sau khi tốt nghiệp, các cử nhân có thể học tiếp để lấy bằng cao học về Quản trị Kinh doanh và Truyền thông, Sản xuất nội dung Đa phương tiện.','1095/QĐ-ĐHFPT'),
('BIT_IA_K16B',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
('BIT_IA_K16C',10,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','1095/QĐ-ĐHFPT'),
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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','1095/QĐ-ĐHFPT'),
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
IsActive: True','1095/QĐ-ĐHFPT'),
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
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.','1095/QĐ-ĐHFPT'),
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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','1095/QĐ-ĐHFPT'),
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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','1095/QĐ-ĐHFPT'),
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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','1095/QĐ-ĐHFPT'),
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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','1095/QĐ-ĐHFPT'),
('BIT_SE_K16B',1,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
('BIT_SE_K16C',1,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','1095/QĐ-ĐHFPT'),
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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','1095/QĐ-ĐHFPT'),
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.','1095/QĐ-ĐHFPT'),
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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.','1095/QĐ-ĐHFPT'),
('BIT_IA_K16B',10,'Bachelor Program of Information Technology, Information Assurance','','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
('BIT_IoT_K16B',11,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
('BIT_IoT_K16C',11,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
('BBA_TM_K16C',4,'Bachelor Program of Business Adminstration','CTĐT ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','1095/QĐ-ĐHFPT'),
('BBA_HM_K16C',9,'Bachelor Program of Business Adminstration','CTĐT ngành QTKD','The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.','1095/QĐ-ĐHFPT'),
('BBA_HM_K16D,K17A',9,'Bachelor Program of Business Adminstration','CTĐT ngành QTKD','The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (15 subjects – 52 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (11 subjects – 40 credits): Provide the general and in-depth knowledge of Hotel operation and management; Sales and marketing in hotel business; Hotel revenue management, Event organization. Equip students with management skills in hotel services and working skills in a multicultural environment.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and practical skills in the areas of: Lodging management; Restaurant management; Event organization; Lodging-Restaurant management.

Upon graduation, students can build their career in the fields of tourism, accommodation management, restaurant & bars, and event management.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Quản trị khách sạn của Trường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về quản trị khách sạn, nhà quản lý, doanh nhân tiềm năng. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực quản trị khách sạn và trong môi trường quốc tế hoặc có tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (15 môn – 52 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (11 môn – 40 tín chỉ): Cung cấp các kiến thức chung và chuyên sâu về quản trị và vận hành lưu trú, bán hàng và marketing trong kinh doanh khách sạn, quản trị doạnh thu khách sạn, tổ chức sự kiện. Trang bị cho người học các kỹ năng tổ chức, quản lý vận hành các dịch vụ khách sạn và các kỹ năng làm việc trong môi trường đa văn hóa.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức chuyên sâu và nghiệp vụ thực tế về các lĩnh vực: Quản trị lưu trú; Quản trị nhà hàng; và Tổ chức sự kiện; Quản trị Lưu trú-Nhà hàng.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.','1095/QĐ-ĐHFPT'),
('BIT_IA_K16C',10,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
('BBA_MC_K16D,K17A',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
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
Sau khi tốt nghiệp, các cử nhân có thể học tiếp để lấy bằng cao học về Quản trị Kinh doanh và Truyền thông, Sản xuất nội dung Đa phương tiện.','1095/QĐ-ĐHFPT'),
('BBA_MC_K17B',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
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
Sau khi tốt nghiệp, các cử nhân có thể học tiếp để lấy bằng cao học về Quản trị Kinh doanh và Truyền thông, Sản xuất nội dung Đa phương tiện.','1095/QĐ-ĐHFPT'),
('BBA_MC_K17C',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
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
Sau khi tốt nghiệp, các cử nhân có thể học tiếp để lấy bằng cao học về Quản trị Kinh doanh và Truyền thông, Sản xuất nội dung Đa phương tiện.','1095/QĐ-ĐHFPT'),
('BBA_MC_K17D,18A',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
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
Sau khi tốt nghiệp, các cử nhân có thể học tiếp để lấy bằng cao học về Quản trị Kinh doanh và Truyền thông, Sản xuất nội dung Đa phương tiện.','1095/QĐ-ĐHFPT'),
('BBA_HM_K17C',9,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (15 subjects – 52 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (11 subjects – 40 credits): Provide the general and in-depth knowledge of Hotel operation and management; Sales and marketing in hotel business; Hotel revenue management, Event organization. Equip students with management skills in hotel services and working skills in a multicultural environment.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and practical skills in the areas of: Lodging management; Restaurant management; Event organization; Lodging-Restaurant management.

Upon graduation, students can build their career in the fields of tourism, accommodation management, restaurant&bars , and event management.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Quản trị khách sạn của Trường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về quản trị khách sạn, nhà quản lý, doanh nhân tiềm năng. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực quản trị khách sạn và trong môi trường quốc tế hoặc có tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (15 môn – 52 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (11 môn – 40 tín chỉ): Cung cấp các kiến thức chung và chuyên sâu về quản trị và vận hành lưu trú, bán hàng và marketing trong kinh doanh khách sạn, quản trị doạnh thu khách sạn, tổ chức sự kiện. Trang bị cho người học các kỹ năng tổ chức, quản lý vận hành các dịch vụ khách sạn và các kỹ năng làm việc trong môi trường đa văn hóa.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức chuyên sâu và nghiệp vụ thực tế về các lĩnh vực: Quản trị lưu trú; Quản trị nhà hàng; Tổ chức sự kiện; Quản trị Lưu trú-Nhà hàng.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.','1095/QĐ-ĐHFPT'),
('BBA_HM_K17B',9,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (15 subjects – 52 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (11 subjects – 40 credits): Provide the general and in-depth knowledge of Hotel operation and management; Sales and marketing in hotel business; Hotel revenue management, Event organization. Equip students with management skills in hotel services and working skills in a multicultural environment.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and practical skills in the areas of: Lodging management; Restaurant management; Event organization; Lodging-Restaurant management.

Upon graduation, students can build their career in the fields of tourism, accommodation management, restaurant&bars , and event management.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Quản trị khách sạn của Trường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về quản trị khách sạn, nhà quản lý, doanh nhân tiềm năng. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực quản trị khách sạn và trong môi trường quốc tế hoặc có tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (15 môn – 52 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (11 môn – 40 tín chỉ): Cung cấp các kiến thức chung và chuyên sâu về quản trị và vận hành lưu trú, bán hàng và marketing trong kinh doanh khách sạn, quản trị doạnh thu khách sạn, tổ chức sự kiện. Trang bị cho người học các kỹ năng tổ chức, quản lý vận hành các dịch vụ khách sạn và các kỹ năng làm việc trong môi trường đa văn hóa.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức chuyên sâu và nghiệp vụ thực tế về các lĩnh vực: Quản trị lưu trú; Quản trị nhà hàng; và Tổ chức sự kiện; Quản trị Lưu trú-Nhà hàng.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện','1095/QĐ-ĐHFPT'),
('BBA_HM_K17D, K18A',9,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (15 subjects – 52 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (11 subjects – 40 credits): Provide the general and in-depth knowledge of Hotel operation and management; Sales and marketing in hotel business; Hotel revenue management, Event organization. Equip students with management skills in hotel services and working skills in a multicultural environment.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and practical skills in the areas of: Lodging management; Restaurant management; Event organization; Lodging-Restaurant management.

Upon graduation, students can build their career in the fields of tourism, accommodation management, restaurant & bars, and event management.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Quản trị khách sạn của Trường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về quản trị khách sạn, nhà quản lý, doanh nhân tiềm năng. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực quản trị khách sạn và trong môi trường quốc tế hoặc có tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (15 môn – 52 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (11 môn – 40 tín chỉ): Cung cấp các kiến thức chung và chuyên sâu về quản trị và vận hành lưu trú, bán hàng và marketing trong kinh doanh khách sạn, quản trị doạnh thu khách sạn, tổ chức sự kiện. Trang bị cho người học các kỹ năng tổ chức, quản lý vận hành các dịch vụ khách sạn và các kỹ năng làm việc trong môi trường đa văn hóa.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức chuyên sâu và nghiệp vụ thực tế về các lĩnh vực: Quản trị lưu trú; Quản trị nhà hàng; Tổ chức sự kiện; Quản trị Lưu trú-Nhà hàng.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.','1095/QĐ-ĐHFPT'),
('BBA_HM_K18B',9,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

The program consists of four main modules:
• General knowledge and skills (12 subjects – 32 credits): Provide the general knowledge of political, cultural and social issues, and all essential skills to study and work in an active and changing environment.
• Major knowledge and skills (15 subjects – 52 credits): Provide the basic knowledge of the business administration major; and all essential skills and attitudes to become specialists in the business administration field.
• Specialized knowledge and skills (11 subjects – 40 credits): Provide the general and in-depth knowledge of Hotel operation and management; Sales and marketing in hotel business; Hotel revenue management, Event organization. Equip students with management skills in hotel services and working skills in a multicultural environment.
• Elective combo (5 subjects – 15 credits for each combo): Provide in-depth knowledge and practical skills in the areas of: Lodging management; Restaurant management; Event organization; Lodging-Restaurant management.

Upon graduation, students can build their career in the fields of tourism, accommodation management, restaurant & bars, and event management.

Mục tiêu tổng thể của chương trình cử nhân Quản trị Kinh doanh (QTKD) – Chuyên ngành Quản trị khách sạn của Trường Đại học FPT là đào tạo người học thành các nhà chuyên môn trong các lĩnh vực về quản trị khách sạn, nhà quản lý, doanh nhân tiềm năng. Có đủ các kiến thức và kỹ năng cần thiết để có làm việc trong lĩnh vực quản trị khách sạn và trong môi trường quốc tế hoặc có tiền đề cho việc học tập, nghiên cứu ở bậc học cao hơn.

Chương trình bao gồm bốn khối kiến thức lớn:
• Kiến thức kỹ năng chung (12 môn – 32 tín chỉ): Cung cấp cho người học các kiến thức chung về chính trị, văn hóa, xã hội; và các kỹ năng cần thiết để học tập và làm việc trong môi trường năng động luôn thay đổi.
• Kiến thức kỹ năng ngành (15 môn – 52 tín chỉ): Cung cấp các kiến thức cơ sở ngành quản trị kinh doanh; các kỹ năng và thái độ cần thiết để trở thành các nhà chuyên môn trong lĩnh vực quản trị kinh doanh.
• Kiến thức kỹ năng chuyên ngành (11 môn – 40 tín chỉ): Cung cấp các kiến thức chung và chuyên sâu về quản trị và vận hành lưu trú, bán hàng và marketing trong kinh doanh khách sạn, quản trị doạnh thu khách sạn, tổ chức sự kiện. Trang bị cho người học các kỹ năng tổ chức, quản lý vận hành các dịch vụ khách sạn và các kỹ năng làm việc trong môi trường đa văn hóa.
• Lựa chọn (5 môn – 15 tín chỉ cho mỗi lựa chọn): Cung cấp các kiến thức chuyên sâu và nghiệp vụ thực tế về các lĩnh vực: Quản trị lưu trú; Quản trị nhà hàng; Tổ chức sự kiện; Quản trị Lưu trú-Nhà hàng.

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.','1095/QĐ-ĐHFPT'),
('BBA_MC_K18B',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
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
Sau khi tốt nghiệp, các cử nhân có thể học tiếp để lấy bằng cao học về Quản trị Kinh doanh và Truyền thông, Sản xuất nội dung Đa phương tiện.','1095/QĐ-ĐHFPT'),
('BIT_AI_K15A',8,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
('BIT_SE_K15C',1,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
('BIT_SE_K15D, K16A',1,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
('BBA_FIN_K17D 18A',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','1095/QĐ-ĐHFPT'),
('BBA_FIN_K18B',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','1095/QĐ-ĐHFPT'),
('BBA_FIN_K18C',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','1095/QĐ-ĐHFPT'),
('BIT_GD_K15B',5,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.','1095/QĐ-ĐHFPT'),
('BIT_GD_K15C',5,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.','1095/QĐ-ĐHFPT'),
('BIT_GD_K15D,K16A',5,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.','1095/QĐ-ĐHFPT'),
('BIT_GD_K16D,K17A',5,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.','1095/QĐ-ĐHFPT'),
('BIT_GD_K17B',5,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.','1095/QĐ-ĐHFPT'),
('BIT_GD_K17C',5,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.','1095/QĐ-ĐHFPT'),
('BIT_GD_K17D,K18A',5,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.','1095/QĐ-ĐHFPT'),
('BIT_SE_K17C',1,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
('BIT_SE_K17D, K18A',1,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','1095/QĐ-ĐHFPT'),
('BIT_GD_K15A',5,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.','973/QĐ-ĐHFPT'),
('BIT_SE_K15A',1,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_SE_K15B',1,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IS_K15A',7,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
Sinh viên tốt nghiệp chương trình đào tạo phải thể hiện được những điều sau đây:
PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.
PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.
PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu);
PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.
PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IS_K15B',7,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
Sinh viên tốt nghiệp chương trình đào tạo phải thể hiện được những điều sau đây:
PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.
PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.
PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu);
PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.
PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IS_K15C',7,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
Sinh viên tốt nghiệp chương trình đào tạo phải thể hiện được những điều sau đây:
PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.
PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.
PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu);
PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.
PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IS_K15D, K16A',7,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
Sinh viên tốt nghiệp chương trình đào tạo phải thể hiện được những điều sau đây:
PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.
PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.
PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu);
PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.
PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_AI_K15C',8,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_AI_K15D, K16A',8,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_AI_K15B',8,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

1.1. General objectives:

Training Information Technology (IT)/ Information Assurance (IA) engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialties.
The training program aims to:
a) To equip students with fundamental knowledge of the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialties;
b) Train students the necessary virtues and skills in the professional working environment, know how to apply fundamental knowledge and specialized knowledge into practical work;
c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in study, work and life.

1.2 Specific objectives:
Graduates of the IT training program/AI specialty must demonstrate the following:
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

Đào tạo kỹ sư ngành Công nghệ thông tin (CNTT) có nhân cách và năng lực đáp ứng nhu cầu thực tế của xã hội, nắm vững kiến thức chuyên môn và thực hành, có khả năng tổ chức, thực hiện và phát huy sáng tạo trong các công việc liên quan đến các chuyên ngành được đào tạo.
Chương trình đào tạo nhằm:
a) Trang bị cho sinh viên kiến thức cơ bản của ngành CNTT cùng các phương pháp luận, công nghệ nền tảng và chuyên sâu của chuyên ngành;
b) Rèn luyện cho sinh viên những đức tính, kỹ năng cần thiết qua môi trường làm việc chuyên nghiệp, biết vận dụng các kiến thức ngành CNTT và các kiến thức chuyên ngành vào công việc thực tế;
c) Cung cấp cho sinh viên một nền tảng vững chắc về ngoại ngữ, khoa học, văn hóa, xã hội, phát huy tính chủ động, sáng tạo trong học tập, công việc và cuộc sống.

1.2 Mục tiêu cụ thể:

Sinh viên tốt nghiệp chương trình đào tạo CNTT phải thể hiện được những điều sau đây:

PO1. Có kiến thức cơ bản về khoa học xã hội, chính trị pháp luật, an ninh quốc phòng, kiến thức nền tảng của ngành CNTT & kiến thức chuyên sâu của chuyên ngành được đào tạo: kỹ thuật, phương pháp, công nghệ, các lĩnh vực ứng dụng chuyên sâu; xu hướng phát triển trên thế giới; đồng thời hiểu biết tổng thể thị trường, bối cảnh, chức năng, nhiệm vụ của các ngành nghề thuộc chuyên ngành được đào tạo.
PO2. Có thể làm việc được như một thành viên chính thức trong nhóm chuyên môn thuộc chuyên ngành được đào tạo: tham gia thiết kế, lựa chọn kỹ thuật và công nghệ phù hợp với xu hướng phát triển, giải quyết các vấn đề kỹ thuật; nắm được xu hướng công nghệ và yêu cầu người dùng; có thể làm kế hoạch phát triển hoàn thiện giải pháp; quản lý thực hiện và quản lý thay đổi trong phần công việc của mình; hiểu được các chính sách nhà nước về lĩnh vực chuyên ngành.
PO3. Thành thạo được các kỹ năng nghề nghiệp và các kỹ năng mềm của công dân thế kỷ 21 (kỹ năng tư duy, kỹ năng làm việc, kỹ năng sử dụng các công cụ làm việc, kỹ năng sống trong xã hội toàn cầu);
PO4. Sử dụng được tốt tiếng Anh trong học tập và công việc và một ngoại ngữ thứ hai trong giao tiếp thông thường.
PO5. Trung thực, kỷ luật cao trong học tập và công việc, biết làm việc nhóm một cách hiệu quả; biết ứng xử văn hóa trong công việc và xã hội; năng động, sáng tạo và có ý chí học tập không ngừng. Thể hiện thái độ và hành vi chuyên nghiệp với năng lực hình thành ý tưởng, thiết kế, thực hiện và vận hành hệ thống trong bối cảnh doanh nghiệp và xã hội.

- Vị trí việc làm sau khi tốt nghiệp:
Sinh viên tốt nghiệp chuyên ngành Trí tuệ nhân tạo có cơ hội việc làm đa dạng với một số vị trí điển hình như:
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

✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IA_K15A',10,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IA_K15B',10,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IA_K15C',10,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IA_K15D,K16A',10,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IA_K16B(FNO)',10,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IoT_K15A',11,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IoT_K15B',11,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IoT_K15C',11,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IoT_K15D,K16A',11,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_IoT_K16C(FNO)',11,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','973/QĐ-ĐHFPT'),
('BIT_GD_K18B',5,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
- Nghiên cứu viên/ Giảng viên/ học sau đại học: Có thể thực hiện nhiệm vụ nghiên cứu tại các trung tâm, đơn vị có nghiên cứu về lĩnh vực TKMTS.','973/QĐ-ĐHFPT'),
('BIT_IS_từ K16C',7,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','669/QĐ-ĐH-FPT'),
('BIT_AI_K15C, K15D, K16A',8,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','669/QĐ-ĐH-FPT'),
('BIT_AI_K16B, K16C',8,'Bachelor Program of Information Technology','CTĐT ngành CNTT','1. Training Objectives
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','669/QĐ-ĐH-FPT'),
('BBA_HM_K15B',9,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','""The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.""','336/QĐ-DHFPT'),
('BBA_HM_K15C',9,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','""The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.""','336/QĐ-DHFPT'),
('BBA_HM_K15D,K16A',9,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.','336/QĐ-DHFPT'),
('BBA_HM_K15A',9,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Hotel management program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of hotel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về du lịch, quản lý khách sạn, quản lý lưu trú và ẩm thực, quản lý và kinh doanh nhà hàng, quán bar, cafe, và tổ chức sự kiện.','336/QĐ-DHFPT'),
('BBA_IB_K16D,K17A',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','336/QĐ-DHFPT'),
('BBA_IB_K17B',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','336/QĐ-DHFPT'),
('BBA_IB_K17D 18A',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','336/QĐ-DHFPT'),
('BBA_IB_K18B',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','336/QĐ-DHFPT'),
('BBA_IB_K18C',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','336/QĐ-DHFPT'),
('BBA_IB_K17C',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','336/QĐ-DHFPT'),
('BIT_SE_từ K16B',1,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. Training Objectives
1.1 General objective:
Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research.
The training program aims to:
a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ;
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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','201/QĐ-ĐHFPT'),
('BIT_IoT_K16B(FNO)',11,'Bachelor Program of Information Technology','Chương trình cử nhân ngành CNTT','1. TRAINING OBJECTIVES

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
✔ Theo quy định về kiểm tra và đánh giá học phần trong quy chế đào tạo của trường Đại học FPT.','201/QĐ-ĐHFPT'),
('BBA_TM_K15A',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','200/QĐ-ĐHFPT'),
('BBA_TM_K15B',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','200/QĐ-ĐHFPT'),
('BBA_TM_K15C',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','200/QĐ-ĐHFPT'),
('BBA_TM_K15D,K16A',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','200/QĐ-ĐHFPT'),
('BBA_MKT_K15A',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_FIN_K15A',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_IB_K15A',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_MKT_K15B',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_FIN_K15B',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_FIN_K15C',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_IB_K15B',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_IB_K15C',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_FIN_K15D, K16A',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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
Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_MKT_K15C',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_MKT_K15D, K16A',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_IB_K15D K16A',12,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – International Business program of FPT University is to train students into specialists in international business, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính và đầu tư quốc tế, xuất nhập khẩu, vận tải và logistics, quản trị chuỗi cung ứng, marketing quốc tế, kinh doanh, mua hàng, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_TM_K16D,K17A',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','200/QĐ-ĐHFPT'),
('BBA_TM_K17B',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','200/QĐ-ĐHFPT '),
('BBA_TM_K17C',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','200/QĐ-ĐHFPT'),
('BBA_MKT_K16D,K17A',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_MKT_K17B',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_MKT_K17C',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_FIN_K16D,K17A',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_FIN_K17B',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_FIN_K17C',6,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Finance program of FPT University is to train students into specialists in financial management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về phân tích tài chính, tư vấn tài chính, môi giới tài chính, kế toán, kiểm toán, các vị trí quản trị về tài chính, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_MKT_K18B',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_TM_K17D 18A',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','200/QĐ-ĐHFPT'),
('BBA_MKT_K17D 18A',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_MKT_K18C',2,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Marketing program of FPT University is to train students into specialists in marketing management, managers, and entrepreneurs. Students will be equipped with all essential knowledge and skills to work in the field of marketing and in an international working environment, or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các lĩnh vực về marketing số, nghiên cứu thị trường, quảng cáo và quan hệ công chúng, tổ chức sự kiện, bán hàng, các vị trí quản trị về marketing, và khởi nghiệp.','200/QĐ-ĐHFPT'),
('BBA_TM_K18B',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','200/QĐ-ĐHFPT'),
('BBA_TM_K18C',4,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','The objective of the Bachelor of Business Administration – Tourism and Travel Management program of FPT University is to train students into specialists in tourism and travel management, tour guides, tour managers and operators. Students will be equipped with all essential knowledge and skills to work in the field of tourism and travel management and in an international working environment or to continue into the next higher level of education.

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

Sau khi tốt nghiệp, sinh viên có thể làm việc trong các cơ sở kinh doanh du lịch, tư vấn và tổ chức tour, sự kiện và teambuilding, xúc tiến quảng bá du lịch và hợp tác quốc tế, tham gia giảng dạy và bồi dưỡng nghiệp vụ du lịch, và khởi nghiệp trong lĩnh vực du lịch lữ hành.','200/QĐ-ĐHFPT'),
('BBA_MC_K15D,K16A',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
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
Sau khi tốt nghiệp, các cử nhân có thể học tiếp để lấy bằng cao học về Quản trị Kinh doanh và Truyền thông, Sản xuất nội dung Đa phương tiện.','199/QĐ-ĐHFPT'),
('BBA_MC_K15C',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
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
Sau khi tốt nghiệp, các cử nhân có thể học tiếp để lấy bằng cao học về Quản trị Kinh doanh và Truyền thông, Sản xuất nội dung Đa phương tiện.','199/QĐ-ĐHFPT'),
('BBA_MC_K15B',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
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
Sau khi tốt nghiệp, các cử nhân có thể học tiếp để lấy bằng cao học về Quản trị Kinh doanh và Truyền thông, Sản xuất nội dung Đa phương tiện.','199/QĐ-ĐHFPT'),
('BBA_MC_K15A',3,'Bachelor Program of Business Administration','Chương trình cử nhân ngành QTKD','1. Training Objectives
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
Sau khi tốt nghiệp, các cử nhân có thể học tiếp để lấy bằng cao học về Quản trị Kinh doanh và Truyền thông, Sản xuất nội dung Đa phương tiện.','199/QĐ-ĐHFPT');
INSERT INTO `swp391`.`curriculumsubject`
(`CurID`,
`SubjectID`)
VALUES
(1,1),
(1,11),
(1,15),
(1,16),
(1,6),
(1,18),
(1,17),
(1,8),
(1,3),
(1,5),
(1,9),
(1,13),
(2,1),
(2,11),
(2,15),
(2,16),
(2,6),
(2,18),
(2,17),
(2,8),
(2,3),
(2,5),
(2,9),
(2,13),
(3,1),
(3,11),
(3,15),
(3,16),
(3,6),
(3,18),
(3,17),
(3,8),
(3,3),
(3,5),
(3,9),
(3,13),
(4,1),
(4,11),
(4,15),
(4,16),
(4,6),
(4,18),
(4,17),
(4,8),
(4,3),
(4,5),
(4,9),
(4,13),
(5,1),
(5,11),
(5,15),
(5,16),
(5,6),
(5,18),
(5,17),
(5,8),
(5,3),
(5,5),
(5,9),
(6,1),
(6,11),
(6,15),
(6,16),
(6,6),
(6,18),
(6,17),
(6,8),
(6,3),
(6,5),
(6,9),
(7,1),
(7,11),
(7,15),
(7,16),
(7,6),
(7,18),
(7,17),
(7,8),
(7,3),
(7,5),
(7,9),
(8,1),
(8,11),
(8,15),
(8,16),
(8,6),
(8,18),
(8,17),
(8,8),
(8,3),
(8,5),
(8,9),
(9,1),
(9,11),
(9,15),
(9,16),
(9,6),
(9,18),
(9,17),
(9,8),
(9,3),
(9,5),
(9,9),
(10,1),
(10,11),
(10,15),
(10,16),
(10,6),
(10,18),
(10,17),
(10,8),
(10,3),
(10,5),
(10,9),
(11,1),
(11,11),
(11,15),
(11,16),
(11,6),
(11,18),
(11,17),
(11,8),
(11,3),
(11,5),
(11,9);

INSERT INTO `swp391`.`combocurriculum`
(`ComboID`,
`CurID`)
VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),
(1,12),
(1,13),
(1,14),
(1,15),
(1,16),
(1,17),
(1,18),
(1,19),
(1,20),
(1,21),
(2,1),
(2,2),
(2,3),
(2,4),
(2,5),
(2,6),
(2,7),
(2,8),
(2,9),
(2,10),
(2,11),
(2,12),
(2,13),
(2,14),
(2,15),
(2,16),
(2,17),
(2,18),
(2,19),
(2,20),
(2,21),
(3,1),
(3,2),
(3,3),
(3,4),
(3,5),
(3,6),
(3,7),
(3,8),
(3,9),
(3,10),
(3,11),
(3,12),
(3,13),
(3,14),
(3,15),
(3,16),
(3,17),
(3,18),
(3,19),
(3,20),
(3,21);
INSERT INTO `swp391`.`elective`
(`ElectiveNameEN`,
`ElectiveNameVN`,
`note`,
`isActive`)
VALUES
(N'BBA_MC_K16B TMI_ELE',N'TMI_ELE -- Traditional musical instrument_Nhạc cụ truyền thống',N'',1),
(N'Entrepreneurship Group 1_ Nhóm môn Khởi nghiệp 1',N'EXE_ELE -- Entrepreneurship Group 1_ Nhóm học phần Khởi nghiệp 1',N'',1),
(N'MC_Entrepreneurship 2 and Combos_ Nhóm học phần Khởi nghiệp 2 và Combos',N'MC_EXE_ELE -- MC_Entrepreneurship 2 and Combos_ Nhóm học phần Khởi nghiệp 2 và Combos',N'',1),
(N'BBA_MKT_K15A TMI_ELE',N'TMI_ELE -- Traditional musical instrument_Nhạc cụ truyền thống',N'',1),
(N'BBA_MKT_K15A MKT_ELE',N'	MKT_ELE -- Graduation Elective - Marketing',N'',1),
(N'BIT_GD_K16D,K17A TMI_ELE',N'	TMI_ELE -- Traditional musical instrument_Nhạc cụ truyền thống',N'',1),
(N'SE_Entrepreneurship 2 and Combos',N'	SE_EXE_ELE -- SE_Entrepreneurship 2 and Combos_ Nhóm môn Khởi nghiệp 2 và Combos',N'',1),
(N'Entrepreneurship Group 1_ Nhóm môn Khởi nghiệp 1',N'EXE_ELE -- Entrepreneurship Group 1_ Nhóm học phần Khởi nghiệp 1',N'',1);
INSERT INTO `swp391`.`curriculumelective`
(`ElectiveID`,
`CurID`)
VALUES
(1,1),
(2,1),
(3,1);
INSERT INTO `swp391`.`electivesubject`
(`ElectiveID`,
`SubjectID`)
VALUES
(1,25),
(1,26),
(1,27),
(1,28),
(1,29),
(1,30),
(1,31),
(1,8),
(1,5),
(1,13),
(2,1),
(2,18),
(2,11),
(2,15),
(2,3),
(2,17),
(2,6),
(2,8),
(2,5),
(2,13),
(3,1),
(3,18),
(3,11),
(3,15),
(3,3),
(3,17),
(3,6),
(3,8),
(3,5),	
(3,13);