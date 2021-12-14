--Funciones definidas por el usuario
--tipo 2 funciones de tabla en linea
use Negocios
go

create or alter function dbo.fntablalima001(@p_idcategoria int)
returns table
as
	return(select p.NomProducto,s.NomProveedor,c.NombreCategoria,p.PrecioUnidad from Compras.productos p join Compras.categorias c on p.IdCategoria=c.IdCategoria
												join Compras.proveedores s on p.IdProveedor=s.IdProveedor 
												where p.IdCategoria=@p_idcategoria)
go

--usar la funcion como una consulta
select * from dbo.fntablalima001(3)
go

--crear una funcion de tabla en linea que reciba el parametro el nombre de un pais y devuelva los datos de los clientes de ese pais

create or alter function dbo.fntablalima002(@p_pais varchar(50))
returns table
as
	return(select c.NomCliente,c.DirCliente,p.NombrePais from ventas.clientes c join Ventas.paises p
						on c.idpais=p.Idpais where p.NombrePais=@p_pais)

go

select * from dbo.fntablalima002('Peru')
go

--Tipo 3 : Funsiones Multisentencias
create or alter function dbo.fnmultilima001(@p_idcliente varchar(6))
returns @tabla table (nropedido int, 
						fehcapedido varchar(30))
as 
begin
	insert into @tabla
	select IdPedido,format(FechaPedido,'D','es-pe') from Ventas.pedidoscabe where IdCliente=@p_idcliente
	return
end
go

select * from dbo.fnmultilima001('ALFKI')
go

--Crear una funcion de multisentencia que reciba como parametro el año de pedido
--luego muestre el nombre del cliente y la cantidad de pedido que hizo cada 
--cliente en dicho año del parametro
create or alter function dbo.fnmultilima002(@p_año smallint)
returns @tablita table(nombreCliente varchar(50), cantidadPedido int)

as 
begin
	insert into @tablita
	select c.NomCliente,count(p.IdPedido) from Ventas.clientes c join Ventas.pedidoscabe p  on c.IdCliente=p.IdCliente
	where year(p.FechaPedido) = @p_año
	group by c.NomCliente
	return

end
go

select * from dbo.fnmultilima002(1998
go