if db_id('BDViaje')is not null	
	drop database BDViaje
go

create database BDViaje
go

use BDViaje
go

---------------Creando Schemas 
create schema schVentas
go

create schema schRRHH
go

-- ver schemas
select * from sys.schemas
go

--comprobar uso de schemas
create table TBClientes(
idclie int,
nomClie varchar(50)
)
go

-------------------
create table schRRHH.TBPersonal(
idper int,
nomPer varchar(50)
)
go

--------------
alter schema schVentas -- Aqui es donde se coloca el schema donde deseas colocarlo
transfer dbo.TBClientes --Aqui se escribe la tabla que quieres transferir
go

---- si quieres eliminar un schemas , no puedes si el schemas tiene tablas, lo que puedes hacer 
---- es migrar esa informacion a otra schema y a puedes eliminar el schema


create table TBCliente (
idclie int,
nomClie varchar(50)
)
go
create table TBPersonal(
idper int,
nomPer varchar(50)
)
go

create schema Sales
go

create schema HHRR
go

-------------------
alter schema Sales
transfer dbo.TBCliente
go



alter schema HHRR
transfer dbo.TBPersonal
go

--Tipo de dato de usuario--
-- usuario sp_addtype
sp_addtype fono, 'varchar(10)','not null'
go

sp_addtype genero, 'char(1)','not null'
go
--usando create type
create type tiempo from datetime not null
go

---------------------
create table Sales.Vendedor(
id int,
nom varchar(50),
tel fono,
sexVend genero,
fna tiempo
)
go
--tipo table--
create type TCliente as table (
campo1 varchar(30),
campo2 varchar(30),
campo3 varchar(30)
)
go

-----------------------------
-- Usando tipo tabla
Declare @vt_Customer TCliente
insert @vt_Customer
values
('A01','Ana Torres','Mexico'),
('A02','Sergio Peña','Colombia')
select * from @vt_Customer
go