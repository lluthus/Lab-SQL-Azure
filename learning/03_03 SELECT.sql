SELECT * FROM Countries
WHERE ID = 1

ALTER TABLE Countries
ADD IndependenceDay datetime

UPDATE Countries
SET IndependenceDay = '7/4/1776' WHERE CountryTLD = 'US'

UPDATE Countries
SET IndependenceDay = '1971-12-2' WHERE CountryTLD = 'AE'

SELECT
	CountryName AS 'Name'
	, Convert(Date, IndependenceDay, 0) AS 'Independence Day'
FROM Countries

SELECT
	CountryName AS 'Name'
	, Convert(Date, IndependenceDay, 0)
	, DateName(weekday, IndependenceDay) AS 'Independence Day'
FROM Countries