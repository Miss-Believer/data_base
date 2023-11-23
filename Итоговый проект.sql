USE [myProgect]
GO

CREATE TABLE Employee(
	Emp_id int PRIMARY KEY IDENTITY(1,1),
	Emp_name varchar (40) NOT NULL,
	Empl_num int,
	Post_id int
);

CREATE TABLE Readers(
	Reader_id int PRIMARY KEY identity(1,1),
	Reader_name varchar(40) NOT NULL,
	Read_num int
);

CREATE TABLE Book(
	Book_id int PRIMARY KEY identity(1,1),
	Author varchar(100),
	Title varchar(255) NOT NULL,
	Publisher varchar(50),
	Genre_id int
);

SELECT * FROM Book
GO

SELECT 


CREATE TABLE Genre(
	Genre_id int PRIMARY KEY identity(1,1),
	Genre_name varchar(50) NOT NULL
);


CREATE TABLE BookStatus(
	StatusID int PRIMARY KEY, 
	StatusName varchar(50) NOT NULL UNIQUE,
	
);

CREATE TABLE Post(
	post_id int PRIMARY KEY identity(1,1), 
	post_name varchar (20) not null);

DECLARE Book_cursor CURSOR 
DYNAMIC FOR SELECT * FROM Book

OPEN Book_cursor
FETCH NEXT FROM Book_cursor
INSERT INTO Book VALUES ('Пушкин А.С.', 'Русалка', 'Росмэн', 3)
WHILE @@FETCH_STATUS = 0
BEGIN
	FETCH NEXT FROM Book_cursor
END
CLOSE Book_cursor
DEALLOCATE Book_cursor
GO



ALTER TABLE Book ADD CONSTRAINT Genre_id FOREIGN KEY(Genre_id) REFERENCES Genre(Genre_id) 

USE[myProgect]
GO
CREATE FUNCTION _Genre (@Genre_id int) RETURNS int
 AS
 BEGIN
  DECLARE @I INT =0;
  SET @I = ( SELECT count(*) 
         FROM dbo.Book INNER JOIN dbo.Genre ON dbo.Book.Genre_id = dbo.Genre.Genre_id
          WHERE dbo.Book.Genre_id = @Genre_id);
  RETURN @I;
 END ;
 GO

 print dbo._Genre(4)

USE[myProgect]
GO
CREATE PROCEDURE Books AS 
BEGIN
	SELECT Author AS Titles, Publisher FROM Book
END;
GO
EXEC Books



CREATE TABLE _Book(
	Book_id int PRIMARY KEY identity(1,1),
	Author varchar(100),
	Title varchar(255) NOT NULL,
	Publisher varchar(50),
	Genre_id int,
	isDeleted BIT Null 
);



USE[myProgect]
GO
CREATE TRIGGER Book_delete ON _Book
INSTEAD OF DELETE 
AS
UPDATE _Book 
SET isDeleted = 1 WHERE Book_id =(SELECT Book_id FROM deleted) 
DELETE FROM _Book WHERE Author= 'Пушкин'
SELECT * FROM _Book



INSERT INTO Genre(Genre_name) VALUES('роман'), ('детектив'), ('ужасы'), ('фантастика'), ('проза')
INSERT INTO BookStatus (StatusName) VALUES ('в библиотеке'), ('устарела'), ('выдана');


