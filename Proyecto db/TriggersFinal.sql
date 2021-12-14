
	--Triggers --Tablas dependientes
	create trigger tr_guiaRemision
	on guiaRemision
	for insert 

	as 
	begin try
		set nocount on;					
		insert into Historial_db(
		cod,serie,fecha,descripcion) select 0,nroSerieGR,GETDATE(),'Insertando datos a la tabla guiaRemision'
		from inserted
	end try
	begin catch
		print 'Error al leer el numero'
		print error_message()
	end catch
	go



	create trigger tr_vendedor
	on vendedor
	for insert 
	as 

	begin try
		set nocount on;					
		insert into Historial_db(
		cod,serie,fecha,descripcion) select codVend,'null',GETDATE(),'Insertando datos a la tabla vendedor'
		from inserted
	end try
	begin catch
		print 'Error al leer el numero'
		print error_message()
	end catch
	go



	create trigger tr_Cliente
	on Cliente
	for insert 

	as 
	begin try
		set nocount on;					
		insert into Historial_db(
		cod,serie,fecha,descripcion) select codClie,'null',GETDATE(),'Insertando datos a la tabla Cliente'
		from inserted
	end try
	begin catch
		print 'Error al leer el numero'
		print error_message()
	end catch
	go



	create trigger tr_Producto
	on Producto
	for insert 

	as 
	begin try
		set nocount on;					
		insert into Historial_db(
		cod,serie,fecha,descripcion) select codProd,'null',GETDATE(),'Insertando datos a la tabla Producto'
		from inserted
	end try
	begin catch
		print 'Error al leer el numero'
		print error_message()
	end catch
	go



	create trigger tr_FragmentoFactura
	on FragmentoFactura
	for insert 

	as 
	begin try
		set nocount on;					
		insert into Historial_db(
		cod,serie,fecha,descripcion) select codDetProd,'null',GETDATE(),'Insertando datos a la tabla FragmentoFactura'
		from inserted
	end try
	begin catch
		print 'Error al leer el numero'
		print error_message()
	end catch
	go



	create trigger tr_Factura
	on Factura
	for insert 

	as 
	begin try
		set nocount on;					
		insert into Historial_db(
		cod,serie,fecha,descripcion) select 0,nroSerie,GETDATE(),'Insertando datos a la tabla Factura'
		from inserted
	end try
	begin catch
		print 'Error al leer el numero'
		print error_message()
	end catch
	go



--Triggers Eliminacion de Informacion

	create trigger Tr_Cliente_Delete
	on Cliente instead of delete
	as
	begin 
	set nocount on;
		insert into Historial_db(cod,serie,fecha,descripcion)
		select codClie,'null',GETDATE(),'Eliminacion de datos a la tabla Cliente'
	from deleted
	end
	go

	create trigger Tr_guiaRemision_Delete
	on guiaRemision instead of delete
	as
	begin 
	set nocount on;
		insert into Historial_db(cod,serie,fecha,descripcion)
		select 0,nroSerieGR,GETDATE(),'Eliminacion de datos a la tabla guiaRemision'
	from deleted
	end
	go

	
	create trigger Tr_vendedor_Delete
	on vendedor instead of delete
	as
	begin 
	set nocount on;
		insert into Historial_db(cod,serie,fecha,descripcion)
		select codVend,'null',GETDATE(),'Eliminacion de datos a la tabla vendedor'
	from deleted
	end
	go

	create trigger Tr_Producto_Delete
	on Producto instead of delete
	as
	begin 
	set nocount on;
		insert into Historial_db(cod,serie,fecha,descripcion)
		select codProd,'null',GETDATE(),'Eliminacion de datos a la tabla Producto'
	from deleted
	end
	go
	

	create trigger Tr_FragmentoFactura_Delete
	on FragmentoFactura instead of delete
	as
	begin 
	set nocount on;
		insert into Historial_db(cod,serie,fecha,descripcion)
		select codDetProd,'null',GETDATE(),'Eliminacion datos a la tabla FragmentoFactura'
	from deleted
	end
	go

	

	create trigger Tr_Factura_Delete
	on Factura instead of delete
	as
	begin 
	set nocount on;
		insert into Historial_db(cod,serie,fecha,descripcion)
		 select 0,nroSerie,GETDATE(),'Eliminacion de datos a la tabla Factura'
	from deleted
	end
	go

	select * from Historial_db