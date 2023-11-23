USE [Lab9];
GO

SELECT * FROM BookInLib;
/* 1) ���������� ���� ��� ����� �������*/
UPDATE BookInLib
SET StatusID=StatusID+2 WHERE LibID IN (1,3);

SELECT * FROM BookInLib;

/* 2) �� �� ���������, �� � ���� ����������*/
UPDATE BookInLib
SET StatusID=StatusID+2 WHERE LibID = 1;

UPDATE BookInLib
SET StatusID=StatusID+2 WHERE LibID = 3;

SELECT * FROM BookInLib;

/* 3) ��������� ������ ���, ���� ��� ���� � �������������� ���������; 
������������������ �� ������ update � insert � ���� ����� ����������� ����������*/

UPDATE BookInLib
SET StatusID=StatusID-2 WHERE LibID = 1;

SELECT * FROM BookInLib;

BEGIN TRAN T1
UPDATE BookInLib SET StatusID = StatusID+2 WHERE LibID=1;
INSERT INTO BookInLib VALUES (5,2,2);
ROLLBACK TRAN T1;
SELECT * FROM BookInLib;


/* 4) ��������� select ����� update � insert, ������� �������� ��� ������ �� ��������������� �������*/

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


