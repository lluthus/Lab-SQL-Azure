-- primo file sql Gittato da Azure Data Studio (mi ha fatto penare, ma ci stà)

DECLARE
   @id                  int = 101,
	@codPurchaseReason   varchar(1) = 'V'

DECLARE @IDR TABLE (
   Id          INT,
   JsonMapping varchar(max)
) 

INSERT INTO @IDR VALUES (101,'{"Id":1,"Data":"2020-11-12T00:00:00","Totale":2440,"Codice":"A",
   "Dettagli":[
      {"Codice":"A","Conto":"X","IVA":"0022","TaxableIncome":1000,"TaxAmount":220},
      {"Codice":"A","Conto":"Y","IVA":"0022","TaxableIncome":1000,"TaxAmount":220}
   ]}')

DECLARE @T table(
   IVA varchar(4) not null,
   Consistent bit        not null
)

insert into @T    values('0022', 1)

UPDATE @IDR
set JsonMapping = JSON_MODIFY(
	--modifico il codice per ogni dettaglio
	JSON_MODIFY(JsonMapping, '$.Dettagli'          , JSON_QUERY((Select 
								 															 CONCAT('[', STRING_AGG(JSON_MODIFY(
																															JSON_MODIFY([value], '$.Codice', @codPurchaseReason				 )
																																					 , '$.IVA'   , IIF(tbpr.Consistent = 1, 
																																											 JSON_VALUE([value], '$.IVA'),
																																															'')										  )                
								 						 												 				  , ',') WITHIN GROUP (ORDER BY CAST([key] AS int)), ']')
								 									            From  
																						OPENJSON(JsonMapping, '$.Dettagli') detail
																					Left Join
																						@T			  tbpr on tbpr.IVA = JSON_VALUE(detail.[value], '$.IVA')
																					)))
	--modifico la causale di testata
								  , '$.Codice', @codPurchaseReason)
From
	 @IDR 
Where
	 id     = @id    

select * from @IDR
