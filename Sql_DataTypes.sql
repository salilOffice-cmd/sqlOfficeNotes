---------------------------------------------
         --SQL Server Data Types
/*---------------------------------------------

What is SQL Server Data Type?

1] The SQL Server Data Types are the attribute that 
   specifies what types of data entered by the user 
   such as integer, character, decimal, date time, etc. 
	


Integer data types             ==  [Tiny,Smallint,int,Bigint]
Decimal data types             ==  [Decimal (P, S)] 
                                    P-Precision (P):The Precision is nothing but the maximum number of 
								    digits that we can store both to the left side and right side of the 
									decimal point. ex- Decimal (18, 0)

									Scale (S):The scale is nothing but it just indicates 
									          the maximum number of decimal digits that 
											  we can store to the right of the decimal point. 

Date and Time data types      == Date,DateTime


Character data types          == 1] Fixed length       [char,nvarchar] 
                                 2] Variable length    [varchar,nvarchar]
*/

CREATE TABLE DataTypeMaster (
    -- Integer types
    IntColumn INT,
    SmallIntColumn SMALLINT,
    BigIntColumn BIGINT,
    
    -- Numeric types
    DecimalColumn DECIMAL(10, 2),
    FloatColumn FLOAT,
    
    -- Character strings
    CharColumn CHAR(10),
    VarcharColumn VARCHAR(255),
    TextColumn TEXT,
    
    -- Date and time
    DateColumn DATE,
    TimeColumn TIME,
    DateTimeColumn DATETIME,
    
    -- Binary data
    BinaryColumn VARBINARY(1024),
    ImageColumn IMAGE,
    
    -- Boolean
    BitColumn BIT,
    
    -- Miscellaneous
    UniqueIdentifierColumn UNIQUEIDENTIFIER,
    XmlColumn XML,
    MoneyColumn MONEY,
    RealColumn REAL,
    
    -- Auto-increment primary key
    IDColumn INT IDENTITY(1, 1) PRIMARY KEY
);


INSERT INTO DataTypeMaster (IntColumn, SmallIntColumn, BigIntColumn, DecimalColumn, FloatColumn,
                         CharColumn, VarcharColumn, TextColumn, DateColumn, TimeColumn,
                         DateTimeColumn, BinaryColumn, ImageColumn, BitColumn,
                         UniqueIdentifierColumn, XmlColumn, MoneyColumn, RealColumn)
VALUES
   (123, 456, 789, 123.45, 1234.56,
    'Char', 'SampleVarchar', 'SampleText', '2023-10-11', '15:30:00',
    '2023-10-11 15:30:00', 0x1234ABCD, 0x12FFAAEE, 1,
    'E28A736B-CDF4-4A29-A09E-83E4D80E2A4E', '<data>Sample XML</data>', 100.50, 3.14);

-- Display the inserted data
SELECT datalength(CharColumn)LengthOfChar,
       datalength(VarcharColumn)LengthOfVarchar 
FROM DataTypeMaster;

/*--------------------------------------------------------------------------------
Note :- above example tells what is fixed length and what is variable length 
----------------------------------------------------------------------------------