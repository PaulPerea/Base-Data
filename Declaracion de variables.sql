
select p.IdEmpleado, count(*)[CantidadPedida]
from Ventas.pedidoscabe p
group by p.IdEmpleado
order by 1
go

-----------------
declare @v_cantidadPedidos smallint
declare @v_idEmpleado int = 1
set @v_cantidadPedidos=(select count(*) from Ventas.pedidoscabe
							where IdEmpleado=@v_idEmpleado)
if @v_cantidadPedidos<50
	print 'Este vendedor realizo poco cantidad de pedidos'
else if @v_cantidadPedidos<100
	print 'El venedor hizo regulares cantidad de pedidos'
else
	print 'El vendedor hizo buena cantidad de pedidos'
go
-------------------------------------
--Case
declare @v_nroMsg tinyint = 2
declare @v_txMsg varchar(max)
set @v_txMsg = case @v_nroMsg
				when 1 then 'Hola Mundo'
				when 2 then 'Juntos gobernaremos la galaxia'
				when 3 then 'Únete al lado oscuro'
				else 'Mensaje no implementado'
				end
print @v_txMsg
go

--------------
declare @v_fechaNac date='01/02/2011'
declare @v_etapageneracional varchar(max)
set @v_etapageneracional = case
							when datediff(yy,@v_fechaNac,GETDATE())<1 then 'bebe'
							when datediff(yy,@v_fechaNac,GETDATE())<6 then 'Infante'
							when datediff(yy,@v_fechaNac,GETDATE())<13 then 'Niño'
							when datediff(yy,@v_fechaNac,GETDATE())<15 then 'Puber'
							when datediff(yy,@v_fechaNac,GETDATE())<18 then 'Adolecente'
							when datediff(yy,@v_fechaNac,GETDATE())<30 then 'Joven'
							when datediff(yy,@v_fechaNac,GETDATE())<65 then 'Adulto'
							else 'Adulto Mayor'
							end
print @v_etapageneracional
go

-----------------------------------
select IdPedido,FechaPedido,
		case EnvioPedido
			when 0 then 'Pendiente el envio'
			when 1 then 'Pedido enviado'
			else 'Estado desconocido'
		end as [Estado del Envio]
from Ventas.pedidoscabe;