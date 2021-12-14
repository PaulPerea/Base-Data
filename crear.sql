If Db_Id('BDTravel') is not null

	Drop Database BDContoso

go



--Crear BD de forma predeterminada[no recomendado]

Create Database BDContoso

go

--Ver la estructura
sp_helpdb BDContoso
go

if db_id('BDTravel') is not null
	drop database BDTravel
go

-----------------------------
create database BDTravel
on 
(name = TravelData, filename='C:\Data\TravelData.MDF'
,size=30MB, maxsize=80MB, filegrowth=10MB)
log on
(name=TravelLog, filename='C:\Data\TravelLog.LDF',
size=40MB, maxsize=100MB, filegrowth=10%)
go

-----------------------------------
Create Database BDTravel
On
(name=TravelData, filename='C:\Data\TravelData.MDF',
size=30MB, maxsize=80MB, filegrowth=10MB),
(name=TravelData1, filename='C:\Data\TravelData1.NDF',
size=30MB, maxsize=80MB, filegrowth=10MB),
(name=TravelData2, filename='C:\Data\TravelData2.NDF',
size=30MB, maxsize=80MB, filegrowth=10MB)
Log On
(name=TravelLog, filename='C:\Data\TravelLog.LDF',
size=40MB, maxsize=100MB, filegrowth=10%),
(name=TravelLog1, filename='C:\Data\TravelLog1.LDF',
size=40MB, maxsize=100MB, filegrowth=10%)
go


-----------------------------------------------------
create database DBTravel 
on
(name=TravelData1, filename='C:\Data\TravelData1.MDF',
size=20MB, maxsize=50MB, filegrowth=5MB)
log on
(name=TravelLog1, filename='C:\Data\TravelLog1.LDF',
size=50MB, maxsize=200MB, filegrowth=10%)
go

sp_helpdb BDTravel
go

--Modificar Archivos de Data Base--
alter database BDTravel
modify file
(name=TravelData1, maxsize=450MB)
go

alter database BDTravel
modify file
(name=TravelLog1, filegrowth=25%)
go

--Adicionar archivos a la base de datos--
--Adicionar DataFile--
alter database BDTravel
add file
(name=TravelData2, filename='C:\Data\TravelData2.NDF')
go

--Adicionar  logFile
alter database BDTravel
add log file
(name=TravelLog2, filename='C:\Data\TravelLog2.LDF')
go

--Mover Archivos de datos a una nueva ubicacion
--Paso 01 : Desacoplar la base de datos
sp_detach_db BDTravel
go

--Paso 02 : Mover los archivos a la nueva ubicacion con el explorador de windows

--Pase 03 : Crear DB , adjunto los nuevos archivos en una nueva ubicacion
create database BDTravel
on
(filename='C:\newFolder\TravelData.MDF'),
(filename='C:\newFolder\TravelData1.NDF'),
(filename='C:\newFolder\TravelData2.NDF'),
(filename='C:\newFolder\TravelLog.LDF'),
(filename='C:\newFolder\TravelLog1.LDF'),
(filename='C:\newFolder\TravelLog2.LDF')
for attach
go

sp_helpdb BDTravel
go

--Crear los grupos para la mejor visualizacion de el jefe

alter database BDTravel
add filegroup FGComercial
go

alter database BDTravel
add filegroup FGAdministra
go

--Adicionar un Datafile a cada filegroup

--Adicionar un Datafile a cada filegroup

Alter DataBase BDTravel
Add File
(name=TravelDataComercial, filename='C:\Data\TravelDataComercial.NDF')
to filegroup FGComercial
go


Alter Database BDTravel
Add File
(name=TravelDataAdministra, filename='C:\Data\TravelDataAdministra.NDF')
to filegroup FGAdministra
go

create table TBPrueba(
id int,
nom varchar(50)
)
go


create table TBDemo(
id int,
nom varchar(50)
) on FGComercial
go

