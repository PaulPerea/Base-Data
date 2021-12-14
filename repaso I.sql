use Negocios
go

--para ver todas las tablas que cree en el sistema
select * from sys.tables
go

--crear una funcion de tabla en linea que devuelva
--los pedidos idpedido,nomclie,nomvende,montofacturado
--generados por un determinado cliente en un determinado año
--el codigo del cliente y el año sera ingresado por parametros
create or alter  function fnrepasolima01(@p_idcliente char(6), @p_año smallint)
returns table
as 
	return(select p.IdPedido,c.NomCliente,p.FechaPedido,e.NomEmpleado + space(1)+e.ApeEmpleado Empleado,
					sum((d.Cantidad*d.PrecioUnidad)*(1- d.Descuento)) [Total facturado]
					from Ventas.pedidoscabe P join ventas.clientes C on p.IdCliente=c.IdCliente
											join rrhh.empleados e on p.IdEmpleado=e.IdEmpleado 
											join Ventas.pedidosdeta d on p.IdPedido=d.IdPedido
					where year(p.FechaPedido)=@p_año and p.IdCliente=@p_idcliente
	group by p.IdPedido,c.NomCliente,p.FechaPedido,e.NomEmpleado + space(1)+e.ApeEmpleado)
go

select * from fnrepasolima01('ALFKI',1996)

select * from Ventas.pedidoscabe

--Elabore un sp que reciba 2 parametros (idcliente año) que ejecute la funcion creada anteriormente
--debera validar en caso no tenga registros.

create or alter procedure usprepaso02lima
@p_idcliente char(6),
@p_año	smallint
as
begin
	if exists(select * from Ventas.pedidoscabe where IdCliente=@p_idcliente and year(FechaPedido)=@p_año)
		select * from fnrepasolima01(@p_idcliente,@p_año)
	else 
		raiserror('No hay registros para es consulta',10,1)

end
go