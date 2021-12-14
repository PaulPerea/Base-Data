
	--Operadores Matematicos 
	-- + - * / (mod)

	declare @num1 int 
	declare @num2 int

	set @num1 = 10
	set @num2 = 3

	print @num1 + @num2 -- aqui le envias el operador matematico, osea cambias el valor matematico



	--IF
	declare @numero1 int
	declare @numero2 int

	set @numero1 = 10
	set @numero2 = 5

	if @numero1 > @numero2    -- de aqui arranca el codigo de si
	print 'Si es verdad' 
	else 
	print 'No es verdad'


	--WHILE
	declare @cont int
	set @cont = 0

	while(@cont < 10)
	begin																-- Empezar
		print 'Hola soy el número ' + convert(nvarchar(20),@cont)
		set @cont = @cont + 1

	end																	--Terminar


	--Case (switch) || T-SQL
	declare @avion nvarchar(50)
	declare @aviso nvarchar(50)
	declare @estado nvarchar(50)

	set @avion = 'condor'
	set @estado = 'cargando'	--accion donde determina el estado

	set @aviso = (case @estado
				when 'volando' then 'el avion : '+@avion+' esta volando'
				when 'detenido' then 'el avion : '+@avion+' esta detenido'
				when 'cargando' then 'el avion : '+@avion+' esta cargando en este momento'

	end
	)

	print @aviso


	--Try catch  |  t-Sql

	begin try 
		declare @edad int 
		set @edad = 'veinte'
		print @edad

	end try

	begin catch
		print 'Error al leer el numero'
		print error_message()

	end catch

	--cursor
	declare cursore cursor scroll   --scroll significa que puedes elegil la posicion que muestra la data
	for select * from cliente2

	open cursore					--abrir cursor
	fetch first from cursore		--fetch (posicion que deseas) form (el nombre del cursor que le asignaste)

	close cursore					--Cierra este cursor , lo cual puedes abrir otro cursor
	deallocate cursore				--Elimina el cursor del ram

	--Ejemplo de cursor , de como insertar datos a una tabla
	declare @id nvarchar(50)
	declare @nombre nvarchar(50)
	declare @telefono int
	declare @apellido nvarchar(50)

	declare cursore cursor scroll   
	for select * from cliente2

	open cursore					
	fetch first from cursore into @id,@nombre,@telefono,@apellido
		
	while(@@FETCH_STATUS = 0)												--Bucle donde se copiara tabla a tabla
		begin
			insert into Cliente3 values (@id,@nombre,@telefono,@apellido)	--Insertar la informacion de campos de una tabla a otra
			fetch next from cursore into @id,@nombre,@telefono,@apellido	--Luego de llegar un registro , seguir al siguiente casilla para llenar registro
		end

	close cursore					
	deallocate cursore

	delete from Cliente3	 												--Eliminar los registros de una tabla(si deseas de una base de datos)
	go




	--Insertar en la base de datos
	/*
	Vas a donde descargaste el sql server osea aqui "C:\Program Files\Microsoft SQL Server"
	luego buscas el serverd donde quieres guardarlo y luego copias la base de datos aqui MSSQL15.MSSQLSERVER\MSSQL\DATA
	luego te vas al sql de la software y pones click derecho hay y seleccionas attach 
	luego seleccionas add y agregas al base de dato, le poner ok y refrescas la data base
	*/




	--Triggers -- (disipadores)

	create trigger tr_Cliente_2
	on Cliente3

	instead of  insert
	as
	print 'Hubo un cambio en la tabla Cliente3_3';

	insert into Cliente3 values (16,'Josefinacho',48644,'Lech')
	go


	/*
	existen 3 y 3 tipos de triggers son   for  |  after  |  instead of    | insert  |  update  |  delete  

	for sirve para insertar el primer registro y after es para lo que sigue del for, instead of es para ver lo que hay en el 
	print , osea no se guarda lo insertado, solo imprime lo que pusiste,  todo estos ejemplos de hizo con "insert" del segundo grupo
	
	*/



	--Ejemplo de hacer un historial al colocar insert en las tablas
	go
	create trigger TR_persona_insert
	on Cliente3
	for insert 
	as 
	begin
	set nocount on;
	insert into historial(
	nombre,fecha,descri) select nombre2,GETDATE(),'Se inserto datos en la tabla' 
	from inserted
	end

	insert into Cliente3 values(18,'Pepa',484,'paisajajaja')





	--Ejemplo de triggers al eliminar datos
	create trigger Tr_persona_delete
	on Cliente3 instead of delete
	as
	begin 
	set nocount on;
		insert into historial(nombre,fecha,descri)
		select nombre2,GETDATE(),'Se ha eliminado registros de la tabla Cliente3'
	from deleted
	end
	go

	select * from historial
	select * from Cliente3

	delete from Cliente3 where nombre2 = 'Per'

	--Exportar registros a XML
	
	select  * from Cliente3
	for XML raw('Registro'), elements, root('XML') -- Asignas nombre a los titulos
	
	
	--raw, elements , root --por default te viene con nombre pero su estructura es de registor
	
	
	--auto -- Por automatico te coloca todos los registros en xml


	--Insertar datos de una tabla a otra
	 
	 Insert into importe(id,nombre,telefono,apellido)
	 select * from [dbo].[Cliente3]


	 --DateName---

	 --year,month,quarter,dayofyear,day,week,hour etc

	 print DateName(year,getdate()) -- lo que esta en parentesis el primero es el año , el mes o lo que deses que imprima y le segundo es la fecha que nosotros vamos a consultar o convertir+






	 --Para tener una buana cantidad de registros

	 --insert into ejemploData(la tabla) select * from ejemploData(la misma tabla lo que se va a hacer es duplicar los registro)

	 --SELECT count (nombre) from ejemploData  -- lo que hara es contar todos los campos de la tabla nombre y se va a mostrar un numero que imprimira la cantidad

	 select count(nombre2) from Cliente3	--como aqui


	 --Informe de la vistas

	 create view view_Ejemplo as
	 select top 100  id2,nombre2,telefono2,apellido from Cliente3	--selectionar todo lo que ira en la vista  -- es ass es para crear la vista

	 select * from view_Ejemplo	


	 sp_help	--Imprimir toda la db

	 sp_helptext view_Ejemplo		--Imprimir todo el select de la vista determinada

	 sp_depends view_Ejemplo		--Imprimir las dependencias de esta tabla


	 --Como encriptar la vista

	 create view view_Ejemplo_ConCriptacion
	 with encryption as												--se tiene que escribir eso  para la encriptacion de vista
	 select top 100  id2,nombre2,telefono2,apellido from Cliente3	

	 select * from view_Ejemplo_ConCriptacion	


	 sp_help	--Imprimir toda la db

	 sp_helptext view_Ejemplo_ConCriptacion		

	 sp_depends view_Ejemplo_ConCriptacion

	 --store procedure , procedimiento almacenado- parametros de salida

	 create procedure sp_verSalida @num1 float, @num2 float, @resultado float output
	 as 
	 begin
	  set @resultado = @num1 + @num2
	 end 
	 go

	 declare @salida float

	 exec sp_verSalida 20, 13 , @salida output

	 select @salida


	 --Clausula gruop  by

	 select id2,nombre2,apellido ,telefono2		--sum(telefono2) as telefonos
	 from Cliente3-- where nombre2 = 'Per'
	 group by id2,nombre2,apellido
	 
	 /*agrupa a todos los archivos que sean del mismo caracter, y si tiene el mas minimo caracter o otro detalle, este se sale del grupo 
		para armar otro grupo*/

	--Clausula having


	select id2,nombre2+','+apellido as nombres,telefono2		
    from Cliente3
    group by id2,nombre2+','+apellido,telefono2
	having telefono2 > 500000			--Lo que hace es que es igual que un where , que cuando estan agrupados los archivos que muestre los archivos mayores donde esta telefono de  500000
	order by id2
	 

	 --Clausula Exists
	 select p.id2,p.apellido,p.nombre2, p.telefono2 from Cliente3 p
	 where  exists (select * from Cliente2 as C where c.telefono = p.telefono2) -- hace que entre los parametros que insertaste al ultimo , muesten los archivos que son iguales entre una tabla y la otra
																				-- y si quieres ver los que no se repiten entre ellos pones not esists



	--Distinct
	select distinct * from Cliente3 --Hace que los archivos no se repitan o si quieres mas especifico , ponle una columna especifica y pone el distinct



	--Pivot y UnPivot en SQL
	select * from Cliente2
	pivot(

	sum(telefono)
	for nombre in(Jean,Piero,Paul,Puchito,Jeimari)
	) as pvt
	unpivot(
	telefono
	for nombre in(Jean,Piero,Paul,Puchito,Jeimari)
	) as unpvt

	/*El pivot es para agrupar todos las palabras que se repiten y en este caso agrupo y sumo todo los montos que hay en telefono
	y unpivot es para volver a la tabla original, osea la manera de vusializar es todo
	*/


	--Columna calculable con condicional case
	select * from Cliente2

	alter table Cliente2
	add Aprobacion as
	case 
		when id >= 11 then 'Es aprobado'
		else 'Desaprobado'
	end

	






