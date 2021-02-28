-- primo file sql Gittato da Azure Data Studio (mi ha fatto penare, ma ci stà)

DECLARE
   @id                  int = 101,
	@c   varchar(1) = 'V'

DECLARE @IDR TABLE (
   Id          INT,
   jsonfield varchar(max)
) 

INSERT INTO @IDR VALUES (101,'{"Id":1,"Data":"2020-11-12T00:00:00","Totale":2440,"Codice":"A",
   "Dettagli":[
      {"Codice":"A","Conto":"X","Tax":"0022","TaxableIncome":1000,"TaxAmount":220},
      {"Codice":"A","Conto":"Y","Tax":"0022","TaxableIncome":1000,"TaxAmount":220}
   ]}')

DECLARE @T table(
   Tax varchar(4) not null,
   Consistent bit        not null
)

insert into @T    values('0022', 1)

UPDATE @IDR
set jsonfield = JSON_MODIFY(
	--modifico il codice per ogni dettaglio
	JSON_MODIFY(jsonfield, '$.Dettagli'          , JSON_QUERY((Select 
								 															 CONCAT('[', STRING_AGG(JSON_MODIFY(
																															JSON_MODIFY([value], '$.Codice', @c				 )
																																					 , '$.Tax'   , IIF(tbpr.Consistent = 1, 
																																											 JSON_VALUE([value], '$.Tax'),
																																															'')										  )                
								 						 												 				  , ',') WITHIN GROUP (ORDER BY CAST([key] AS int)), ']')
								 									            From  
																						OPENJSON(jsonfield, '$.Dettagli') detail
																					Left Join
																						@T			  tbpr on tbpr.Tax = JSON_VALUE(detail.[value], '$.Tax')
																					)))
	--modifico la causale di testata
								  , '$.Codice', @c)
From
	 @IDR 
Where
	 id     = @id    

select * from @IDR
