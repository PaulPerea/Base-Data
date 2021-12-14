use Negocios
go

select * from sys.triggers --Para ver si tengo al menos 1 trigger
go

create or alter trigger tr_categoria
on compras.categorias
for insert, delete , update
as
begin
	print 'Ha realizado una operacion...'

end
go

select * from Compras.categorias
go


------------------
--insert 
insert into compras.categorias
values
(777,'Granitos','Granitos Andinos')
go

--update 
update compras.categorias
set	NombreCategoria='Quinua'
where IdCategoria=777
go

select * from Compras.categorias
go

--Delete
delete from Compras.categorias
where IdCategoria=777
go

-----tablas inserted y deleted---
create or alter trigger tr_cargo	
on rrhh.cargos
after insert , update ,delete
as 
begin
	select * from inserted
	select * from deleted

end
go
--
set nocount on
go
--------------
select * from RRHH.Cargos
go

--insert
insert into RRHH.Cargos
values
(10,'Analista de Datos')
go

--update 
update RRHH.Cargos
set desCargo='Developer JR'
where idcargo=10
go

--eliminacion
delete from RRHH.Cargos
where idcargo=10
go
