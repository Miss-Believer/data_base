
USE [Lab9];
GO

SELECT * FROM sys.database_files;
SELECT * FROM sys.filegroups;
GO

SELECT physical_name FROM sys.database_files WHERE type = 1;

SELECT COUNT(DISTINCT name) as Num FROM sys.filegroups WHERE is_read_only = 0;

SELECT * FROM sys.schemas;
SELECT * FROM sys.tables;
SELECT * FROM sys.views;
GO

CREATE SCHEMA newsch;
GO

SELECT * FROM sys.schemas WHERE name ='newsch';
GO

CREATE VIEW newsch.vAuthor AS SELECT Author FROM dbo.Book;
GO
SELECT * FROM newsch.vAuthor;
GO

ALTER VIEW newsch.vAuthor AS SELECT DISTINCT Author FROM dbo.Book;
GO

SELECT COUNT(*) as NumOfViews FROM sys.schemas sc INNER JOIN sys.views sv
on sc.schema_id = sv.schema_id WHERE sc.name = 'newsch';

