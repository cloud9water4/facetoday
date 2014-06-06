--2014년 6월 1일 수정--

CREATE TABLE members (
   email VARCHAR(100),
   NAME VARCHAR(30) NOT NULL,
   passwd VARCHAR(64) NOT NULL,
   birth VARCHAR(20),
   social VARCHAR(20),
   PRIMARY KEY(email, social)   
)

CREATE TABLE boards (
	board_num INT PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(100),
	social VARCHAR(20),
	write_date VARCHAR(30) NOT NULL,
	content VARCHAR(1000) NOT NULL,
	lat VARCHAR(50),
	lon VARCHAR(50),
	state INT,
	keyword varchar(100),
	image varchar(255),
	tagString varchar(255),
	c_num INT,
	
	CONSTRAINT pk_members_email_social FOREIGN KEY (email, social) REFERENCES MEMBERS(email, social)
)

CREATE TABLE images (
	image_num INT PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(100),
	social VARCHAR(20),
	image VARCHAR(255),
	CONSTRAINT pk_members_email_social FOREIGN KEY (email, social) REFERENCES MEMBERS(email, social)
)

CREATE TABLE comments (
	comment_num INT PRIMARY KEY AUTO_INCREMENT,
	board_num INT FOREIGN KEY REFERENCES boards ON DELETE CASCADE,
	email VARCHAR(100),
	social VARCHAR(20),
	NAME VARCHAR(30),
	write_date VARCHAR(30),
	content VARCHAR(500),
	
	CONSTRAINT pk_members_email_social FOREIGN KEY (email, social) REFERENCES MEMBERS(email, social)
)
CREATE TABLE boards (
	board_num INT PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(100),
	social VARCHAR(20),
	write_date VARCHAR(30) NOT NULL,
	content VARCHAR(1000) NOT NULL,
	lat VARCHAR(50),
	lon VARCHAR(50),
	state INT,
	keyword varchar(100),
	image varchar(255),
	tagString varchar(255),
	CONSTRAINT pk_members_email_social FOREIGN KEY (email, social) REFERENCES MEMBERS(email, social)
)

CREATE TABLE songs (
	song_num INT PRIMARY KEY AUTO_INCREMENT,
	singer VARCHAR(30) NOT NULL,
	title VARCHAR(50) NOT NULL,
	release VARCHAR(20) NOT NULL,
	genre VARCHAR(20) NOT NULL,
	state INT NOT NULL,
	weather VARCHAR(30) NOT NULL,
	source VARCHAR(100)
);

CREATE TABLE SongList (
	email VARCHAR(100),
	social VARCHAR(20),
	list_num INT AUTO_INCREMENT,
	sources VARCHAR(5000) NOT NULL,
	list_name VARCHAR(100) NOT NULL,
	
	CONSTRAINT pk_members_email_social FOREIGN KEY (email, social) REFERENCES MEMBERS(email, social)
)

CREATE TABLE config (
	profile VARCHAR(1000) NOT NULL,
	email VARCHAR(100) FOREIGN KEY REFERENCES MEMBER(email),
	gender INT,
	nation VARCHAR(30),
	location VARCHAR(30),
	university VARCHAR(30),
	preference VARCHAR(200),
	singer VARCHAR(200),
	
	PRIMARY KEY(profile, email)
)

CREATE TABLE friends (
	emailFriend VARCHAR(100),
	socialFriend VARCHAR(20),
	email VARCHAR(100),
	social VARCHAR(20),
	
	PRIMARY KEY(emailFriend, socialFriend),
	CONSTRAINT pk_members_email_social FOREIGN KEY (email, social) REFERENCES MEMBERS(email, social)	
)
