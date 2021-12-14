use master 
go

if db_id('BDViaje') is not null
	drop database BDViaje
go

--Crear la base de datos
create database BDViaje
go

--Adicionar un filegroup a la base de datos creada
alter database BDViaje
add filegroup FGAdministra
go

--Adicionar un datafile al filegroup de la BD
alter database BDViaje
add file
(name=ViajeData2, filename='C:\Data\ViajeData2.NDF')
to filegroup FGAdministra	


---------------------------------------------------
--schemas y user datatype
use BDViaje
go

-----------------
create schema RRHH
go

create schema Ventas
go

----------------
create type Phone from varchar(12)not null
go

create type Monto from smallmoney not null
go

--Creando tabla usando schema, user datatype y filegroup 
create table RRHH.TBEmpoyee(
idEmp char(5)not null,
nomEmp varchar(50)not null,
telEmp Phone,
sueEmp Monto,
bonoEmp as (sueEmp * 0.25) --Campo calculado (no se ingresa)
)on FGAdministra
go

--Mostrar la estructura de la tabla 
sp_help 'RRHH.TBEmpoyee'
go

-------
select * from sys.tables
go

--Modificacion de la estructura tabla 
--Adicionar un campo
alter table RRHH.TBEmpoyee
add fnaEmp date not null
go

--Mostrar la estructura de la tabla 
sp_help 'RRHH.TBEmpoyee'
go

--Modificar un campo
alter table RRHH.TBEmpoyee
alter column telEmp int not null
go

--Mostrar la estructura de la tabla 
sp_help 'RRHH.TBEmpoyee'
go

--Eliminar un campo
alter table RRHH.TBEmpoyee
drop column telEmp
go

--Mostrar la estructura de la tabla 
sp_help 'RRHH.TBEmpoyee'
go

--Adicionar campo calculado
alter table RRHH.TBEmpoyee
add gratifica as (sueEmp * 1.25)
go

--Mostrar la estructura de la tabla 
sp_help 'RRHH.TBEmpoyee'
go

-----//////---Tabla participada -------/////-----
--Paso 01: Crear filegroup segun el # de particiones
use  master
go

--Filegroups 
alter database BDViaje
add filegroup [FG001]
go

alter database BDViaje
add filegroup [FG002]
go

alter database BDViaje
add filegroup [FG003]
go

--Paso 02: Adicionar una datafile a cada filegroup
alter database BDViaje
add file
(name=ViajeDataP01, filename='C:\Data\ViajeDataP01.NDF')
to filegroup FG001
go

alter database BDViaje
add file
(name=ViajeDataP02, filename='C:\Data\ViajeDataP02.NDF')
to filegroup FG002
go

alter database BDViaje
add file
(name=ViajeDataP03, filename='C:\Data\ViajeDataP03.NDF')
to filegroup FG003
go

--Ver estructura
sp_helpdb BDViaje
go

-------------------------------------------------------
--A continuacion crear la participacion en la BD
use BDViaje
go

--Crear una funcion de particion

create partition function fnpNumerador(int)
as range left for values (2000,4000)
go

--Create un schema de particion 
create partition scheme scpNumerador
as partition fnpNumerador to([FG001],[FG002],[FG003])
go

--Crear tabla particionada
create table ventas.TBVentas(
id    int,
fecha date,
monto smallmoney
) on scpNumerador(id)
go

------------------------------------------------------
--Comprobar la particion
insert ventas.TBVentas
values
(1000,GETDATE(), 34000),
(2000,GETDATE(), 54000),
(2100,GETDATE(), 13000),
(4000,GETDATE(), 99000),
(4500,GETDATE(), 81000),
(8000,GETDATE(), 20000)
go

select * ,
	$partition.fnpNumerador(id) as [Nro de Particion]
from Ventas.TBVentas
go