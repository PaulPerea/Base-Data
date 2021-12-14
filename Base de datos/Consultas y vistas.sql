use Negocios
go

select	NomCliente as Dato,
	'Cliente' as TipoInvitado
from Ventas.clientes
	union 
select NomProveedor as Dato,
	'Proveedor' as TipoInvitado -- proveedor lo pone para saber si es provedor o es otro tipo de invitado
from Compras.proveedores
	union
select NomEmpleado + space(1) + ApeEmpleado as Dato, --space(1) es para el salto de espacio la cantidad, y le concatenas el apellido
	'Empleado' as TipoInvitado
from rrhh.empleados e;
----------------------------------
--Consulta con grup by
select YEAR(P.FechaPedido) [Año],
		E.NomEmpleado + space(1) + E.ApeEmpleado [Empleado],
		C.NomCliente [Cliente],
		sum((d.Cantidad * d.PrecioUnidad) * (1-d.Descuento)) [MontoVenta]
from rrhh.empleados e join Ventas.pedidoscabe p
on e.IdEmpleado=p.IdEmpleado join Ventas.clientes c
on p.IdCliente=c.IdCliente join Ventas.pedidosdeta d
on p.IdPedido=d.IdPedido
group by YEAR(P.FechaPedido),E.NomEmpleado + space(1) + E.ApeEmpleado,C.NomCliente;

--Consultas agrupadas usnado cube

select YEAR(P.FechaPedido) [Año],
		E.NomEmpleado + space(1) + E.ApeEmpleado [Empleado],
		C.NomCliente [Cliente],
		sum((d.Cantidad * d.PrecioUnidad) * (1-d.Descuento)) [MontoVenta]
from rrhh.empleados e join Ventas.pedidoscabe p
on e.IdEmpleado=p.IdEmpleado join Ventas.clientes c
on p.IdCliente=c.IdCliente join Ventas.pedidosdeta d
on p.IdPedido=d.IdPedido
group by cube (YEAR(P.FechaPedido),E.NomEmpleado + space(1) + E.ApeEmpleado,C.NomCliente);

--Consultas agrupadas usnado rollup
select YEAR(P.FechaPedido) [Año],
		E.NomEmpleado + space(1) + E.ApeEmpleado [Empleado],
		C.NomCliente [Cliente],
		sum((d.Cantidad * d.PrecioUnidad) * (1-d.Descuento)) [MontoVenta]
from rrhh.empleados e join Ventas.pedidoscabe p
on e.IdEmpleado=p.IdEmpleado join Ventas.clientes c
on p.IdCliente=c.IdCliente join Ventas.pedidosdeta d
on p.IdPedido=d.IdPedido
group by Rollup (YEAR(P.FechaPedido),E.NomEmpleado + space(1) + E.ApeEmpleado,C.NomCliente);

--Consultas agrupadas usnado rollup
select isnull(str(year(p.FechaPedido)),'Total-----')[Año],
		isnull(e.NomEmpleado + space(1) + e.ApeEmpleado , '_______________')[Empleado],
		isnull(c.NomCliente, '_________________')[Cliente],
		sum((d.Cantidad * d.PrecioUnidad) * (1-d.Descuento)) [MontoVenta]
from rrhh.empleados e join Ventas.pedidoscabe p
on e.IdEmpleado=p.IdEmpleado join Ventas.clientes c
on p.IdCliente=c.IdCliente join Ventas.pedidosdeta d
on p.IdPedido=d.IdPedido
group by Rollup (YEAR(P.FechaPedido),E.NomEmpleado + space(1) + E.ApeEmpleado,C.NomCliente);


--- Programacion T-SQL--
--Variables globales
select @@version as [Version sql server];

select @@SERVERNAME as [server], @@SERVICENAME as [Servicio sql];

select @@LANGUAGE as [lenguaje];

--Variables Locales
begin
	declare @v_cantidad smallint
	set @v_cantidad = 50
	select * from Compras.productos
	where UnidadesEnExistencia>@v_cantidad
end;

