USE [Lab9];
GO
--1)
DECLARE @BookCount INT, @MinYear INT, @MaxYear INT;
SET @BookCount= (SELECT Count(*) FROM Book);
SET @MinYear=(SELECT Min(BookYear) FROM Book);
SET @MaxYear=(SELECT Max(BookYear) FROM Book);
PRINT 'в таблице Book '+ cast(@BookCount AS VARCHAR(5))+ ' книги, изданных с ' + cast(@MinYear AS VARCHAR(5)) + ' по ' + cast(@MaxYear AS VARCHAR(5))+' годы '
GO

--2)
DECLARE @BookCount INT, @MinYear INT, @MaxYear INT;
SELECT @BookCount=Count(*), @MinYear = Min(BookYear), @MaxYear = Max(BookYear) FROM Book;
PRINT 'в таблице Book '+ cast(@BookCount AS VARCHAR(5))+ ' книги, изданных с ' + cast(@MinYear AS VARCHAR(5)) + ' по ' + cast(@MaxYear AS VARCHAR(5))+' годы '
GO

--3)
DECLARE @MinYear INT, @MaxYear INT, @Year INT;
SELECT @MinYear = Min(BookYear), @MaxYear = Max(BookYear) FROM Book;
SET @Year=@MinYear;
	WHILE @Year<=@MaxYear
			BEGIN
			SELECT*fROM Book WHERE BookYear=@Year;
			SET @Year = @Year+1;
			END;
GO

--4)
DECLARE @MinYear INT, @MaxYear INT, @Year INT;
SELECT @MinYear = Min(BookYear), @MaxYear = Max(BookYear) FROM Book;
SET @Year=@MinYear-1;
WHILE @Year<=@MaxYear
			BEGIN
			SET @Year = @Year+1;
			IF @Year=2000 CONTINUE; --BREAK
			SELECT*fROM Book WHERE BookYear=@Year;
			END;
GO

--5)
DECLARE @Books TABLE (
	[BookId] int PRIMARY KEY,
	[Author] varchar(100),
	[Title] varchar(255) NOT NULL,
	[Publisher] varchar(50),
	[BookYear] smallint );
INSERT INTO @Books (BookId,Author,Title,Publisher,BookYear)
SELECT BookId, Author, Title, 
       CASE 
	    WHEN Publisher='Политехника' THEN Publisher
		WHEN Publisher IS NULL THEN 'издательства нет'
		ELSE 'издательство не Политехника'
	   END,
	   BookYear
FROM Book;
SELECT * FROM @Books;
GO

/*SELECT * FROM @Books; табличная переменная перестала существовать*/

--6
IF OBJECT_ID('tempdb..#Books') IS NOT NULL DROP TABLE #Books;
CREATE TABLE #Books ([BookId] int PRIMARY KEY,
	[Author] varchar(100),
	[Title] varchar(255) NOT NULL,
	[Publisher] varchar(50),
	[BookYear] smallint );
INSERT INTO #Books (BookId,Author,Title,Publisher,BookYear)
SELECT BookId, Author, Title, 
       CASE 
	    WHEN Publisher='Политехника' THEN Publisher
		WHEN Publisher IS NULL THEN 'издательства нет'
		ELSE 'издательство не Политехника'
	   END,
	   BookYear
FROM Book;
SELECT * FROM #Books;
GO
SELECT * FROM #Books;

