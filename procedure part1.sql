use Negocios ;

--Ver catalogo de procedimiento almacenados en la bd
select * from sys.procedures;

--Eliminar de procedimiento almacenado
drop procedure Ventas.usp001
drop procedure Ventas.usp002
drop procedure Ventas.usp003
drop procedure Ventas.uspInvoqueal003
go

--Procedimiento almacenado de usuario
--Fase 01
create or Alter Procedure usp001
as
begin 

	select * from Ventas.clientes

end;

--Fase 02: Ejecucion del procedimiento almacenado
execute usp001;

--
exec usp001;
--
usp001;
-------------------------------
--Eliminar procedimiento
drop procedure usp001;

--Crear procedimiento en un esquema
--Fase 01:
create or alter procedure ventas.usp001
as
begin

	select * from Ventas.clientes

end 
go

--Fase 2:
exec Ventas.usp001; -- a diferencia de arriba se guardo dento de la schema ventas

--Uso de parametro
--Fase 01
create or alter procedure ventas.usp001
 @p_id_pais char(6)
 as
 begin

	select * from Ventas.clientes
	where idpais=@p_id_pais

 end
 go

 --Fase 
 exec ventas.usp001 '001'; -- Imprime los datos de ventas.cliente su idpais = 001 

 exec ventas.usp001 '002'; -- Imprime los datos de ventas.cliente su idpais = 002

 --Uso de parametro con valor predeterminado
 --Fase1
create or alter procedure ventas.usp001
 @p_id_pais char(6) = '002'
 as
 begin

	select * from Ventas.clientes
	where idpais=@p_id_pais

 end
 go

 --Fase 02 efecutar el sp sin definir valor para el parametro
 exec Ventas.usp001 --opta con el recurso de id predeterminado es 002
 go

 --Fase 03 ejecutar el sp definiendo valor al parametro
 exec ventas.usp001 '005' --por medio del parametro fue que se puede cambiar el valor predeterminado

 -----------------------------------
 --Usando parametros de tipo fecha 
 --Fase 01
 create or alter procedure ventas.ups002
 @p_fecha1 date, @p_fecha2 date
 as 
 begin

	select * from Ventas.pedidoscabe
	where FechaPedido between @p_fecha1 and @p_fecha2

 end
 go

 --Fase 2:
 set dateformat dmy; --con eso se pode el dia mes y año se configura

 ----Ejecucion correcta
 execute ventas.ups002 '21/02/98','05/03/98'
 go

 --Ejecucion fallida
 execute ventas.ups002 '05/03/98','21/02/98'
 go

 --Modifiacar el sp anterior para evadir el orden de las fechas, caso contrario genere un error leve
 --Fases

  create or alter procedure ventas.ups002
 @p_fecha1 date, @p_fecha2 date
 as 
 begin
	
	if @p_fecha1<@p_fecha2
		select * from Ventas.pedidoscabe
		where FechaPedido between @p_fecha1 and @p_fecha2
	else
		raiserror('Error en las orden de las fechas.....',10,1)

 end
 go

 ----------------------------------------------------------
 --Modificar el sp anterior para modificar el nivel de la severidad del error grave controlándolo
 --con try / catch

 create or alter procedure ventas.ups002
 @p_fecha1 date, @p_fecha2 date
 as 
 begin
	begin try
		if @p_fecha1<@p_fecha2
			select * from Ventas.pedidoscabe
			where FechaPedido between @p_fecha1 and @p_fecha2
		else
			raiserror('Error en las orden de las fechas.....',16,1)
	end try
	begin catch

		print error_message()
		print 'Numero de error '+ str(error_number())

	end catch


 end
 go

  ----Ejecucion correcta
 execute ventas.ups002 '21/02/98','05/03/98'
 go

 --Ejecucion fallida
 execute ventas.ups002 '05/03/98','21/02/98'
 go