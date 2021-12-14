If Db_Id('BDArtesa') is not null

	Drop Database BDArtesa

go

Create Database BDArtesa

go

use BDArtesa
go

------------------------

sp_helpdb BDArtesa
go
-------------------------------
--Adicionar on
alter database BDArtesa
add file
(name=Artesa_DataN1, filename='C:\DataArtesa\ Artesa_DataN1.NDF',
size=100MB, maxsize=500MB, filegrowth=5MB)
go

--Adicionar  logFile
alter database BDArtesa
add log file
(name=Artesa_Log2, filename='C:\LogArtesa\ Artesa_Log2.LDF',
size=200MB, maxsize=650MB, filegrowth=10%)
go

---------------------------
alter database BDArtesa
modify file
(name=Artesa_DataN1, maxsize=700MB)
go

alter database BDArtesa
modify file
(name=Artesa_Log2, filegrowth=25%)
go
----------------------------
alter database BDArtesa
add filegroup FGSales
go
----------------
Alter DataBase BDArtesa
Add File
(name=Artesa, filename='C:\DataArtesa\FGSalesComercial.NDF')
to filegroup FGSales
go
