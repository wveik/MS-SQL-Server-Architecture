DECLARE	@Doc XML =
'
<Order>
	<Customer Name="������� ������" />
	<Products>
		<Item Name="������� Nokia" Price="100" Quantity="3" />
		<Item Name="������� iPhone" Price="200" Quantity="2" />
		<Item Name="������� Motorola" Price="100" Quantity="1" />
	</Products>
</Order>
'

SELECT	@Doc.query ('/Order/Products/Item[@Price="100"][2]')

SELECT T.c.query('.') AS result  
FROM   @Doc.nodes('/Order/Products/Item') T(c)  
GO  

