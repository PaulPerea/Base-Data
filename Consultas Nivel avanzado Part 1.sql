use Negocios
go

select 'Hello World' as [Mensaje]
go

select * from Ventas.clientes
go

select IdCliente as [ID del Cliente],NomCliente as [Nombre del Cliente],DirCliente as [Dirección del Cliente] from Ventas.clientes
go

--Order By
select * from Compras.productos
order by IdCategoria asc, IdProducto desc, NomProducto asc
go

--Predicado All
select all * from Compras.productos
go

--Predicado TOP
select top 5 *
from Compras.productos
order by PrecioUnidad desc
go

--Predicado Distinct
select distinct C.NombreCategoria
from Compras.productos P join Compras.categorias C
on P.IdCategoria=C.IdCategoria
go

--Operadores de compración 
select *
from Compras.productos
where PrecioUnidad < 20
go

select *
from Compras.productos
where PrecioUnidad = 20
go

select *
from Compras.productos
where PrecioUnidad > 35
go

select *
from Compras.productos
where PrecioUnidad <> 13 --el <> significa , diferente que
go

select *
from Compras.productos
where PrecioUnidad != 13 --es lo mismo que <>
go
----------------------------------------
select * 
from Compras.productos
where IdCategoria=1 and PrecioUnidad<=30
go

------------------------------------------
select * from Compras.productos
where PrecioUnidad between 20 and 30 --Mostrar las listas que enten en preciounidad de 20 hast 30
go

select * from Compras.productos
where PrecioUnidad not between 20 and 30 --Mostrar las listas que no enten en preciounidad de 20 hast 30
go

--IN
select * from Compras.productos
where IdCategoria in (1,3,5) --Todos los productos menos 1 3 5
order by IdCategoria asc
go

select * from Compras.productos
where IdCategoria not in (1,3,5) --Todos los productos menos 1 3 5
order by IdCategoria asc
go

--LIKE
select * 
from Ventas.clientes
where NomCliente like 'P%' --Que inicien con la letra P
go

select * 
from Ventas.clientes
where NomCliente not like '[A-C]%' --Que NO inicien con la letra A Y B Y  C
go

select * 
from Ventas.clientes
where NomCliente like '[^A-C]%' --Que NO inicien con la letra A Y B Y  C es lo mismo de arriba solo le agregas a ^
go
