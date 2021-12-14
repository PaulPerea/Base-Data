use Negocios;

create or alter procedure uspcursorLimaCentro
@p_idcli char(6)
as
begin 
	if exists(select IdCliente from Ventas.pedidoscabe where IdCliente=@p_idcli)
	begin
		declare cursorclientevtas cursor for select IdPedido,FechaPedido from ventas.pedidoscabe
													where IdCliente=@p_idcli
		declare @v_idped int, @v_fecped date
		open cursorclientevtas
		fetch cursorclientevtas into @v_idped,@v_fecped
		------------------------------------------
		print space(5)+'Pedido'+space(10)+'Fecha'
		print replicate('=',50)
		----------------------------------
		while @@FETCH_STATUS=0
		begin
			print space(5)+cast(@v_idped as varchar(6))+space(10)+convert(varchar(14),@v_fecped,4)
			fetch cursorclientevtas into @v_idped,@v_fecped
		end
			raiserror('codigo no existe',10,1)
	end

	close cursorclientevtas
	deallocate cursorclientevtas
end
go

drop procedure  uspcursorLimaCentro
----------------------------
select * from ventas.pedidoscabe
execute uspcursorLimaCentro '';

---------------------------------------------------
--Del profe 
Create or alter procedure uspcursorLimaCentro

@p_idcli char(6)

As

Begin

	if exists(select * from Ventas.pedidoscabe where IdCliente=@p_idcli)

		begin

			declare cursorclientevtas cursor for select IdPedido, FechaPedido from ventas.pedidoscabe

										where IdCliente=@p_idcli

			declare @v_idped int,@v_fecped date

			open cursorclientevtas

			fetch cursorclientevtas into @v_idped, @v_fecped

			-----------------------------------------------------------------

			print space(5)+'Pedido'+space(10)+'Fecha'

			print replicate('=',50)

			-----------------------------------------------------------------

			While @@fetch_status =0

			begin

				print space(5)+cast(@v_idped as varchar(6))+space(10)+convert(varchar(14),@v_fecped,6)
				
				fetch cursorclientevtas into @v_idped, @v_fecped

			end

			close cursorclientevtas

			deallocate cursorclientevtas

		end

	else

		raiserror('El id_cliente solicitado no registra ningun pedido',10,1)

End;

go

---------------------------------
--procedimiento con transacciones
--primero crear sp que registre nuevo cliente
create or alter procedure uspregistracliente
@p_IdCliente char(5),
@p_NomCliente varchar(40),
@p_DirCliente varchar(60),
@p_idpais char(3),
@p_fonoCliente varchar(25)
as 
begin 
	insert into ventas.clientes
	values
	(@p_IdCliente,@p_NomCliente,@p_DirCliente,@p_idpais,@p_fonoCliente)

end
go

--ahora realiza el sp con transacciones y con exepcion de errores
create or alter procedure usptracliente
@p_IdCliente char(5),
@p_NomCliente varchar(40),
@p_DirCliente varchar(60),
@p_idpais char(3),
@p_fonoCliente varchar(25)
as 
begin
	begin try
	begin Tran t1
		execute uspregistracliente @p_IdCliente,@p_NomCliente,@p_DirCliente,@p_idpais,@p_fonoCliente
		if @p_idpais <> '002'
			commit tran t1
		else
			raiserror('id de pais no permitido',16,1)
	end try
	begin catch
		rollback tran t1
		print error_message()
	end catch
end
go


execute usptracliente 'JANAT','JAVICHIN BURGER','PSJ ROSA MELANINO','002','55555'
SELECT * FROM Ventas.clientes