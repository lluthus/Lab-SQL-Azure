SELECT * FROM Countries

ALTER TABLE Countries
ADD ID int

UPDATE Countries
SET ID = 2
WHERE CountryName = 'Iceland'

UPDATE Countries
SET ID = 3 WHERE CountryTLD = 'UK'

UPDATE Countries
SET ID = 4 WHERE CountryTLD = 'AE'