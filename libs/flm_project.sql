	USE [ULMDatabase] 
	GO
create database ULMDatabase

	CREATE TABLE [Role] (
	  id varchar(255) NOT NULL, 
	  roleName varchar(255), 
	  PRIMARY KEY (id)
	);

	CREATE TABLE [User] (
	  id varchar(255) NOT NULL, 
	  username varchar(255) NOT NULL, 
	  password varchar(255), 
	  fullName varchar(255), 
	  email varchar(255), 
	  educationLevel varchar(255), 
	  roleID varchar(255) NOT NULL, 
	  PRIMARY KEY (id),
	  CONSTRAINT FKUser_Role FOREIGN KEY (roleID) REFERENCES [Role] (id)
	);

select * from [User]
	INSERT INTO [Role] (id, roleName) VALUES ('ADM', 'Admin');
	INSERT INTO [Role] (id, roleName) VALUES ('STD', 'Student');
	INSERT INTO [Role] (id, roleName) VALUES ('TCH', 'Teacher');

	INSERT INTO [User] (id, username, fullName, email, educationLevel, roleID)
	VALUES ('SE160028', 'baondse160028', 'Nguyen Duy Bao', 'baondse160028@fpt.edu.vn', 'FU', 'STD');

	INSERT INTO [User] (id, username, password, fullName, email, educationLevel, roleID)
	VALUES ('AD987654', 'admin001', '123456', 'Admin Ne', 'admin@example.com', NULL, 'ADM');
    select * from Subject

	CREATE TABLE [Subject] (
	  id           char(8), 
	  [name]        varchar(255), 
	  createdAt    date, 
	  updatedAt    date, 
	  semester     int, 
	  credit       int, 
	  PRIMARY KEY (id)
	  );

    INSERT INTO Subject (id, name, createdAt, semester, credit)
VALUES ('PRF192', 'Programming Fundamentals', '2022-03-16', 1, 3);

          INSERT INTO Subject (id, name, createdAt, semester, credit)
VALUES ('PRO192', 'Object-Oriented Programming', '2022-03-16', 1, 3);

select * from Subject

alter table Subject alter column id char(6) not null

ALTER TABLE Subject
DROP CONSTRAINT PK__Subject__3213E83F0BDD1ED1;

ALTER TABLE Knowledge
DROP CONSTRAINT FK__Knowledge__subje__7B5B524B;

ALTER TABLE Syllabus
DROP CONSTRAINT FK__Syllabus__subjec__6383C8BA;

create table [PreRequisite] (
    id int identity,
    subjectID char(8) not null,
	requisiteSubjectID  char(8) not null,
	FOREIGN KEY (subjectID) references [Subject] (id), 
	FOREIGN KEY (requisiteSubjectID) references [Subject] (id), 
)

select * from PreRequisite
   INSERT INTO PreRequisite (subjectID, requisiteSubjectID)
VALUES ('PRO192', 'PRF192');

	CREATE TABLE [Syllabus] (
	  id           int identity NOT NULL, 
	  subjectID    char(8) NOT NULL, 
	  [name]         varchar(255), 
	  credit       int, 
	  [description]  varchar(255), 
	  tasks        varchar(255), 
	  scoringScale int, 
	  [status]       bit, 
	  minScore     int, 
	  createdAt    date, 
	  updatedAt date,
	  isApproved   bit, 
	  FOREIGN KEY (subjectID) references [Subject] (id), 
	  PRIMARY KEY (id)
	  );

	CREATE TABLE [Material] (
	  id   int identity NOT NULL,
	  [name] varchar(255), 
	  [materialUrl]  varchar(255), 
	   syllabusID  int NOT NULL,
	  FOREIGN KEY (syllabusID) REFERENCES [Syllabus](id),
	  PRIMARY KEY (id)
	);

	ALTER TABLE KnowledgeCategory
	ADD CONSTRAINT [UNIQUE_NAME_KNOWLEDGE] UNIQUE (name)
	  
	CREATE TABLE [Curriculum] (
	  id int identity NOT NULL, 
	  code varchar(100) not null UNIQUE,
	  [name]        varchar(255) UNIQUE, 
	  [description] varchar(255), 
	  decisionNo  varchar(255), 
	  PRIMARY KEY (id),
	);



	CREATE TABLE [Program_Objective] (
	  id          int IDENTITY NOT NULL, 
	  [name]        varchar(255), 
	  [description] varchar(255), 
	  PRIMARY KEY (id),
	);
	alter table Program_Objective alter column [name] varchar(255)

			CREATE TABLE [Curr_to_PO] (
	  curriculumID int NOT NULL, 
	  PO_ID        int NOT NULL,
	  FOREIGN KEY (curriculumID) REFERENCES [curriculum](id),
	  FOREIGN KEY (PO_ID) REFERENCES [Program_Objective](id)
	);

		CREATE TABLE [Course_Learning_Objective] (
	  id          int identity NOT NULL, 
	  [name]       varchar(255), 
	  [description] varchar(255), 
	  syllabusID  int NOT NULL, 
	  PRIMARY KEY (id),
	  FOREIGN KEY (syllabusID) REFERENCES [Syllabus](id)
	);

		CREATE TABLE [Program_Learning_Objective] (
	  id          int NOT NULL, 
	  [name]        varchar(255), 
	  [description] varchar(255), 
	  PRIMARY KEY (id),
	);



CREATE TABLE [CLO_to_PLO_from_Cur] (
  PLO_ID        int NOT NULL, 
  CLO_ID        int NOT NULL, 
  curriculumID int NOT NULL,
  FOREIGN KEY (PLO_ID) REFERENCES [Program_Learning_Objective](id),
  FOREIGN KEY (CLO_ID) REFERENCES [Course_Learning_Objective](id),
  FOREIGN KEY (curriculumID) REFERENCES [Curriculum](id)
);



	CREATE TABLE [PO_to_PLO] (
	  PO_ID  int NOT NULL, 
	  PLO_ID int NOT NULL,
	  FOREIGN KEY (PO_ID) REFERENCES [Program_Objective](id),
	  FOREIGN KEY (PLO_ID) REFERENCES [Program_Learning_Objective](id)
	);

	

	CREATE TABLE [KnowledgeCategory] (
	  id          int NOT NULL, 
	  [name]        varchar(255) , 
	  [description] varchar(255), 
	  subjectID   char(8),
	  FOREIGN KEY (subjectID) references [Subject] (id), 
	  PRIMARY KEY (id)
	);

alter table KnowledgeCategory alter column name varchar(255)


	CREATE TABLE [Assessment] (
	  id                int NOT NULL, 
	  [name]             varchar(255), 
	  [type]             varchar(255), 
	  part              int, 
	  [weight]            decimal(19, 0), 
	  completionCriteria varchar(255), 
	  duration          varchar(255), 
	  CLO_ID			int NOT NULL, 
	  questionType      varchar(255), 
	  numberOfQuestion  varchar(255), 
	  knowledgeScope    varchar(255), 
	  gradingGuide      varchar(255), 
	  note              varchar(255), 
	  syllabusID		int NOT NULL,
	FOREIGN KEY (CLO_ID) REFERENCES [Course_Learning_Objective](id),
	FOREIGN KEY (syllabusID) references [Syllabus] (id), 
	  PRIMARY KEY (ID)
	);

	
	CREATE TABLE [Session] (
	  id              int NOT NULL, 
	  topic           varchar(255), 
	  learningType   varchar(255), 
	  LO_ID           varchar(255), 
	  materials       varchar(255), 
	  [studentTasks] varchar(255), 
	    syllabusID		int NOT NULL,
	FOREIGN KEY (syllabusID) references [Syllabus] (id), 
	  PRIMARY KEY (id));


	  
	CREATE TABLE [Questions] (
	  id          int NOT NULL, 
	  [name]        varchar(255), 
	  details     varchar(255), 
	  sessionID   int NOT NULL, 
	  PRIMARY KEY (id), 
	  FOREIGN KEY (sessionID) REFERENCES [Session](id),
	);




	





