DECLARE @id int         = 101,
        @c  varchar(1)  = 'V';

DECLARE @IDR TABLE (
   Id          INT,
   jsonfield varchar(max)
);
--init json
INSERT INTO @IDR VALUES (101,'{"Id":1,
   "Dettagli":[
      {"Codice":"A"},
      {"Codice":"A"}
   ]}');
-- update all Dettagli.Codice one time
UPDATE @IDR
set jsonfield = 
		JSON_MODIFY(jsonfield, '$.Dettagli', JSON_QUERY((Select CONCAT('[', 
                                                                     STRING_AGG(JSON_MODIFY([value], '$.Codice', @c), ',') WITHIN GROUP (ORDER BY CAST([key] AS int))
                                                                     , ']')
								 From OPENJSON(jsonfield, '$.Dettagli') detail))
		)
From
	 @IDR 
Where
	 id = @id    

select * from @IDR
