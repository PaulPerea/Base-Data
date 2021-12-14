use Negocios
go

select c.NomCliente,
		replace(trim(upper(reverse(c.NomCliente))),' ' ,'') [Reverse] --Upper es que muestra en todo mayus -- el replace es para que todo lo que pones sea remplazado por lo que coloques
from Ventas.clientes c

--Format (valor (date,numeric), formato idioma y codigo de pais)

select e.ApeEmpleado,
		e.FecNac,
		FORMAT(e.FecNac,'D','en-gb') [Fecha por formato],
		FORMAT(e.FecNac,'D','fr-fr') [Fecha por formato, francia]
from rrhh.empleados e
go
--------------------------------------------
select p.NomProducto,
		p.PrecioUnidad,
		format(p.PrecioUnidad, 'C', 'en-PE')
from Compras.productos p
go

--Funciones definidas por el usuario
--funcion escalar
--crear la funcion escalar
create or alter function dbo.fnlima001()
returns decimal
as
begin
	declare @v_retorno decimal
	set @v_retorno=(select avg(PrecioUnidad) from Compras.productos)
	return @v_retorno

end
go
---------------------
select 'El precio promedio de productos es ' + FORMAT(dbo.fnlima001(),'c','es-pe')
go
