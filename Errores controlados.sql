use Negocios
go

Begin 
	set dateformat dmy
	declare @v_fechaInicial date='01/01/2020'
	declare @v_fechaFinal date='31/03/2020'
	while @v_fechaInicial<=@v_fechaFinal
	begin
		print format(@v_fechaInicial,'D','en-gb')--la forma de ver una fecha en paises "D" es fecha larga osea mes todo por escrito y con la "d" es con solo numeros 1/5/2020 eso
		set @v_fechaInicial=dateadd(dd,1,@v_fechaInicial)
	end
end;

--TRY/CATCH



set nocount on
begin try 
	delete from Ventas.clientes
	where IdCliente='ALFKI';
end try
begin catch
	print 'No se peude eliminar este cliente por tener pedidos en otra tabla'
	print error_message()
end catch;

--RaisError
begin try
	declare @v_cantidad smallint = 110
	if @v_cantidad>=100
		raiserror('Cantidad Excedida',16,1) --si es leve de 16 para arriba controla con try catch , por lo contrario con este metodo, es leve 16 es el nivel del error
end try
begin catch
	print error_message()
	print 'Controlado por catch'
end catch
-------------------------------------------------
--Trasacciones
begin
	declare @v_id smallint = 2599
	declare @v_nom varchar(50)='Bebidas'
	declare @vt_categ table (nombre varchar(40))
	------------------
	insert @vt_categ
	select NombreCategoria from Compras.categorias
	-----------------
	begin tran t1
	insert into Compras.categorias(IdCategoria,NombreCategoria)
	values(@v_id, @v_nom)
	if @v_nom in(select nombre from @vt_categ)
		rollback tran t1
	else
		commit tran t1
end;
--------------------------------------------
select * from Compras.categorias