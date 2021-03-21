
-- What is the Top Level Domain, if we want to register a domain name for Anton's
-- favorite waterfall?

SELECT CountryName, CountryTLD FROM Countries
SELECT Country, WaterfallName FROM Waterfalls

SELECT Waterfalls.WaterfallName, Countries.CountryTLD
FROM Waterfalls
INNER JOIN Countries ON Countries.CountryName = Waterfalls.Country
WHERE CountryName LIKE 'Ice%'
ORDER BY WaterfallName