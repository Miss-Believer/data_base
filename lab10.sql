USE [Lab9]
GO

INSERT INTO Book (Author, Title, Publisher, BookYear)
VALUES ('Дейт К.', 'Введение в системы баз данных. 8-е издание', 'Издательский дом Вильямс', 2005);

SELECT @@IDENTITY as LastID;

INSERT INTO Book (Author, Title, Publisher, BookYear)
VALUES ('Карпова Т.С.', 'Базы данных', 'Питер', 2001);

INSERT INTO Book (Author, Title, BookYear)
VALUES ('Зеленин М.В.', 'Экспертные системы', 1996);

INSERT INTO BookStatus (StatusName)
VALUES ('в библиотеке'), ('в учебном классе'), ('выдана');

INSERT INTO BookStatus (StatusName)
VALUES ('устарела');

SELECT * FROM Book;
SELECT * FROM BookStatus;

INSERT INTO BookInLib
VALUES (1,2,1),(2,2,3),(3,3,3);

SELECT * FROM BookInLib;

CREATE TABLE #BookStatus(
	StatusID int PRIMARY KEY, 
	StatusName varchar(50) NOT NULL UNIQUE);
INSERT INTO #BookStatus SELECT * FROM BookStatus;
SELECT * FROM #BookStatus;

CREATE TABLE #Book(
	BookId int PRIMARY KEY,
	Author varchar(100),
	Title varchar(255) NOT NULL,
	Publisher varchar(50),
	BookYear smallint );
INSERT INTO #Book SELECT * FROM Book WHERE Book.BookYear>2000;

UPDATE #Book SET BookYear=2000 WHERE BookId=2;

SELECT @@ROWCOUNT as NumOfRows;

UPDATE #Book SET BookYear=BookYear+2;
SELECT * FROM #Book; 

UPDATE #BookStatus SET StatusName='обветшала' WHERE StatusName='устарела';
SELECT * FROM #BookStatus;

DELETE FROM #Book;
DELETE FROM #BookStatus WHERE StatusID=2;

DELETE FROM #BookStatus WHERE StatusName='обветшала';


