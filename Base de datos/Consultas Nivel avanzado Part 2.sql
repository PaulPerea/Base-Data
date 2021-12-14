use Negocios
go

-----Combinacion de tablas
--Join
select PD.NomProducto,
		PD.PrecioUnidad,
		CA.NombreCategoria
from Compras.productos PD join Compras.proveedores PV
on PD.IdProveedor = PV.IdProveedor join Compras.categorias CA
on PD.IdCategoria = CA.IdCategoria
go
--Se recomienda utilizar de este modo por que cuando tienen una enorme cantidad de datos

select NomProducto ,IdProveedor,IdCategoria from Compras.productos

select NomProveedor,IdProveedor from compras.proveedores

select IdCategoria from Compras.categorias

--usando where (No recomendado) --Se recomienda cuando tienes pocos datos

select PD.NomProducto,
		PD.PrecioUnidad,
		CA.NombreCategoria
from Compras.productos PD, Compras.proveedores PV ,Compras.categorias CA
where  PD.IdProveedor = PV.IdProveedor and PD.IdCategoria = CA.IdCategoria
go

--Inner Join --Combinacion interna
select PD.NomProducto, PD.PrecioUnidad, PV.NomProveedor
from Compras.productos PD inner join Compras.proveedores PV
on PD.IdProveedor=PV.IdProveedor;

select distinct PV.NomProveedor
from Compras.productos PD inner join Compras.proveedores PV
on  PD.IdProveedor = PV.IdProveedor;

select * from Compras.proveedores

---------------------------------------
select PD.NomProducto,
		PD.PrecioUnidad,
		PV.NomProveedor,
		CA.NombreCategoria
from Compras.productos PD inner join Compras.proveedores PV
on PD.IdProveedor=PV.IdProveedor inner join Compras.categorias CA
on PD.IdCategoria=CA.IdCategoria;

--Combinacion Externa--
--Left join 
select c.*,p.*
from Ventas.clientes c left join Ventas.pedidoscabe p
on C.IdCliente=p.IdCliente

--Clientes que nunca han hecho pedidos
select c.*,p.*
from Ventas.clientes c left join Ventas.pedidoscabe p
on C.IdCliente=p.IdCliente
where p.IdPedido is null;

--Insertemos un par de nuevos clientes
--Insertemos un par de nuevos Pedidos

Insert Ventas.pedidoscabe
Values
('9999',Null,Null,getdate(),Getdate()+1,Getdate()+3,0,30,'Tortugas Restau','Las Gacelas 111','Lima',null,'1734','Peru'),
('8888',Null,Null,getdate(),Getdate()+1,Getdate()+3,0,30,'Popeyes Restau','Los Galgos 111','Comas',null,'1731','Peru')
go

--Right join 
select c.*,p.*
from Ventas.clientes c right join Ventas.pedidoscabe p
on C.IdCliente=p.IdCliente

select p.IdPedido, 
		c.IdCliente,
		c.NomCliente
from ventas.clientes c right join Ventas.pedidoscabe P
ON C.IdCliente=p.IdCliente
where p.IdCliente is null;

--Full join --mostara todo lo que le pidas
select c.*,p.*
from Ventas.clientes c full join Ventas.pedidoscabe p
on C.IdCliente=p.IdCliente

--Cross join --combinacion crusada
select p.NomProducto from Compras.productos P

select A.NomProveedor from Compras.proveedores A

select p.NomProducto , A.NomProveedor, '________________' as [SI/NO]
from Compras.productos P cross join Compras.proveedores A