use Negocios
go

insert into Compras.categorias
(IdCategoria,NombreCategoria)
values
('99','Cereales')
go

select * from Compras.categorias
go

-----------------------
insert Compras.categorias
select CategoryID + 100,CategoryName,Description 
from Northwind.dbo.Categories


---------------
bulk insert Ventas.Clientes
from 'C:\Data\Clientes.txt'
with(fieldterminator=',',
	 rowterminator='\n')
go
--------------------------
select * from ventas.clientes
--------------------------

delete from Ventas.Clientes
where IdCliente like 'C0%'
go