use Negocios

go



--usp para Ingresar Categorias

create or alter procedure uspInCat

@p_idcat	numeric,

@p_nomcat	varchar(50),

@p_descrip	varchar(max)

As

Begin

	insert into Compras.categorias

	values

	(@p_idcat,@p_nomcat,@p_descrip)

End

go



-----------------------------------

create or alter procedure uspAcCat

@p_idcat	numeric,

@p_nomcat	varchar(50),

@p_descrip	varchar(max)

as

Begin

	update Compras.categorias

	set	NombreCategoria=@p_nomcat,

		Descripcion=@p_descrip

	where IdCategoria=@p_idcat

End

go



------------------------------------

--Procedimiento que invoca a los anteriores según opción elegida

Create or alter procedure uspTransaCat

@p_tipotran tinyint,

@p_idcat	numeric,

@p_nomcat	varchar(50),

@p_descrip	varchar(max)

As 

Begin

	If @p_tipotran=1 ---Transacción de registro

		Begin

			If not exists(Select * from compras.categorias where IdCategoria=@p_idcat)

				execute uspInCat @p_idcat,@p_nomcat, @p_descrip 

			else

				raiserror('Id de categoría ya existe...',10,1)

		end

	If @p_tipotran=2 ---Transacción de actualización

		Begin

			If exists(Select * from compras.categorias where IdCategoria=@p_idcat)

				Begin

					if @p_nomcat is null

						set @p_nomcat=(Select NombreCategoria from Compras.categorias 

										where IdCategoria=@p_idcat)

					if @p_descrip is null

						set @p_descrip=(Select Descripcion from Compras.categorias 

										where IdCategoria=@p_idcat)

					execute uspAcCat @p_idcat,@p_nomcat, @p_descrip 

				End

			else

				RaisError('El id de categoria no existe',10,1)

		End

End

go



--------------------------------

select * from Compras.categorias



------Ejecutar------

--Insertar

execute uspTransaCat '1','55','Frutas','Dulces Sanos'

go



--Actualizar

execute usptransaCat '2','55', null,'Sportacus Alimento Sano'

go