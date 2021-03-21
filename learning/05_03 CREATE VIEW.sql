CREATE VIEW TopFiveWaterfallsUSA
AS
SELECT TOP 5
	Region
	, COUNT(*) AS 'Number of Waterfalls'
FROM Waterfalls
GROUP BY Region
ORDER BY COUNT(*) DESC

SELECT * FROM TopFiveWaterfallsUSA WHERE Region = 'OR'