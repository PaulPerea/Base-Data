use Negocios 
go

create or alter function dbo.fnPrecioPromedio() --sin parametros
returns smallmoney --esto es para declarar
as
begin
	declare @pp smallmoney
	set @pp = (select AVG(PrecioUnidad) from Compras.productos) 
	return @pp --return para retornar
	
end
go
-----------------------------------------
begin
	print 'El precio promedio de los productos es: ' + format(dbo.fnPrecioPromedio(),'C','en-us')
end
go

---------------------------
--Funcion escalar con parametros
---------------------------
create or alter function dbo.fnObtCantidadPC(@p_idcat int ) --Producto por categoria
returns int 
as
begin
	declare @cantidad int 
	set @cantidad = (select count(*) from Compras.productos where IdCategoria=@p_idcat)
	return @cantidad
end
go

----------------------
create or alter function dbo.fnPrecioCaro(@p_idcat int)
returns smallmoney
as 
begin 
	declare @pc smallmoney
	set @pc=(select max(PrecioUnidad) from Compras.productos
					where IdCategoria=@p_idcat)
	return @pc
end
go

----------------------------
create or alter function dbo.fnTotalStock(@p_idcat int)
returns smallint
as
begin
	declare @stock smallint
	set	@stock=(select sum(UnidadesEnExistencia) from Compras.productos
					where IdCategoria=@p_idcat)
	return @stock
end
go

-----------------------------------
create or alter function dbo.fnPP(@p_idcat int)
returns smallmoney
as
begin
	declare @promedio smallmoney
	set @promedio=(select AVG(PrecioUnidad) from Compras.productos
					where IdCategoria=@p_idcat)
	return @promedio
end
go

---------------------------------
create or alter function dbo.fnFacturadoCat(@p_idcat int)
returns smallmoney
as
begin
	declare @tf smallmoney
	set @tf = (select sum((d.Cantidad * d.PrecioUnidad) * (1-d.Descuento)) from Compras.productos p 
			join ventas.pedidosdeta d on p.IdProducto=d.IdProducto
			where p.IdCategoria=@p_idcat)
	return @tf
end
go

create or alter function dbo.FnFacturadocat (@p_idcat int)
returns money
as
begin
	declare @tf money
	set @tf = (select sum((d.Cantidad * d.PrecioUnidad)*(1-d.Descuento)) from Compras.productos p join Ventas.pedidosdeta d
			on p.IdProducto=d.IdProducto 
			where p.IdCategoria = @p_idcat)
			return @tf
end
go
--usar las funciones
select NombreCategoria,dbo.fnObtCantidadPC(IdCategoria) 'Cantidad de Productos',
dbo.fnPrecioCaro(IdCategoria) 'Precio Caro',
dbo.fnTotalStock(IdCategoria) 'Total Stock',
dbo.fnPP(IdCategoria) 'Precio Promedio',
dbo.FnFacturadocat(IdCategoria) 'Total Facturado'
from Compras.categorias


--profe
Select NombreCategoria,dbo.FnObtCantidadPc(IdCategoria) 'Cantidad de Productos', 

dbo.fnPrecioCaro(IdCategoria) 'Precio Caro',

dbo.fnTotalStock(IdCategoria) 'Total Stock',

dbo.fnPP(IdCategoria) 'Precio Promedio',

dbo.FnFacturadocat(IdCategoria) 'Total Facturado'

from compras.categorias

-------------------------------------

--Funcion escalar con parametros

-------------------------------------



create or alter function dbo.FnObtCantidadPc(@p_idcat int)

returns int

as

begin

	declare @cantidad int 

	set @cantidad = (select count (*) from Compras.productos

				where IdCategoria = @p_idcat)

				return @cantidad

end

go

-----------------------------------

create or alter function dbo.FnPrecioCaro(@p_idcat int)

returns smallmoney

as

begin

	declare @pc smallmoney 

	set @pc = (select max (PrecioUnidad) from Compras.productos 

			where IdCategoria = @p_idcat)

		return @pc

end

go

------------------------------------

create or alter function dbo.FnTotalStock(@p_idcat int)

returns smallint

as

begin

	declare @stock smallint

	set @stock = (select sum(UnidadesEnExistencia) from Compras.productos

				where IdCategoria = @p_idcat)

				return @stock

end

go

-------------------------------------

create or alter function dbo.FnPP(@p_idcat int)

returns smallmoney

as

begin

	declare @promedio smallmoney

	set @promedio = (select AVG(PrecioUnidad) from Compras.productos

					where IdCategoria = @p_idcat)

					return @promedio

end

go

--------------------------------------

create or alter function dbo.FnFacturadocat (@p_idcat int)

returns money

as

begin

	declare @tf money

	set @tf = (select sum((d.Cantidad * d.PrecioUnidad)*(1-d.Descuento)) from Compras.productos p join Ventas.pedidosdeta d

			on p.IdProducto=d.IdProducto 

			where p.IdCategoria = @p_idcat)

			return @tf

end

go

Select NombreCategoria,dbo.FnObtCantidadPc(IdCategoria) 'Cantidad de Productos', 

dbo.FnPrecioCaro(IdCategoria) 'Precio Caro',

dbo.FnTotalStock(IdCategoria) 'Total Stock',

dbo.FnPP(IdCategoria) 'Precio Promedio',

dbo.FnFacturadocat(IdCategoria) 'Total Facturado'

from compras.categorias