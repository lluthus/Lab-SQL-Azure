DECLARE @id int         = 101,
        @c  varchar(1)  = 'V';

DECLARE @IDR TABLE (
   Id          INT,
   jsonfield varchar(max)
);
--init json
INSERT INTO @IDR VALUES (101,'{"Id":1,"Data":"2020-11-12T00:00:00","Totale":2440,"Codice":"A",
   "Dettagli":[
      {"Codice":"A","Conto":"X","Tax":"0022","TaxableIncome":1000,"TaxAmount":220},
      {"Codice":"A","Conto":"Y","Tax":"0022","TaxableIncome":1000,"TaxAmount":220}
   ]}');
-- update all Dettagli.Codice
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
