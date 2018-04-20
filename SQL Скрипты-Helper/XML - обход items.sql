DECLARE	@Doc XML =
'
<Order>
	<Customer Name="Åâãåíèé Îíåãèí" />
	<Products>
		<Item Name="Òåëåôîí Nokia" Price="100" Quantity="3" />
		<Item Name="Òåëåôîí iPhone" Price="200" Quantity="2" />
		<Item Name="Òåëåôîí Motorola" Price="100" Quantity="1" />
	</Products>
</Order>
'

SELECT	@Doc.query ('/Order/Products/Item[@Price="100"][2]')

SELECT T.c.query('.') AS result  
FROM   @Doc.nodes('/Order/Products/Item') T(c)  
GO  

DECLARE	@Doc1 XML =
'
<Order>
	<Customer Name="Евгений Онегин" />
	<Products>
		<Item>2</Item>
		<Item>3</Item>
		<Item>4</Item>
	</Products>
</Order>
'

SELECT	@Doc1.query ('/Order/Products/Item[@Price="100"][2]')

SELECT 
T.c.value('.', 'int') AS result  
FROM   @Doc1.nodes('/Order/Products/Item') T(c)  
GO  

