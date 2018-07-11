-- ==========================================================================
-- SQL Server function to split a delimted string list into a 2 column table
-- (1. Index, 2. Value).
--
-- f_SplitString: Table-valued Function
-- f_StringLen: Scalar-valued Function
--
-- USAGE:
--      declare @str nvarchar(400) = N'name, age\, email, something here, another field';
--      select [Index] as idx, [Value] as val from dbo.f_SplitString(@str, ',', '\', '');
-- ==========================================================================
 
PRINT '';
PRINT '';
PRINT 'Creating function f_StringLen...';
GO
CREATE FUNCTION dbo.f_StringLen(@String nvarchar(4000))
RETURNS int
BEGIN
RETURN LEN(@String + '|') - 1;
END;
GO
 
PRINT '';
PRINT 'Creating function f_SplitString...';
GO
CREATE FUNCTION dbo.f_SplitString(@String nvarchar(4000), @Separator char, @Escape char, @NullPlaceholder char)
RETURNS @SubString TABLE([Index] int PRIMARY KEY IDENTITY, [Value] nvarchar(4000))
BEGIN
 
DECLARE @ForceError int;
DECLARE @StringLen int;
DECLARE @CurStringIndex smallint;
DECLARE @CurSubString nvarchar(4000);
DECLARE @CurChar char;
DECLARE @NextChar char;
 
SET @StringLen = dbo.f_StringLen(@String);
SET @CurStringIndex = 1;
SET @CurSubString = '';
SET @NextChar = SUBSTRING(@String, @CurStringIndex, 1);
 
WHILE @CurStringIndex <= @StringLen + 1
BEGIN
    SET @CurChar = @NextChar;
    SET @NextChar = CASE
                    WHEN @CurStringIndex < @StringLen THEN SUBSTRING(@String, @CurStringIndex + 1, 1)
                    ELSE NULL
                    END;
 
    IF @CurChar = @Separator OR @CurStringIndex > @StringLen
    BEGIN
        INSERT INTO @SubString
        VALUES(@CurSubstring);
        SET @CurSubString = '';
    END;
    ELSE
    BEGIN
        IF @CurChar = @Escape
        BEGIN
            SET @CurStringIndex = @CurStringIndex + 1;
            SET @CurChar = @NextChar;
            SET @NextChar = CASE
                            WHEN @CurStringIndex < @StringLen THEN SUBSTRING(@String, @CurStringIndex + 1, 1)
                            ELSE NULL
                            END;
 
            IF @CurChar IS NULL
            BEGIN
                -- The string ended with an escape character.
                SET @ForceError = 1 / 0;
            END;
            IF @CurChar = @NullPlaceholder
            BEGIN
                IF @CurSubString != '' OR
                   @NextChar != @Separator AND
                   @NextChar IS NOT NULL
                BEGIN
                    -- The null value escape sequence may only appear as the entirety of a substring.
                    SET @ForceError = 1 / 0;
                END;
 
                INSERT INTO @SubString
                VALUES(NULL);
 
                SET @CurStringIndex = @CurStringIndex + 1;
                SET @CurChar = @NextChar;
                SET @NextChar = CASE
                                WHEN @CurStringIndex < @StringLen THEN SUBSTRING(@String, @CurStringIndex + 1, 1)
                                ELSE NULL
                                END;
            END;
            ELSE
            BEGIN
                IF @CurChar IN(@Escape, @Separator)
                BEGIN
                    SET @CurSubString = @CurSubString + @CurChar;
                END;
                ELSE
                BEGIN
                    -- Unrecognized escape sequence - ie., the escape
                    -- character was followed by something other than
                    -- @Escape, @Separator, or @NullPlaceholder
                    SET @ForceError = 1 / 0;
                END;
            END;
        END;
        ELSE
        BEGIN
            -- No escape
            SET @CurSubString = @CurSubString + @CurChar;
        END;
    END;
 
    SET @CurStringIndex = @CurStringIndex + 1;
END;
    RETURN;
 
    END;
GO