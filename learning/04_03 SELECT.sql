
-- How many waterfalls are there in each country?

SELECT CountryName, COUNT(WaterfallName)
FROM Waterfalls
RIGHT OUTER JOIN Countries ON Waterfalls.Country = Countries.CountryName
GROUP BY CountryName