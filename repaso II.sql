use Negocios
go

create table material
(
idmaterial char(7),
nommaterial varchar(30),
constraint plmaterial primary key (idmaterial)
)
go

------
--crear un fin escalar que permite generar id de material de la siguiente manera
--

create or alter function dbo.genercodmaterial() returns varchar(7)
As
Begin
	Declare @idmaterial varchar(7), @n int
	if not exists(Select * from material)
		set @idmaterial='1000'
	else
		Select Top 1 @idmaterial=SUBSTRING(idmaterial,4,4) from material Order by idmaterial 


	Set @n=CAST(@idmaterial as varchar(7))+1
	Set @idmaterial=CONCAT('MAT',REPLICATE('0',4-LEN(CAST(@n as varchar(4)))),CAST(@n as varchar(4))

	return @idmaterial

End
go


INSERT INTO Material VALUES(dbo.genercodmaterial(),'Papel')
INSERT INTO Material VALUES(dbo.genercodmaterial(),'Lapiceros')
go

select * from Material
go

----profe code

create or alter function fngeneration01()
returns char(7)
as
begin
	declare @v_contado int 
	declare @v_cod char(7)
	set @v_contado=(select count(*) from material)
	set @v_cod='Mat'+cast((1000+(@v_contado+1)) as varchar(4))
	return @v_cod
end
go

select * from material

insert into material
values(
dbo.fngeneration01(),'Cemento')
go

---------------------------------------
--crear la tabla con los distritos dados

Create Table ControlDistritos
(
nrotransaccion int identity,
fecha_transaccion datetime,
tipotransaccion varchar(30),
usuarioresponsable varchar(30),
registronuevo varchar(255),
registroantiguo varchar(255),
equipohizooperacion varchar(30)
)
go
('1','2002-08-02','corriente','Salo','10001','01110','192923323')

create trigger ControlDistritos001
on ControlDistritos
for insert , delete , update	
as
begin
	Declare @v_tipoTransaccion varchar(max),
			@v_newRecord varchar(max),
			@v_olRecord varchar(max)
	if exists (select * from inserted) and exists (select * from deleted)
		begin 
			set @v_tipoTransaccion='Actualizacion de Datos'
			set @v_newRecord=(select cast(nrotransaccion as varchar(50))+space(1)+cast(fecha_transaccion as varchar (50))+space(1)+tipotransaccion
								+space(1)+usuarioresponsable+space(1)+registronuevo+space(1)+cast(registroantiguo as varchar(50))
								+space(1)+equipohizooperacion from inserted)
			set @v_olRecord=(select cast(nrotransaccion as varchar(50))+space(1)+cast(fecha_transaccion as varchar (50))+space(1)+tipotransaccion
								+space(1)+usuarioresponsable+space(1)+registronuevo+space(1)+cast(registroantiguo as varchar(50))
								+space(1)+equipohizooperacion from deleted)

		end
	else if exists (select * from inserted)
		begin 
			set @v_tipoTransaccion='Insercion de registro'
			set @v_newRecord=(select cast(nrotransaccion as varchar(50))+space(1)+cast(fecha_transaccion as varchar (50))+space(1)+tipotransaccion
								+space(1)+usuarioresponsable+space(1)+registronuevo+space(1)+cast(registroantiguo as varchar(50))
								+space(1)+equipohizooperacion from inserted)
			set @v_olRecord=null
		end
	else 
		begin
			set @v_tipoTransaccion='Eliminacion de Registro'
			set @v_newRecord=null
			set @v_olRecord=(select cast(nrotransaccion as varchar(50))+space(1)+cast(fecha_transaccion as varchar (50))+space(1)+tipotransaccion
								+space(1)+usuarioresponsable+space(1)+registronuevo+space(1)+cast(registroantiguo as varchar(50))
								+space(1)+equipohizooperacion from deleted)
		end
	insert into ControlDistritos
	values
	(USER_NAME(), HOST_NAME(), GETDATE(), @v_tipoTransaccion, @v_newRecord, @v_olRecord)
end
go

set nocount on 
insert into ControlDistritos
values
(101,'2002-08-02','corriente','Salo','10001','01110','192923323')
go

select * from ControlDistritos

drop trigger controllima001
--profe
create trigger controllima001
on rrhh.distritos
for insert, delete, update
as
begin
	declare @v_tipoTransaccion varchar(50),
			@v_newRecord varchar(255),
			@v_olRecord varchar(255)

			if exists(select * from inserted) and exists (select * from deleted)
				begin
					set @v_tipoTransaccion='Actualizacion'
					set @v_newRecord=(select ltrim(str(idDistrito)) + space(1)+ nomDistrito from inserted)
					set @v_olRecord=(select ltrim(str(idDistrito)) + space(1)+ nomDistrito from deleted)

				end
			if exists(select * from inserted)
				begin
					set @v_tipoTransaccion='Insercion'
					set @v_newRecord=(select ltrim(str(idDistrito)) + space(1)+ nomDistrito from inserted)
					set @v_olRecord=null
				end
			else 
				begin
					set @v_tipoTransaccion='Eliminacion'
					set @v_newRecord=null
					set @v_olRecord=(select ltrim(str(idDistrito)) + space(1)+ nomDistrito from inserted)
				end

		Insert into ControlDistritos
		values
		(GETDATE(), @v_tipoTransaccion,USER_NAME(),@v_newRecord, @v_olRecord,HOST_NAME())
end
go

-----------------------------------
select * from RRHH.Distritos
go

select * from ControlDistritos
go

-----------------------------------
insert into rrhh.Distritos
values
(5,'san borja')
go


update RRHH.Distritos
set nomDistrito='San lucho'
where idDistrito=4
go