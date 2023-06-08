--this script returns the schema, table name, and number of rows of data it holds, ordered by the number of rows

SELECT 
	s.NAME AS TableSchema,
	t.NAME AS TableName,	
    SUM(p.rows) AS [RowCount]
FROM 
    sys.tables t
INNER JOIN 
	sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id

WHERE   
    i.index_id <= 1
GROUP BY 
    t.NAME,s.NAME, i.object_id, i.index_id, i.name 
ORDER BY 
    SUM(p.rows) DESC