use Pesca
go

select * from Producto


create table TransaccionesProducto(
fecha_transaccion datetime,
tipotransaccion varchar(30),
usuarioresponsable varchar(30),
registronuevo varchar(255),
registroantiguo varchar(255),
equipohizooperacion varchar(30)
)
go

create trigger tr_transaProducto
on dbo.producto
for insert , delete , update	
as
begin
	Declare @v_tipoTransaccion varchar(max),
			@v_newRecord varchar(max), @v_olRecord varchar(max)
	if exists (select * from inserted) and exists (select * from deleted)
		begin 
			set @v_tipoTransaccion='Actualizacion de Datos'
			set @v_newRecord=(select  Codigo_Pro+space(1)+Descripcion_Pro+space(1)+Tipo_Pro+space(1)+cast(Precio_Pro as varchar(20))+space(1) from inserted)
			set @v_olRecord=(select Codigo_Pro+space(1)+Descripcion_Pro+space(1)+Tipo_Pro+space(1)+cast(Precio_Pro as varchar(20))+space(1) from deleted)

		end
	else if exists (select * from inserted)
		begin 
			set @v_tipoTransaccion='Insercion de registro'
			set @v_newRecord=(select Codigo_Pro+space(1)+Descripcion_Pro+space(1)+Tipo_Pro+space(1)+cast(Precio_Pro as varchar(20))+space(1) from inserted)
			set @v_olRecord=null
		end
	else 
		begin
			set @v_tipoTransaccion='Eliminacion de Registro'
			set @v_newRecord=null
			set @v_olRecord=(select Codigo_Pro+space(1)+Descripcion_Pro+space(1)+Tipo_Pro+space(1)+cast(Precio_Pro as varchar(20))+space(1) from deleted)
		end
	insert into TransaccionesProducto
	values
	(GETDATE(), @v_tipoTransaccion,USER_NAME(),@v_newRecord, @v_olRecord,HOST_NAME())
end
go

select * from TransaccionesProducto
select * from dbo.Producto


update Producto
set Descripcion_Pro='ATUN'
where Codigo_Pro='p03'
go

------------------------------
create or alter function dbo.fntablaFaena001(@p_Empl char(3))
returns table
as
	return(select p.Codigo_Emp,p.Nombre_Emp,f.Numero_Fae,f.FecIni_Fae,f.FecFin_Fae,f.ZonaMar_Fae from Empleado p join dbo.Barco B on p.Codigo_Bar=b.Codigo_Bar
												join Faena f on b.Codigo_Bar=f.Codigo_Bar
												where p.Codigo_Emp=@p_Empl)
go


select * from Empleado
select * from [dbo].[Barco]
select * from Faena 

select * from dbo.fntablaFaena001('E05')
go
---------------------------------------------------
create or alter procedure limaBarco
as 
begin
	select p.Codigo_Bar,p.Nombre_Bar,p.Capitan_Bar,p.Tipo_Bar,
			case 
				when p.Tipo_Bar=1 then 'Lancha' --then = entonces
				when p.Tipo_Bar>1 then 'No accecible' --then = entonces
					
			end as [Accecibilidad]
	from Barco p 
end
go

select * from Empleado


execute limaBarco


------------------------------------------
select * from Empleado


declare curSalePerson cursor for select p.Codigo_Emp+space(1)+p.Nombre_Emp+space(1)+p.FecIng_Emp+space(1)+p.HabBasico_Emp
			from Empleado p
			
			group by p.Codigo_Emp+space(1)+p.Nombre_Emp+space(1)+p.FecIng_Emp+space(1)+p.HabBasico_Emp
declare @v_monto decimal
open curSalePerson
fetch curSalePerson into @v_monto
while @@FETCH_STATUS=0
begin
	if @v_monto <=500
		set @v_monto=(@v_monto-(@v_monto*0.075))
	else if @v_monto >=501
		set @v_monto=(@v_monto-(@v_monto*0.1))
	else if @v_monto >750
		set @v_monto=(@v_monto-(@v_monto*0.125))

	print 'Total Facturado: '+cast(@v_monto as varchar(20))
	print replicate ('*',50)
		fetch curSalePerson into @v_monto
		
end
	close curSalePerson
	deallocate curSalePerson
go
