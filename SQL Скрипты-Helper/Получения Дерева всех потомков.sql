with MyTable as (
	SELECT [treenodeid]
      ,[treecode_r]
      ,[treenodeparentid]
      ,[treenodecode]
      ,[treenodeprocedure]
      ,[treenoderightcode]
      ,[treenodedeteted]
  FROM [UNIVERS].[cfg].[treenode]
  WHERE treenodeparentid is NULL

	UNION ALL

	SELECT Child.*
	 FROM MyTable Parent INNER JOIN [UNIVERS].[cfg].[treenode] Child
		ON Child.treenodeparentid=Parent.treenodeid
)

SELECT * FROM MyTable