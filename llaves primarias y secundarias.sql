use master
go

if db_id('BDViaje') is not null
	drop database BDViaje
go

--Crear base de datos determinada
create database BDViaje
go


--uso de base de datos
use BDViaje
go


--Crear schemas
create schema MKT
go

--Create tabla con su PK
create table MKT.Pais(
idPais int not null,
nomPais varchar(50)not null,
constraint PKPais primary key(idPais)
)
go

create table MKT.Tienda(
idTienda int not null,
nomTienda varchar(50) not null,
dirTienda varchar(50) not null
)
go

--Adicionar la llave primaria a la tabla MKT.Tienda
alter table MKT.Tienda
add constraint PKTienda primary key nonclustered(idTienda)
go

--------------------------------------
create table MKT.Cliente(
idCliente char(5) not null,
nomCliente varchar(40) not null,
idPais int,
constraint PKCliente primary key (idCliente),
constraint FKPaisCliente foreign key (idPais) references MKT.Pais
)
go

------------------------------------------------------
create table MKT.Proveedor(
idProveedor char(5) not null,
nomProveedor varchar(50) not null,
idPais int,
constraint PKProveedor primary key (idProveedor),
constraint PKPaisProveedor foreign key (idPais) references MKT.Pais
			on delete cascade 
)
go
------------------------------------------------------
create table MKT.Empleado(
idEmpleado char(5) not null,
nomEmpleado varchar(50) not null,
idTienda int,
constraint PKEmpleado primary key nonclustered (idEmpleado)
)
go

--------------------
alter table MKT.Empleado
add constraint FKTiendaEmpleado foreign key (idTienda) references MKT.Tienda
				on update cascade
go

-----Unique----------
create table MKT.Conductor(
codCond char(5) not null,
nomCond varchar(50) not null,
apCond varchar(50) not null,
brvCond	char(11) not null,

constraint UQBrevete Unique (brvCond)

)

--Adicionar unique compuesto

Alter table MKT.Conductor

Add constraint UQNombreApellido Unique (nomCond, apCond)

go
--Default

create table MKT.Postulante(
codPos char(5) not null,
nomPos varchar(50) not null,
eciPos varchar(50) constraint DFEcivil default 'Soltero',
frePos date
)
go

----

Alter Table MKT.Postulante

Add Constraint DFFechaRegistro Default Getdate() for frePos

go