
Insert Into Renta.Edificios(COD_EDIF,NOM_EDIF,DIRECC_EDIF,CODPOSTAL_EDIF,AREA_TOTAL_EDIF)
Values('EDF036','SANTA ROSA INC','Av. El Sol 868','L-05',250)

select top(3) Cod_cont,PROP_COD_USUA,INQ_COD_USUA,Fec_Firma,COD_EST from Renta.Contrato 
where Fec_Firma like '%2004%' 
order by Fec_Firma desc

select * from Renta.EDIFICIOS

-----------------


Bulk Insert Renta.Edificios
From 'C:\Data\Edificio.txt'
With (	FieldTerminator = ',',
			RowTerminator ='\n'	)
go

/*Consultar*/
Select * from Renta.EDIFICIOS
go


---------------------------
select * from Renta.Contrato

insert into BDInmobiliaria.Renta.Contrato
select * from BDCONTRATOSEXTERNOS.dbo.TBContrato
--------------------

update Renta.EDIFICIOS
set DIRECC_EDIF='Av. Carlos I    zaguirre 233',
	CODPOSTAL_EDIF='L-23',
	AREA_TOTAL_EDIF='256'
where COD_EDIF='EDF013'
go

Select * from Renta.EDIFICIOS
go

 



select * from Renta.EDIFICIOS
select * from Renta.DEPARTAMENTOS
select * from Renta.Contrato
select * from Renta.DetalleContrato

update renta.DEPARTAMENTOS
set PRECIO_ALQXMES_DEP=PRECIO_ALQXMES_DEP+(PRECIO_ALQXMES_DEP/2)
where COD_EDIF='EDF002'

select * from Renta.EDIFICIOS
select * from Renta.DEPARTAMENTOS
select * from Renta.Contrato
select * from Renta.DetalleContrato

select * from Renta.ESTADO
select * from Renta.DEPARTAMENTOS
select * from Renta.Contrato

update renta.Contrato
set COD_EST=null
where FEC_FIRMA='%2005%'

select * from Renta.Contrato
order by FEC_FIRMA
-----------------
select * from Renta.EDIFICIOS
select * from Renta.DEPARTAMENTOS
select * from Renta.Contrato
select * from Renta.DetalleContrato

update Renta.DEPARTAMENTOS
set PRECIO_ALQXMES_DEP=650
where COD_EDIF='EDF001'

-----------------
Merge into Renta.EDIFICIOS as target
using Renta.NewEdificios as source
on (target.COD_EDIF=source.COD_EDIF)
when matched then update set target.DIRECC_EDIF=source.DIRECC_EDIF,target.CODPOSTAL_EDIF=source.CODPOSTAL_EDIF
when not matched then insert values (source.COD_EDIF,source.NOM_EDIF,source.DIRECC_EDIF,source.CODPOSTAL_EDIF,source.AREA_TOTAL_EDIF,
									source.AREA_CONSTRUIDA_EDIF,source.REFERENCIA_EDIF,source.COD_EST);
go

select * from Renta.EDIFICIOS
select * from Renta.NewEdificios

------------------------
--cube
select e.CODPOSTAL_EDIF,
		e.NOM_EDIF,
		count(d.COD_DEP) as [Total de departamentos]
from renta.EDIFICIOS e join renta.DEPARTAMENTOS d
on e.COD_EDIF=d.COD_EDIF
group by cube (e.CODPOSTAL_EDIF,e.NOM_EDIF)
order by 1,2,3

-------------------------
select isnull(e.CODPOSTAL_EDIF,'______________') [CodigoPostal],
		isnull (e.NOM_EDIF,'___________') [NombreEdificio],
		count(d.COD_DEP) as [Total de departamentos]

from renta.EDIFICIOS e 
join renta.DEPARTAMENTOS d
on e.COD_EDIF=d.COD_EDIF 
group by ROLLUP (e.CODPOSTAL_EDIF,e.NOM_EDIF)
order by 1,2,3

select * from Renta.DEPARTAMENTOS


select * from Renta.EDIFICIOS


select * from Renta.INQUILINO
select * from Renta.NewEdificios
select * from Renta.PROPIETARIO
