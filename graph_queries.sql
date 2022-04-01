-- Friends of A:
SELECT DISTINCT(destination) from edges WHERE source = '0';

-- 2nd circle friends of A:
SELECT DISTINCT(destination) FROM edges WHERE source IN (SELECT DISTINCT(destination) from edges WHERE source = '0');

-- Mutual friends of A and B:
SELECT DISTINCT(destination) from edges WHERE source = '59' AND destination IN (SELECT DISTINCT(destination) from edges WHERE source = '0');

-- Friends of A who are not friends with B :
SELECT DISTINCT(destination) from edges WHERE source = ’59’ AND destination NOT IN (SELECT DISTINCT(destination) from edges WHERE source = ‘0’);

-- 10 MOST POPULAR PEOPLE :
SELECT destination, COUNT(destination) AS count FROM edges GROUP BY destination ORDER BY count DESC LIMIT 10;

-- 10 LEAST POPULAR PEOPLE :
SELECT destination, COUNT(destination) AS count FROM edges GROUP BY destination ORDER BY count ASC LIMIT 10;

-- AVERAGE NUMBER OF FRIENDS
SELECT AVG(count) FROM(SELECT COUNT(destination) AS count FROM edges GROUP BY destination)t;

-- PEOPLE WITH HIGHER THAN AVG NUMBER OF FRIENDS
SELECT * FROM (SELECT source, count(source) as count from edges GROUP BY source)t WHERE count > (SELECT AVG(count) FROM(SELECT COUNT(destination) AS count FROM edges GROUP BY destination)t1);