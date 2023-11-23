USE [Lab9];
GO

SELECT * FROM BookInLib;
/* 1) обновление двух или более записей*/
UPDATE BookInLib
SET StatusID=StatusID+2 WHERE LibID IN (1,3);

SELECT * FROM BookInLib;

/* 2) те же изменения, но в двух операторах*/
UPDATE BookInLib
SET StatusID=StatusID+2 WHERE LibID = 1;

UPDATE BookInLib
SET StatusID=StatusID+2 WHERE LibID = 3;

SELECT * FROM BookInLib;

/* 3) изменение данных так, чтоб они были в первоначальном состоянии; 
Последовательность из одного update и insert в виде одной именованной транзакции*/

UPDATE BookInLib
SET StatusID=StatusID-2 WHERE LibID = 1;

SELECT * FROM BookInLib;

BEGIN TRAN T1
UPDATE BookInLib SET StatusID = StatusID+2 WHERE LibID=1;
INSERT INTO BookInLib VALUES (5,2,2);
ROLLBACK TRAN T1;
SELECT * FROM BookInLib;


/* 4) Поставить select между update и insert, который выбирает все записи из соответствующей таблицы*/

BEGIN TRAN T1
UPDATE BookInLib SET StatusID = StatusID+2 WHERE LibID=1;
SELECT * FROM BookInLib;
INSERT INTO BookInLib VALUES (5,2,2);
ROLLBACK TRAN T1;
SELECT * FROM BookInLib;


--5)
BEGIN TRAN T1
UPDATE BookInLib SET StatusID = StatusID+2 WHERE LibID=1;
SELECT * FROM BookInLib;
SAVE TRAN SaveT1;
INSERT INTO BookInLib VALUES (5,2,2);
ROLLBACK TRAN SaveT1;
SELECT * FROM BookInLib;
ROLLBACK TRAN T1;


