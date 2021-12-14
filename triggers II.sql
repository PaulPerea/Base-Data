use Negocios
go

--Auditar tabla paises
--paso 01 : crear la tabla auditoria donde la registrará las transacciones de la tabla Pais
create table auditaPais(
usuario varchar(50),
host	varchar(50),
fecha	datetime,
tipoTran varchar(50),
newRecord text,
oldRecord text
)
go

-----------------------------------
select * from Ventas.paises
select * from auditaPais
go




--Paso 02 :Crear el trigger
create trigger tr_autitapais
on ventas.paises
for insert , delete , update	
as
begin
	Declare @v_tipoTransaccion varchar(max),
			@v_newRecord varchar(max), @v_olRecord varchar(max)
	if exists (select * from inserted) and exists (select * from deleted)
		begin 
			set @v_tipoTransaccion='Actualizacion de Datos'
			set @v_newRecord=(select Idpais+space(1)+NombrePais from inserted)
			set @v_olRecord=(select Idpais+space(1)+NombrePais from deleted)

		end
	else if exists (select * from inserted)
		begin 
			set @v_tipoTransaccion='Insercion de registro'
			set @v_newRecord=(select Idpais+space(1)+NombrePais from inserted)
			set @v_olRecord=null
		end
	else 
		begin
			set @v_tipoTransaccion='Eliminacion de Registro'
			set @v_newRecord=null
			set @v_olRecord=(select Idpais+space(1)+NombrePais from deleted)
		end
	insert into auditaPais
	values
	(USER_NAME(), HOST_NAME(), GETDATE(), @v_tipoTransaccion, @v_newRecord, @v_olRecord)
end
go

--Comprabando la efectividad del trigger
--Insercion 

set nocount on 
insert Ventas.paises
values
('10','Costa Rica')
go

--Actualizacion
update Ventas.paises
set NombrePais='Peru'
where Idpais='200'
go

--Eliminacion
delete from Ventas.paises
where Idpais='200'
go

----------------------------------------
--Crear auditoria a la tabla producto
create table auditaProducto(
usuario varchar(50),
host	varchar(50),
fecha	datetime,
tipoTran varchar(50),
newRecord text,
oldRecord text
)
go

select * from Compras.productos
select * from auditaProducto
go

create trigger tr_autoriaProducto
on Compras.productos
for insert , delete , update	
as
begin
	Declare @v_tipoTransaccion varchar(max),
			@v_newRecord varchar(max), @v_olRecord varchar(max)
	if exists (select * from inserted) and exists (select * from deleted)
		begin 
			set @v_tipoTransaccion='Actualizacion de Datos'
			set @v_newRecord=(select  cast(IdProducto as char(4))+space(1)+NomProducto from inserted)
			set @v_olRecord=(select  cast(IdProducto as char(4))+space(1)+NomProducto from deleted)

		end
	else if exists (select * from inserted)
		begin 
			set @v_tipoTransaccion='Insercion de registro'
			set @v_newRecord=(select  cast(IdProducto as char(4))+space(1)+NomProducto from inserted)
			set @v_olRecord=null
		end
	else 
		begin
			set @v_tipoTransaccion='Eliminacion de Registro'
			set @v_newRecord=null
			set @v_olRecord=(select cast(IdProducto as char(4))+space(1)+NomProducto from deleted)
		end
	insert into auditaProducto
	values
	(USER_NAME(), HOST_NAME(), GETDATE(), @v_tipoTransaccion, @v_newRecord, @v_olRecord)
end
go

update Compras.productos
set NomProducto='Holes'
where IdProducto='3'
go

delete from Compras.productos
where IdProducto=2
go