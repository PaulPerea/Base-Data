/*
semena 13
viernes 18 junio
*/

select * from sys.procedures
go

--Otra forma
select * from sys.objects where type in('P','V')
GO

--Mostrar los codigos
select so.name, so.type_desc, sc.text
from sys.objects as so
join sys.syscomments as sc on so.object_id = sc.id
where type in ('P','V')
go


















Create Procedure Registrar
(
	@codCli varchar(20),@nomCli varchar(20), @dirCli	varchar(20),@ciudad varchar(20),@pais varchar(20)
)
as 
insert into Clientes(codCli,nomCli,dirCli,ciudad,pais) values( @codCli,@nomCli,@dirCli,@ciudad,@pais )

exec Registrar 'ALPLL','AUTON','Forsterstr. 57','Madrid','Spain'


create procedure Actualizar2
(
	@codCli varchar(20),
	@nomCli varchar(20), 
	@dirCli	varchar(20),
	@ciudad varchar(20),
	@pais varchar(20)
)
as
begin
update Clientes
	set	codCli = @codCli,
		nomCli = @nomCli,
		dirCli = @dirCli,
		ciudad = @ciudad,
		pais = @pais

	where codCli = @codCli
end

exec Actualizar2 'ALPLL','AUTON','Forsterstr. 666','Madrid','Spain'


create procedure Eliminar 
 @codCli varchar(20)
 as
 begin 
	delete from Clientes where codCli = @codCli
end

exec Eliminar  'ALPLL'



SELECT * FROM Clientes




create procedure top3
(
@pais varchar(20)
)
as 
begin 
	select  top(3) * from Clientes where pais = @pais order by nomCli


end

execute top3 'Mexico'






SELECT dbo.Pedido.fechaPedido, dbo.PedidoDetalle.cantidad, dbo.Productos.nomPro
FROM     dbo.Pedido INNER JOIN
                  dbo.PedidoDetalle ON dbo.Pedido.nroPed = dbo.PedidoDetalle.nroPed INNER JOIN
                  dbo.Productos ON dbo.PedidoDetalle.codPro = dbo.Productos.codPro
WHERE  (dbo.Pedido.fechaPedido  LIKE '%-07-%') 
order by dbo.Productos.nomPro






SELECT dbo.Pedido.fechaPedido, dbo.PedidoDetalle.cantidad, dbo.Productos.nomPro
FROM     dbo.Pedido INNER JOIN
                  dbo.PedidoDetalle ON dbo.Pedido.nroPed = dbo.PedidoDetalle.nroPed INNER JOIN
                  dbo.Productos ON dbo.PedidoDetalle.codPro = dbo.Productos.codPro
WHERE  (dbo.Pedido.fechaPedido > CONVERT(DATETIME, '1996-06-04 00:00:00', 102)) AND (dbo.Pedido.fechaPedido < CONVERT(DATETIME, '1996-08-01 00:00:00', 102))

order by dbo.Productos.nomPro



















create procedure Importe (
@anioP datetime,@codProd int

)
as 
begin 
	select * from dbo.Pedido INNER JOIN
                  dbo.PedidoDetalle ON dbo.Pedido.nroPed = dbo.PedidoDetalle.nroPed INNER JOIN
                  dbo.Clientes ON dbo.Pedido.codCli = dbo.Clientes.codCli INNER JOIN
                  dbo.Productos ON dbo.PedidoDetalle.codPro = dbo.Productos.codPro


	where   (dbo.Pedido.fechaPedido = @anioP) AND (dbo.PedidoDetalle.codPro = @codProd)

end
go

execute Importe '1996-07-04 00:00:00.000',  2





SELECT TOP (100) PERCENT dbo.Clientes.codCli AS Expr1, dbo.Pedido.nroPed, dbo.Pedido.codCli, dbo.Pedido.codEmp, dbo.Pedido.fechaPedido, dbo.Pedido.codTran, dbo.Pedido.flete, dbo.Pedido.total, dbo.Pedido.codCli AS Expr2, 
                  dbo.Productos.nomPro, dbo.Clientes.nomCli, dbo.Productos.codCate, dbo.Productos.codPro
FROM     dbo.Clientes INNER JOIN
                  dbo.Pedido ON dbo.Clientes.codCli = dbo.Pedido.codCli CROSS JOIN
                  dbo.Productos
ORDER BY dbo.Pedido.fechaPedido, dbo.Productos.codPro