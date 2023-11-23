use [Lab15];
go

-- проверка существования временной таблицы
IF OBJECT_ID('tempdb.dbo.#T') IS NOT NULL
   DROP TABLE dbo.#T
GO

-- создание временной таблицы
CREATE TABLE #T (
BookID int PRIMARY KEY, 
Author varchar(100),
Title varchar(255),
Publisher varchar(50),
BookYear smallint,
BookNum int
); 

-- заполняем таблицу
INSERT INTO #T (BookID, Author, Title, Publisher, BookYear)
 SELECT BookId, Author, Title, Publisher, BookYear FROM dbo.Book;
 GO

 -- проверяем
 SELECT * FROM #T;
 GO

 --- создание функции 
 CREATE FUNCTION dbo.fBookNum (@BoID int) RETURNS int
 AS
 BEGIN
  DECLARE @I INT =0;
  SET @I = ( SELECT count(*) 
         FROM dbo.Book INNER JOIN dbo.BookInLib ON dbo.Book.BookId = dbo.BookInLib.BookID
          WHERE dbo.Book.BookId = @BoID);
  RETURN @I;
 END ;
 GO

 ---проверка работы функции для книги с BookId=3
 print dbo.fBookNum(3)

 -- заполняем столбец с количеством книг в таблице #T
 UPDATE #T SET #T.BookNum = dbo.fBookNum(#T.BookID);

 --- проверяем результат
 SELECT * FROM #T

 --- объявляем переменную, получаем максимальное число книг и выводим
 DECLARE @MaxBookNum INT;
 SET @MaxBookNum = (SELECT MAX(#T.BookNum) FROM #T);
 print @MaxBookNum;
 GO

 ---различия в области видимости
 --- объявляем табличную переменную
 DECLARE @T1 TABLE (
BookID int PRIMARY KEY, 
Author varchar(100),
Title varchar(255),
Publisher varchar(50),
BookYear smallint,
BookNum int ); 
INSERT INTO @T1 (BookID, Author, Title, Publisher, BookYear, BookNum)
SELECT BookID, Author, Title, Publisher, BookYear, BookNum
FROM #T;

--- выводим значения - оба SELECT работают
SELECT * FROM #T;
SELECT * FROM @T1;
GO
--- область видимости
SELECT * FROM #T;
SELECT * FROM @T1;

GO

-- создание процедуры, считающей количество книг с указанным статусом
CREATE PROC dbo.PBookNum (@StatusName varchar(50), @result int OUTPUT) AS
 BEGIN
 IF @StatusName IS NULL RETURN -1
  ELSE IF EXISTS(SELECT * FROM dbo.BookStatus WHERE StatusName=@StatusName) 
         BEGIN
		  SET @result=(SELECT count(*) FROM dbo.BookStatus INNER JOIN dbo.BookInLib ON 
		                   (dbo.BookStatus.StatusID = dbo.BookInLib.StatusID)
				       WHERE dbo.BookStatus.StatusName = @StatusName);         
		  RETURN 0;
		 END
       ELSE BEGIN
	           INSERT INTO dbo.BookStatus (StatusName) VALUES (@StatusName);
			   SET @result=0;
			   RETURN 1;
	        END;

 END;
GO

-- проверяем работу процедуры
DECLARE @ret INT, @res INT;
exec @ret =  dbo.PBookNum 'выдана', @res out;
 IF @ret=-1 print 'вы не ввели название статуса'
   ELSE IF @ret=0 print 'Число книг '+ CAST(@res as varchar(20))
         ELSE IF @ret=1 print 'В таблицу добавлен новый статус';
GO

---создание DML триггера на BoolInLib - нельзя заводить больше 5 экземпляров книги
CREATE TRIGGER CheckNum On dbo.BookInLib
AFTER INSERT, UPDATE
AS BEGIN
    IF EXISTS (SELECT b.BookID FROM dbo.BookInLib b INNER JOIN inserted i on b.BookID=i.BookID
	           GROUP BY b.BookID 
			   HAVING count(distinct b.LibID)>5)
	 BEGIN
	  RAISERROR ('Экземпляров книги должно быть не больше 5',1,1);
	  ROLLBACK TRANSACTION
	 END
   END
GO


--- книг с LibID 10-15 нет
SELECT * FROM [dbo].[BookInLib];

INSERT INTO [dbo].[BookInLib]
VALUES (10,1,1), (11,1,2), (12,2,1), (13,1,2),(14,1,1),(15,1,2);

SELECT * FROM [dbo].[BookInLib];

---проверяем, что триггер добавление записей срабатывает (6-я запись про 1-ю книгу)
INSERT INTO [dbo].[BookInLib]
VALUES (16,1,1);

--- если вообще записей в таблице больше 5, на update должен сработать триггер
UPDATE dbo.BookInLib set BookID=1;

--- если записей  про вторую книгу в таблице меньше 5, update должен выполниться
UPDATE dbo.BookInLib set BookID=2 WHERE LibID=10;
GO

-- DDL триггер, запрещающий менять и удалять таблицы и представления
CREATE TRIGGER StopDropAlter
ON DATABASE
AFTER DROP_TABLE, ALTER_TABLE, DROP_VIEW, ALTER_VIEW
AS
BEGIN
 RAISERROR ('В этой базе нельзя удалять и менять таблицы и представления',10,1);
 ROLLBACK TRANSACTION
END;
GO

--проверяем, на ALTER должен сработать триггер
ALTER TABLE dbo.BookInLib
ADD NewInt INT;
GO



