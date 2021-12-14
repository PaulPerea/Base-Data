use BDViaje
go

--Crear un schema
create schema TKM
go

--------CHECK------------
--Create tabla con restriccion check
create table TKM.Producto(
codPro char(5) not null,
nomPro varchar(50) not null,
fepPro date,
fvePro date,
prePro smallmoney,

constraint CKCodPro check(codPro like 'P[0-9][0-9][0-9][0-9]')
)
go

--Adicionar check a la tabla creada

alter table TKM.Producto
add constraint CKVencimiento check (fvePro > fepPro),
	constraint CKPrecio check (prePro > 0)
go



--
alter table TKM.Producto with nocheck --with nocheck , es aqui donde los datos se guardaran a partir de la fecha actual o mas adelante
add constraint CKFechaProduccion check (fepPro > getdate())
go

----------------------------------
insert  TKM.Producto
values('XE001','Tambor de freno',GETDATE()+1,GETDATE()+10,1000)
go

--Desabilitar check
alter table TKM.Producto
nocheck constraint CKCodPro
go
-------------------------------

insert  TKM.Producto
values('XE001','Tambor de freno',GETDATE()+1,GETDATE()+10,1000)
go

----------------------------------
--Habilitar check
alter table TKM.Producto
check constraint CKCodPro
go

--Si QUIERES QUE SE DESABILITE , VUELVE A DEABILITAR Y INGRES Y LUEGO HABILITA


select * from TKM.Producto
go


----------------------------------
--Eliminar check
alter table TKM.Producto
drop constraint CKCodPro
go

--IDENTITY-------
create table TKM.Ticket(
nroTicket int identity(1000,1), --IDENTITY(1000,1) SIGNIFICA QUE VA A ENPEZAR DE 1000 Y IRA EN 1 EN 1
fecTicket date,
fevTicket date,
nomEvento varchar(50),
valTicket smallmoney
)
GO

-------------------------------
insert TKM.Ticket
values
(10,GETDATE(),GETDATE()+15,'Concierto Laura vozo',230),
(11,GETDATE(),GETDATE()+30,'Team choclito vs perdedores',560)
go

--Cuando utilizas el identiti , haces que el sistema cuente desde donde quieres que cuente
-----------
select * from TKM.Ticket
go



--Resetear el identity-------
dbcc checkIdent ('TKM.Ticket',Reseed,5000)
go

--Ver los identitys creados
select * from sys.identity_columns
go

--Desactivar identity
set identity_insert BDViaje.TKM.Ticket on
go

--Ingresar datos sin identitys
insert TKM.Ticket
(nroTicket,fecTicket,fevTicket,nomEvento,valTicket)
values
(10,GETDATE(),GETDATE()+15,'Concierto Laura vozo',230),
(11,GETDATE(),GETDATE()+30,'Team choclito vs perdedores',560)
go

--Activar identity
set identity_insert BDViaje.TKM.Ticket off
go


insert TKM.Ticket
values
(GETDATE(),GETDATE()+15,'Concierto Nadie',230),
(GETDATE(),GETDATE()+30,'Team choclito vs team J',560)
go

------------Indices-------------
create index idxNombreEvento on TKM.Ticket(nomEvento)
go

--
create unique index idxNombreProducto on TKM.Producto(nomPro)
go