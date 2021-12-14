use Northwind;

declare cursorCat cursor scroll for select CategoryID,CategoryName 
											from Categories

open cursorCat
fetch first from cursorCat --primero en el cursor
fetch absolute 3 from cursorCat --el tercer de posicion de cursor
fetch next from cursorCat --el siguiente posicion que elijas
fetch last from cursorCat	--el utlimo del cursor
close cursorCat
deallocate cursorCat
go

---------------------
begin 
	declare @v_idcat smallint=2
	declare curProductos cursor for select p.ProductName,c.CategoryName,p.UnitPrice
		from Products P join Categories C
		on p.CategoryID=C.CategoryID
		where P.CategoryID=@v_idcat
	declare @v_Producto varchar(max), @v_Categoria varchar(max), @v_precio smallmoney
	open curProductos
	fetch curProductos into @v_Producto,@v_Categoria, @v_precio
	while @@FETCH_STATUS=0
	begin
		print 'Producto: '+@v_Producto
		print 'Categoria: '+@v_Categoria
		print 'Precio: '+cast(@v_precio as varchar(12))
		print replicate('-',50)
		fetch curProductos into @v_Producto,@v_Categoria,@v_precio
	end
	close curProductos
	deallocate curProductos
end
go
------------------------- 
select E.FirstName+space(1)+E.LastName, format(sum((D.Quantity*D.UnitPrice)*(1-D.Discount)),'C','En-US') TotalFact
from Employees E join Orders O on E.EmployeeID=O.EmployeeID join [Order Details] D
on o.OrderID=D.OrderID
group by E.FirstName+space(1)+E.LastName
--------------------------------------------
declare curSalePerson cursor for select E.FirstName+space(1)+E.LastName, 
			format(sum((D.Quantity*D.UnitPrice)*(1-D.Discount)),'C','En-US') TotalFact
			from Employees E join Orders O on E.EmployeeID=O.EmployeeID join [Order Details] D
			on o.OrderID=D.OrderID
			group by E.FirstName + Space(1) + E.LastName
declare @v_Empleado varchar(max),@v_monto money,@v_Tipo varchar(max)
open curSalePerson
fetch curSalePerson into @v_Empleado,@v_monto
while @@FETCH_STATUS=0
begin
	if @v_monto <=100000
		set @v_Tipo='SalesPerson Basico'
	else if @v_monto <=200000
		set @v_Tipo='SalesPerson Medium'
	else 
		set @v_Tipo='SalesPerson Excellent'

	print 'Empleado: '+ @v_Empleado
	print 'Total Facturado: '+cast(@v_monto as varchar(20))
	print 'Tipo: '+@v_tipo
	print replicate ('*',50)
		fetch curSalePerson into @v_Empleado,@v_monto
		
end
	close curSalePerson
	deallocate curSalePerson
go
