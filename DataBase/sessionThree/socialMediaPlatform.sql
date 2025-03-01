CREATE DATABASE SocialMediaPlatform;
USE SocialMediaPlatform;

--create table User
CREATE TABLE user_social(
UserID INT IDENTITY PRIMARY KEY,
Gender NVARCHAR(6) NOT NULL,
Email NVARCHAR(100) NOT NULL UNIQUE,
UserName NVARCHAR(100) NOT NULL UNIQUE,
JoinDate DATETIME DEFAULT  GETUTCDATE(),
DOB NVARCHAR(100),
);
--create table Post
CREATE TABLE Post(
PostID INT IDENTITY PRIMARY KEY,
Content NVARCHAR(100) NOT NULL,
PostDate DATETIME DEFAULT  GETUTCDATE(),
Status NVARCHAR(10) CHECK(Status IN ('Public','Private')),
UserID INT NOT NULL ,
FOREIGN KEY(UserID) REFERENCES user_social(UserID),
);
--create table Comment
CREATE TABLE Comment(
CommentID INT IDENTITY PRIMARY KEY,
Content NVARCHAR(100) NOT NULL,
CommentDate DATETIME DEFAULT  GETUTCDATE(),
UserID INT NOT NULL ,
FOREIGN KEY(UserID) REFERENCES user_social(UserID),
PostID INT NOT NULL ,
FOREIGN KEY(PostID) REFERENCES Post(PostID),
);
--create table Interaction
CREATE TABLE Interaction(
InteractionID INT IDENTITY PRIMARY KEY,
InteractionType NVARCHAR(100) NOT NULL,
InteractionDate DATETIME DEFAULT  GETUTCDATE(),
UserID INT NOT NULL ,
FOREIGN KEY(UserID) REFERENCES user_social(UserID),
PostID INT NOT NULL ,
FOREIGN KEY(PostID) REFERENCES Post(PostID),
);
--create table user_post
CREATE TABLE User_Post(
UserID INT NOT NULL ,
FOREIGN KEY(UserID) REFERENCES user_social(UserID),
PostID INT NOT NULL ,
FOREIGN KEY(PostID) REFERENCES Post(PostID),
);




--DML
INSERT INTO user_social(Gender,Email,UserName,DOB)
Values
('Female','tasneemgomaa@gmail.com','teto','hello every one'),
('Male','AliAyob@gmail.com','Aliiii','let have fun')

SELECT * FROM user_social



INSERT INTO Post(Content,Status,UserID)
Values
('first post ','Private',1),
('college is so tired','Public',2)

SELECT * FROM Post



INSERT INTO Comment(Content,UserID,PostID)
Values
('hi tasneem',1,1),
('hahaha that so funny',2,2)

SELECT * FROM Comment


INSERT INTO Interaction(InteractionType,UserID,PostID)
Values
('🤗',2,1),
('😂',1,2)

SELECT * FROM Interaction


INSERT INTO User_Post(UserID,PostID)
Values
(1,1),
(2,2)

SELECT * FROM User_Post