--Consultar	datos de la tabla Clientes
select * from Ventas.clientes
go

--Delete 
delete from ventas.clientes
where IdCliente  like 'C0'
go

select * from Ventas.clientes
go

--Truncate Table

create table consumer

(

id			int identity,

fullname	varchar(100)

)

go



------------------------

Select * from consumer

go



---------------------------------------

Insert consumer

select NomCliente from Ventas.clientes

go



---Eliminar todos los registros

Truncate Table consumer

go



--------------------------------

Select * from consumer

go



---------------------------------------

Insert consumer

select NomCliente from Ventas.clientes

go



--------------------------------

Select * from consumer

go



----Eliminar con Delete

Delete from consumer

go



--------------------------------

Select * from consumer

go



---------------------------------------

Insert consumer

select NomCliente from Ventas.clientes

go



--------------------------------

Select * from consumer

go


------------
--Update 
------
select * from ventas.clientes
go

--Actualizando datos del clientes CACTU
update ventas.clientes
set NomCliente='Los 4 sabores',
	DirCliente='Av Tinoco 222',
	fonoCliente='(51)3546789'
where IdCliente='CACTU'
go
--Incrementar 10% los productos suministrados por proveedores de colombia
select * from compras.productos
go
select * from Compras.proveedores
go
select * from Ventas.paises
go

--Solucion (subConsultas)
update compras.productos
set PrecioUnidad=PrecioUnidad*1.10
where IdProveedor in (select IdProveedor from Compras.proveedores
						where idpais in (select idpais from Ventas.paises
										where NombrePais='Colombia'))
go

--Solucion(Join)
update Compras.productos
set PrecioUnidad=PrecioUnidad*1.10
from Compras.productos P join Compras.proveedores S
	on P.IdProveedor=S.IdProveedor join Ventas.paises C
	on S.idpais=C.Idpais
where C.NombrePais='Colombia'
go


-----------------
--Merge
create table dbo.paiseselaboracion(
id	char(3) not null,
nombre	varchar(100)
)


--------------------------
select * from Ventas.paises
go

insert dbo.paiseselaboracion
values
('003','Bolivia'),
('009','Jamaica'),
('012','Uruguay')
go


--------------------------------------
select * from Ventas.paises
go

select * from dbo.paiseselaboracion

--------------------------------------


--Sincronizar
merge into Ventas.paises as target
using (select id,nombre from dbo.paiseselaboracion) as source(id, nom)
on target.idpais=source.id
when matched then update set target.nombrepais=source.nom
when not matched then insert values(source.id, source.nom);
go
				

