use Negocios
go

---------------------
--cursores
--------------
--Ejemplo 01: Basico
declare c_lista cursor for select NomCliente,DirCliente from Ventas.clientes
open c_lista -- abre
fetch c_lista --leer
close c_lista --clierra
deallocate c_lista --libera

--Ejemplo 02 : Funcion @@Fetch_status
declare c_pais cursor for select * from Ventas.paises
open c_pais
fetch c_pais
print @@fetch_status
close c_pais
deallocate c_pais

--Ejemplo 03: Recorrer un cursor
declare c_emple cursor for select  NomEmpleado,ApeEmpleado,FecNac from rrhh.empleados
declare @v_nom varchar(max),@v_ap varchar(max), @v_fn date
open c_emple
fetch c_emple into @v_nom,@v_ap,@v_fn
while @@FETCH_STATUS=0 --desde la posicion 0
begin
	print @v_nom+space(20-len(@v_nom))+@v_ap+space(20-len(@v_ap))+convert(varchar(14),@v_fn,6)--+cast(@v_fn as varchar(14))
	print replicate('-',80)
	fetch c_emple into @v_nom,@v_ap,@v_fn	
end
close c_emple
deallocate c_emple

--Ejemplo 04:Cursor anidado
declare c_lista1 cursor for select IdEmpleado,NomEmpleado,ApeEmpleado from rrhh.empleados
declare @v_nom varchar(max),@v_ap varchar(max), @v_id int --cualquier orden solo tiene que estar las variables
open c_lista1 
fetch c_lista1 into @v_id, @v_nom, @v_ap
while @@FETCH_STATUS=0
begin 
	print 'Empleado: '+@v_nom+space(1)+@v_ap
	print replicate('.',40)
	---------------Cursor anidad--------------------
	declare c_lista2 cursor for select IdPedido,FechaPedido from Ventas.pedidoscabe where IdEmpleado=@v_id
	declare @v_idpe int, @v_fec date --cualquier orden solo tiene que estar las variables
	open c_lista2
	fetch c_lista2 into @v_idpe,@v_fec
	print space(20)+'Id Pedido' + space(20)+'Fecha'
	print space(20)+replicate('=',40)
	while @@FETCH_STATUS=0
	begin
		print space(20)+cast(@v_idpe as varchar(10))+space(20)+convert(varchar (18),@v_fec,6)
		fetch c_lista2 into @v_idpe, @v_fec
	end
	close c_lista2
	deallocate c_lista2
	------------------------------------------------
	fetch c_lista1 into @v_id,@v_nom, @v_ap
end
close c_lista1
deallocate c_lista1

--Cod del profe-------------------------------x
--Ejemplo 04: Cursor anidado

Declare c_lista1 cursor for select IdEmpleado, NomEmpleado, ApeEmpleado from rrhh.empleados

Declare @v_nom varchar(max), @v_ap varchar(max),@v_id int

open c_lista1

fetch c_lista1 into @v_id, @v_nom, @v_ap 

while @@fetch_status = 0

begin

	Print 'Empleado: '+@v_nom+space(1)+@v_ap

	Print replicate('.',40)

	-------------------------Cursor anidado-------------------------------------

	Declare c_lista2 cursor for select IdPedido, FechaPedido from Ventas.pedidoscabe

								where IdEmpleado=@v_id

	Declare @v_idped int, @v_fec date

	open c_lista2

	fetch c_lista2 into @v_idped, @v_fec

	print space(20)+'Id Pedido'+ space(20)+'Fecha'

	print space(20)+replicate('=',40)

	While @@fetch_status = 0

	begin

		print space(20)+cast(@v_idped as varchar(10))+space(20)+convert(varchar(18),@v_fec,6)

		fetch c_lista2 into @v_idped, @v_fec

	end

	close c_lista2

	deallocate c_lista2

	----------------------------------------------------------------------------

	fetch c_lista1 into @v_id, @v_nom, @v_ap

end

close c_lista1

deallocate c_lista1