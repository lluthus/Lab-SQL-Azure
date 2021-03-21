SELECT DISTINCT Region
FROM Waterfalls

SELECT COUNT(*)
FROM Waterfalls
WHERE Region = 'AK'

SELECT Region, COUNT(*)
FROM Waterfalls
GROUP BY Region
