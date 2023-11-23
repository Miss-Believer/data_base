USE [Lab9]
GO

SELECT * FROM [dbo].[Book] WHERE [Title] LIKE 'Б%';

SELECT Title FROM  Book 
WHERE BookYear > 1999 and (Author like 'Г%' OR Publisher like '%а') 
ORDER BY Title DESC;

SELECT * FROM Book WHERE Title LIKE '_!%%' ESCAPE '!';

SELECT Title FROM Book WHERE Title LIKE '_%!_%' ESCAPE '!';

SELECT DISTINCT Publisher
FROM (BOOK INNER JOIN BookInLib ON BOOK.BookId=BookInLib.BookID) INNER JOIN BookStatus ON BookInLib.StatusID= BookStatus.StatusID
WHERE BookStatus.StatusName='выдана';

SELECT DISTINCT Publisher
FROM (BOOK LEFT JOIN BookInLib ON BOOK.BookId=BookInLib.BookID) LEFT JOIN BookStatus ON BookInLib.StatusID= BookStatus.StatusID
WHERE (BookInLib.LibID IS NULL) OR (BookStatus.StatusName='выдана');

SELECT T.StatusName, T1.StatusName FROM BookStatus AS T, BookStatus AS T1
WHERE T.StatusID<>T1.StatusID;

SELECT DISTINCT B.Publisher, B1.Publisher FROM Book AS B, Book AS B1
WHERE B.Publisher <> B1.Publisher;


