if db_id('BDBackus ')is not null	
	drop database BDBackus 
go

create database BDBackus
on 
(name = Backus_Data, filename='C:\Exam\Backus_Data.MDF'
,size=18MB, maxsize=90MB, filegrowth=20MB)
log on
(name=Backus_Log, filename='C:\Exam\Backus_Log.LDF',
size=10MB, maxsize=210MB, filegrowth=35%)
go


-----------------------------------------

alter database BDBackus
add filegroup FGBackus01
go

alter database BDBackus
add filegroup FGBackus02
go

alter database BDBackus
add filegroup FGBackus03
go

--------------------------------------
Alter DataBase BDBackus
Add File
(name=Backus_DataN1, filename='C:\Eval\Backus_DataN1.NDF')
to filegroup FGBackus01
go

Alter DataBase BDBackus
Add File
(name=Backus_DataN2, filename='C:\Eval\Backus_DataN2.NDF')
to filegroup FGBackus02
go

Alter DataBase BDBackus
Add File
(name=Backus_DataN3, filename='C:\Eval\Backus_DataN3.NDF')
to filegroup FGBackus03
go

-------------------------------------------
create schema COMP 
go

create schema VENT
go
----------------------------------
create table Usuario(
TD_VC varchar(50) not null,
TD_NU numeric(16,4) null,
TD_IN int not null
)
go

---------------------------------
create table VENT.Proveedor(
IdProveedor char(5) not null,
NombreProveedor varchar(50)not null,
Direccion varchar(50) not null,
Ciudad varchar(50) not null,
Pais varchar(50) not null,
telefono varchar(12)not null

constraint PKProveedor primary key(IdProveedor)

)on FGBackus01
go

create table VENT.Categoria(
IdCategoria char(5)not null,
NombreCategoria varchar(50) not null,

constraint PKCategoria primary key(IdCategoria)

)on FGBackus01
go

create table VENT.Producto(
IdProducto char(5) not null,
NombreProducto varchar(50)not null,
IdProveedor char(5) not null,
IdCategoria char(5)not null,
CantidadPorUnidad int not null,
PrecioUnidad money not null,
UnidadesEnexistencia varchar(50) not null,

constraint PKProducto primary key(IdProducto),
constraint FKIdProveedor foreign key (IdProveedor) references VENT.Proveedor,
constraint FKIdCategoria foreign key (IdCategoria) references VENT.Categoria

)on FGBackus01
go

---------------------------------------
alter table VENT.Producto
add constraint CKPrecioUnidad check (PrecioUnidad >= 20),
	constraint CKUnidadesEnexistencia check (UnidadesEnexistencia >= 30)
go

--------------------------------------------
create partition function fnpPedidos(int)
as range left for values (10400 ,10800 )
go

create partition scheme scpGenerados
as partition fnpPedidos to([FGBackus01],[FGBackus02],[FGBackus03])
go

create table VENT.Pedido(
idPedi int not null,
FecPedi  datetime,
Pais  VarChar(50)
) on scpGenerados(idPedi)
go

insert VENT.Pedido
values
(1000,GETDATE(), 'Canada'),
(1020,GETDATE(), 'Peru'),
(2100,GETDATE(), 'Brazil'),
(4000,GETDATE(), 'Argentina'),
(4500,GETDATE(), 'Ecuador'),
(8000,GETDATE(), 'Japon')
go
---------------------------

select * ,
	$partition.fnpPedidos(idPedi) as [Pedido]
from VENT.Pedido
go

create unique index idxNombreProveedor on VENT.Proveedor(NombreProveedor)
go

create unique index idxDireccion on VENT.Proveedor(Direccion)
go

create unique index idxPais on VENT.Proveedor(Pais)
go
