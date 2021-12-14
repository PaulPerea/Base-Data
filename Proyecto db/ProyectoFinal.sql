

	use Proyecto
	go

	--Insertando Tablas

	
	create table registroAnual(
	año int not null ,
	mes nvarchar(15),
	idCliente int not null,
	monto float not null,

	foreign key (idCliente) references Cliente (codClie)

	)


	create table guiaRemision(
	nroSerieGR nvarchar(50) unique  not null,
	nroGuiaRemi int  not null,

	primary key(nroSerieGR)
	)
	go



	create table vendedor(
	codVend int unique not null,
	nombVend nvarchar(50) not null,

	primary key(codVend)
	)
	go


	create table Cliente(
	codClie int unique not null,
	nomClie nvarchar(50) not null,
	rucClie nvarchar(11) unique not null,
	direClie nvarchar(90) not null,

	primary key(codClie)
	)
	go


	create table Producto(
	codProd int unique not null,
	UMProd varchar(9) ,
	descriProd nvarchar(150),
	VUProd money,

	primary key(codProd)
	)
	go


	create table FragmentoFactura(
	codDetProd int not null,
	codProd int unique not null,
	cantiProd int not null,
	importe money not null,

	foreign key (codProd) references Producto (codProd),
	primary key (codDetProd)
	)
	go
	

	create table Factura(
	nroFactura nvarchar(11)  not null,
	nroSerie nvarchar(15) unique not null,
	codDetProd int not null,
	codClie int  not null,
	codVend int  not null,
	nroSerieGR nvarchar(50)  not null,
	fechaEmision datetime default getdate(),
	CondiPago nvarchar(40) not null,
	oderCompr nvarchar(50),
	tipoMoneda nvarchar(12),
	subTotal money ,
	otrosCargos money default 0,
	opGrava money default 0,
	opExoner money default 0,
	ventaGrat money default 0,
	opInaf money default 0,
	igv money,
	impoTotal money,


	foreign key (codDetProd) references FragmentoFactura (codDetProd),
	foreign key (codClie) references Cliente (codClie),
	foreign key (codVend) references vendedor (codVend),
	foreign key (nroSerieGR) references guiaRemision (nroSerieGR),

	primary key (nroSerie)
	)
	go

	select * from Historial_db order by fecha desc
	
	

	--Insertar datos en tablas
	insert into guiaRemision values ('Q001-556101',1231)
	insert into guiaRemision values ('B011-556131',154)
	insert into guiaRemision values ('P100-554564',458)
	insert into guiaRemision values ('A100-554546',489)
	insert into guiaRemision values ('H100-464519',948)
	insert into guiaRemision values ('M555-121113',119)
	insert into guiaRemision values ('Z156-166631',4788)
	insert into guiaRemision values ('C788-161678',666)
	insert into guiaRemision values ('P104-449578',321)
	insert into guiaRemision values ('H149-446178',993)
	insert into guiaRemision values ('P199-665848',153)


	insert into guiaRemision values ('P999-668989',999)

	delete from guiaRemision
	where  nroGuiaRemi = 999



	insert into vendedor values (21,'Jean Carlos')
	insert into vendedor values (22,'Jean Marco')
	insert into vendedor values (23,'Bartolome Pico')
	insert into vendedor values (24,'Jean Paul')
	insert into vendedor values (25,'Bart Sim')
	insert into vendedor values (26,'Zack May')


	insert into Cliente values (1015,'Max Vlae','20164862515','Los Jazmines')
	insert into Cliente values (1016,'Timmy Blash','20164953264','Las Fresas')
	insert into Cliente values (1017,'Jean Joel','10321651321','Juan Macias')
	insert into Cliente values (1018,'Betho Muran','10321615261','San Martin')
	insert into Cliente values (1019,'Chuquito Sideral','20198654951','Surco')


	insert into Producto values(2411,'UNID','DISPENSADOR PERITA',144.06)
	insert into Producto values(2415,'UNID','ROCA SDS "DEWALT" 16 X 160M (00717)',20.3)
	insert into Producto values(4020,'UNID','BROCA HSS SPRINT MASTER "ALPEN" 1/2" (067038',19.49)
	insert into Producto values(1028,'UNID','TORNILLO DRYWAL P/B NEGRO 7X7/16', 4.80)
	insert into Producto values(1030,'UNID','AUTORROSCANTE C/PAN 8X2', 4.80)
	insert into Producto values(1031,'UNID','TORNILLO DRYWAL P/B NEGRO 7X7/16',16.94)
	insert into Producto values(1033,'M',' CABLE ACERADO GALVA SIN/FORRO 3/8', 5.932203)
	insert into Producto values(1034,'PIEZAS','DISPENSADOR PERITA LAROS', 4.0677)
	insert into Producto values(1035,'M','TUERCA 1/4"',  6.7796)
	insert into Producto values(1036,'PIEZAS','PERNO CABEZA COCHE 1/4"X3/4" ', 30.5085)
	insert into Producto values(1038,'SMALL','PERNO CABEZA COCHE 1/4"X3/4" ', 150.00)
	insert into Producto values(1039,'DOCENA','TACO DE EXPANSION 1/2"', 5.0847)
	insert into Producto values(1037,'TERCIO','TACO DE EXPANSION 1/2"', 16.949)



	insert into FragmentoFactura values(4,2411,4,576.24)
	insert into FragmentoFactura values(9,2415,9,182.7)
	insert into FragmentoFactura values(5,4020,1,19.49)
	insert into FragmentoFactura values(8,1028,50,240)
	insert into FragmentoFactura values(1,1031,5,84.7)
	insert into FragmentoFactura values(2,1030,4,19.2)

	insert into FragmentoFactura values(3,1033,100,592.203)
	insert into FragmentoFactura values(6,1035,600,4067.76)
	insert into FragmentoFactura values(7,1034,401,1631.1477)
	insert into FragmentoFactura values(13,1036,47,1433.8995)
	insert into FragmentoFactura values(15,1037,77,1305.073)
	insert into FragmentoFactura values(17,1039,31,157.6257)


	

	insert into Factura values ('20604448809','F001-0020626',4,1015,21,'Q001-556101',GETDATE(),'TRANSFERENCIA','----','Dolares',576.24,0,0,0,0,0,103.7232,679.96)
	insert into Factura values ('20604448809','A016-3165056',9,1017,22,'B011-556131',GETDATE(),'Pago anticipado','----','Soles',182.7,0,0,0,0,0,32.886,215.586)
	insert into Factura values ('20604448809','M044-0031265',8,1016,25,'P100-554564',GETDATE(),'Pago al contado','----','Euro',240,0,0,0,0,0,43.2,283.2)
	insert into Factura values ('20604448809','H120-1651355',1,1018,24,'A100-554546',GETDATE(),'TRANSFERENCIA','----','Franco',84.7,0,0,0,0,0,15.12,99.82)
	insert into Factura values ('20604448809','P912-5616551',2,1019,23,'H100-464519',GETDATE(),'Pago aplazado','----','Dolares',19.2,0,0,0,0,0,3.456,22.65)
	insert into Factura values ('20604448809','H149-4461781',2,1015,21,'H100-464519',GETDATE(),'Pago anticipado','----','Soles',24,0,0,0,0,0,4.32,28.32)

	insert into Factura values ('20604448809','P949-4461781',3,1019,24,'P104-449578',GETDATE(),'Transferencia bancaria','----','Soles',592.203,0,0,0,0,0,106.59654,698.79954)
	insert into Factura values ('20604448809','C711-6465441',6,1015,23,'Z156-166631',GETDATE(),'Cheque personal','----','Franco',4067.76,0,0,0,0,0,732.1968,4799.9568)
	insert into Factura values ('20604448809','L326-9461781',7,1017,24,'Q001-556101',GETDATE(),'Tarjetas de crédito','----','Franco',1631.1477,0,0,0,0,0,293.606586,1924.754286)
	insert into Factura values ('20604448809','A164-4984866',13,1019,23,'C788-161678',GETDATE(),'Giro postal','----','Real',1433.8995,0,0,0,0,0,258.10191,1692.00141)
	insert into Factura values ('20604448809','R174-1465665',15,1018,25,'A100-554546',GETDATE(),'Pago online sin tarjeta','----','Franco',1305.073,0,0,0,0,0,234.91314,1539.98614)
	insert into Factura values ('20604448809','Q339-3156486',17,1016,22,'B011-556131',GETDATE(),'Transferencia bancaria','----','Euro',157.6257,0,0,0,0,0,28.372626,185.998326)




	/*Creaciones de ejercicios*/
	
	select * from registroAnual
	pivot(
		sum(Monto)
		for Mes in(Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Setiembre,Octubre,Noviembre,Diciembre)
	) as [Importaciones Al Mes]
	unpivot(
	Monto
	for Mes in(Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Setiembre,Octubre,Noviembre,Diciembre)
	) as PVT



	select * from Factura



	alter table Factura
	add ClientePotenciales as
	case 
		when  impoTotal>= 500 then 'Potencial'
		else 'Regular'
	end


	 select p.nroSerieGR,p.nroGuiaRemi from guiaRemision p
	 where not  exists (select * from Factura as C where  c.nroSerieGR =p.nroSerieGR)



	 select * from guiaRemision




	  select count(nroFactura) from Factura




	  create function Imp
	  (@precio money, @canti decimal ) returns money
	  begin 
		declare @total money
		set @total = (@precio * @canti)
		return (@total)
	  end
	  go

	  create function Imp_IGV
	  (@precio money , @canti decimal) returns money
	  begin 
		declare @igv money
		set @igv = ((@precio * @canti) * 0.18)
		return (@igv)
      end 
	  go
	  

	  create function Importe
	  (@precio money , @canti decimal) returns money
	  begin 
		declare @igv money
		declare @total money
		set @igv = ((@precio * @canti) * 0.18)
		set @total = ((@precio * @canti) + @igv )
		return (@total)
      end 
	  go
	  



	  select cantiProd as [Cantidad] , VUProd [Valor Unitario], descriProd [Descripcion], dbo.Imp_IGV (VUProd,cantiProd) IVG , dbo.Imp(VUProd,cantiProd) SubTotal, dbo.Importe (VUProd,cantiProd) ImporteTotal
	  from dbo.FragmentoFactura 
	  INNER JOIN dbo.Producto ON dbo.FragmentoFactura.codProd = dbo.Producto.codProd 
	  INNER JOIN dbo.Factura ON dbo.FragmentoFactura.codDetProd = dbo.Factura.codDetProd
	  GO

	  
	  create procedure NombreCliente
	  (@codClie int)
	  as 
	  begin 
		select dbo.Cliente.codClie as [Codigo del Cliente], dbo.Cliente.nomClie as [Nombre], dbo.Cliente.direClie as [Direccion] , dbo.Factura.codDetProd as [Detalle Producto],
				dbo.Producto.codProd as [Codigo Producto], dbo.Producto.descriProd as [Descripcion], dbo.Producto.UMProd as [Unidad Medida], dbo.FragmentoFactura.cantiProd as [Cantidad Producto],
				dbo.Producto.VUProd as [Valor Unitario]

		from dbo.Cliente 
			INNER JOIN dbo.Factura ON dbo.Cliente.codClie = dbo.Factura.codClie 
			INNER JOIN dbo.FragmentoFactura ON dbo.Factura.codDetProd = dbo.FragmentoFactura.codDetProd
			INNER JOIN dbo.Producto ON dbo.FragmentoFactura.codProd = dbo.Producto.codProd
			where dbo.Cliente.codClie = @codClie
	  end
	  go

	  exec NombreCliente 1015


	   create procedure ProductosPedido
	  (@codProd int)
	  as 
	  begin 
		select dbo.Producto.codProd as [Codigo Producto], dbo.Cliente.codClie as [Codigo del Cliente], dbo.Cliente.nomClie as [Nombre], dbo.Cliente.direClie as [Direccion],
			   dbo.Producto.descriProd as [Descripcion], dbo.Producto.UMProd as [Unidad Medida], dbo.FragmentoFactura.cantiProd as [Cantidad Producto],
				dbo.Producto.VUProd as [Valor Unitario]

		from dbo.Cliente 
			INNER JOIN dbo.Factura ON dbo.Cliente.codClie = dbo.Factura.codClie 
			INNER JOIN dbo.FragmentoFactura ON dbo.Factura.codDetProd = dbo.FragmentoFactura.codDetProd
			INNER JOIN dbo.Producto ON dbo.FragmentoFactura.codProd = dbo.Producto.codProd
			where dbo.Producto.codProd = @codProd
	  end
	  go
	    
	exec  ProductosPedido 1028