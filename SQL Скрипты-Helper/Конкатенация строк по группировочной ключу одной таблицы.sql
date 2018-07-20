SELECT Main.treeid_r,
       LEFT(Main.treenode,Len(Main.treenode)-1) AS treenode
FROM
    (
        SELECT distinct ST2.treeid_r, 
            (
                SELECT ST1.treenodecode + ',' AS [text()]
                FROM cfg.treenode ST1
                WHERE ST1.treeid_r = ST2.treeid_r
                ORDER BY ST1.treeid_r
                FOR XML PATH ('')
            ) treenode
        From cfg.treenode ST2
    ) [Main]