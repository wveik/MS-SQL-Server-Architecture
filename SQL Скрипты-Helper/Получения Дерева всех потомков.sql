with MyTable as (
	SELECT [treenodeid]
      ,[treecode_r]
      ,[treenodeparentid]
      ,[treenodecode]
      ,[treenodeprocedure]
      ,[treenoderightcode]
      ,[treenodedeteted]
	  , 1 as LEVEL
  FROM [UNIVERS].[cfg].[treenode]
  WHERE treenodeparentid is NULL

	UNION ALL

	SELECT Child.*, Parent.LEVEL + 1
	 FROM MyTable Parent INNER JOIN [UNIVERS].[cfg].[treenode] Child
		ON Child.treenodeparentid=Parent.treenodeid
)

SELECT * FROM MyTable


--SELECT * FROM MyTable
--WHERE LEVEL=2
