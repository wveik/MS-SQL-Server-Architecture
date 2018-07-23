EXEC procGenerateEntityClass 'cfg.tree'

--**************************************
-- Name: Business Entity Class Generator
-- Description:This SP accepts a database object name (table, view) parameter and generates (C# code) custom entity class based on the object's fields. You can then copy and paste the generated code to your C# class.
-- By: Leon Tayson
--
--
-- Inputs:@ObjectName - name of your table, view
--
-- Returns:C# codes for your business entity object
--
--Assumes:None
--
--Side Effects:None
--This code is copyrighted and has limited warranties.
--Please see http://www.Planet-Source-Code.com/xq/ASP/txtCodeId.1039/lngWId.5/qx/vb/scripts/ShowCode.htm
--for details.
--**************************************

IF EXISTS
(
    SELECT *
    FROM dbo.sysobjects
    WHERE id = OBJECT_ID(N'procGenerateEntityClass')
          AND OBJECTPROPERTY(id, N'IsProcedure') = 1
)
    DROP PROCEDURE procGenerateEntityClass;
GO

/*======================================================================
Business Entity Class Generator
This SP accepts a database object (table, view) name's parameter and
generates (C# code) custom entity class based on the object's fields
Sample Usage:
USE Northwind
EXEC procGenerateEntityClass 'Shippers'
Author:Leon C. Tayson
======================================================================*/

CREATE PROCEDURE procGenerateEntityClass @ObjectName VARCHAR(100)
AS
     DECLARE @name VARCHAR(20), @type VARCHAR(20);
     DECLARE objCursor CURSOR
     FOR SELECT sc.name,
                st.name type
         FROM syscolumns sc
              INNER JOIN systypes st ON st.xusertype = sc.xusertype
         WHERE Id = OBJECT_ID(@ObjectName);
     DECLARE @declarationCodes VARCHAR(8000), @ctorCodes VARCHAR(8000), @propertyCodes VARCHAR(8000);
     SET @declarationCodes = '';
     SET @ctorCodes = '';
     SET @propertyCodes = '';
     OPEN objCursor;
     FETCH NEXT FROM objCursor INTO @name, @type;
     DECLARE @ctype VARCHAR(20);-- C# type
     DECLARE @ctorParms VARCHAR(4000);
     SET @ctorParms = '';
     IF @@FETCH_STATUS <> 0
         BEGIN
             CLOSE objCursor;
             DEALLOCATE objCursor;
             PRINT 'Error... Please check passed parameter';
             RETURN;
         END;
     WHILE @@FETCH_STATUS = 0
         BEGIN
             SET @ctype = CASE
                              WHEN @type LIKE '%char%'
                                   OR @type LIKE '%text%'
                              THEN 'string'
                              WHEN @type IN('decimal', 'numeric')
                              THEN 'double'
                              WHEN @type = 'real'
                              THEN 'float'
                              WHEN @type LIKE '%money%'
                              THEN 'decimal'
                              WHEN @type = 'bit'
                              THEN 'bool'
                              WHEN @type = 'bigint'
                              THEN 'long'
                              WHEN @type LIKE '%int%'
                              THEN 'int'
                              ELSE @type
                          END;
--PRINT CHAR(9) + 'private ' + @ctype + ' ' + 'm_' + @name + ';'
             SET @declarationCodes = @declarationCodes+CHAR(9)+'private '+@ctype+' '+'m_'+@name+';'+CHAR(13);
             SET @ctorCodes = @ctorCodes+CHAR(9)+CHAR(9)+'m_'+@name+' = '+LOWER(LEFT(@name, 1))+SUBSTRING(@name, 2, LEN(@name))+';'+CHAR(13);
             SET @ctorParms = @ctorParms+@ctype+' '+LOWER(LEFT(@name, 1))+SUBSTRING(@name, 2, LEN(@name))+', ';
             SET @propertyCodes = @propertyCodes+CHAR(9)+'public '+@ctype+' '+@name+CHAR(13)+CHAR(9)+'{'+CHAR(13)+CHAR(9)+CHAR(9)+'get { return m_'+@name+'; }'+CHAR(13)+CHAR(9)+CHAR(9)+'set { m_'+@name+' = value; }'+CHAR(13)+CHAR(9)+'}'+CHAR(13);
             FETCH NEXT FROM objCursor INTO @name, @type;
         END;
     PRINT '[Serializable]';
     PRINT 'public class '+@ObjectName+'Info';
     PRINT '{';
     PRINT @declarationCodes;
     PRINT '';
     PRINT CHAR(9)+'public '+@ObjectName+'Info('+LEFT(@ctorParms, LEN(@ctorParms) - 1)+')';
     PRINT CHAR(9)+'{';
     PRINT @ctorCodes;
     PRINT CHAR(9)+'}';
     PRINT '';
     PRINT @propertyCodes;
     PRINT '}';
     CLOSE objCursor;
     DEALLOCATE objCursor;