SELECT * FROM Countries
WHERE CountryName = 'Iceland'

UPDATE Countries
SET CountryTLD = 'IS'
WHERE CountryName = 'Iceland'

SELECT * FROM Countries

UPDATE Countries SET CountryTLD = 'ZA' WHERE CountryName = 'Republic of South Africa'
UPDATE Countries SET CountryTLD = 'AE' WHERE CountryName = 'United Arab Emirates'
UPDATE Countries SET CountryTLD = 'UK' WHERE CountryName = 'United Kingdom'
UPDATE Countries SET CountryTLD = 'US' WHERE CountryName = 'United States of America'
