go Negocios
go

--SP que consulta empleados
create or alter procedure usLimaQEmpleado
as 
begin
	select e.IdEmpleado [ID del Empleado],
			e.NomEmpleado+space(1)+e.ApeEmpleado [Empleado],
			datediff(yy,e.FecNac,GETDATE()) [Edad],
			e.DirEmpleado [Dirección],
			d.nomDistrito [Distrito],
			c.desCargo [Cargo],
			DATEDIFF(yy,e.FecContrata,GETDATE()) [Años de servicio] --Datediff (año, ente , hasta ahora)
	from RRHH.empleados e join RRHH.Distritos D on e.idDistrito=d.idDistrito join 
	RRHH.Cargos c on e.idCargo=c.idcargo
end 
go

--Sp que consulta clientes
create or alter procedure uspLimaQCliente
as
begin
	select c.IdCliente	[Id del Estudiante],
			c.NomCliente [Cliente],
			c.DirCliente [Direccion del cliente],
			p.NombrePais [Pais de residiencia],
			c.fonoCliente [Telefono del cliente]
	from Ventas.clientes c join Ventas.paises p
	on c.idpais=p.Idpais

end
go

--SP que consulta productos
create or alter procedure uspLimaQProducto
as 
begin
	select p.IdProducto [ID PRODUCTO], 
			p.NomProducto [Nombre del producto],
			s.NomProveedor [nombre del proveedor],
			c.NombreCategoria [Nombre de categoria],
			p.PrecioUnidad [Precio unitario],
			case 
				when p.UnidadesEnExistencia<=0 then 'Sin Stock' --then = entonces
				else cast(p.UnidadesEnExistencia as varchar(15))
			end as [Stock]
	from Compras.productos p join Compras.proveedores s 
	on p.IdProveedor=s.IdProveedor join Compras.categorias c
	on p.IdCategoria=c.IdCategoria

end
go

-----------------------
--Procedimiento principal de consulta
create or alter procedure uspLimaQuery
@p_entidadConsultar varchar(max)
as 
begin 
	if upper(@p_entidadConsultar) = 'CLIENTE'
		execute uspLimaQCliente
	else if upper (@p_entidadConsultar) = 'EMPLEADO'
		execute usLimaQEmpleado
	else if upper(@p_entidadConsultar) = 'PRODUCTO'
		execute uspLimaQProducto
	else 
		raiserror('Consulta de entidad no implementada',10,1)

end
go

--Ejecutar
execute uspLimaQuery 'Cliente';

