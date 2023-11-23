USE master
GO

USE [newBase];
GO

CREATE TABLE dbo.Book (
	book_id int IDENTITY (1, 1) primary key,
	Title varchar(50) NOT NULL, 
	Author varchar(50), 
	Publisher varchar(50), 
	[Year] smallint) 
GO
CREATE TABLE dbo.Status (
Status_id int IDENTITY (1, 1) PRIMARY KEY,
Status_name varchar(50) NOT NULL )  
GO

CREATE SCHEMA libr 
GO

CREATE TABLE libr.Book_in_lib (
lib_id int PRIMARY KEY , 
book_id int references dbo.Book ,
status_id int references dbo.[Status])
GO
-- создаем login
USE master
GO

CREATE LOGIN TestUser WITH PASSWORD = 'L@b$User1';
GO

use newBase;
GO
--для учетной записи TestUser создаем пользователя ns 
CREATE USER ns FOR LOGIN [TestUser];
GO


EXEC sp_addrolemember 'db_datareader', 'ns'

--создаем новую роль, даем роли разрешения и добавляем в нее пользователя ns 
CREATE ROLE libr_writer
GO
GRANT INSERT, UPDATE, DELETE ON SCHEMA :: libr TO libr_writer
Go
EXEC sp_addrolemember 'libr_writer', 'ns'
GO

--создайте представление, выбирающее из таблицы Book книги, изданные не ранее 2000 года
-- нужно контролировать условие >= при обновлении
CREATE VIEW dbo.v1
AS
SELECT * FROM dbo.Book WHERE [Year]>=2000
WITH CHECK OPTION; 
GO


GRANT INSERT, UPDATE ON dbo.v1 TO ns;
