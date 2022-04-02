-- Friends of A:
SELECT DISTINCT(destination) from edges WHERE source = '0';
-- Planning Time: 0.493 ms
-- Execution Time: 18.698 ms

-- 2nd circle friends of A:
SELECT DISTINCT(destination) FROM edges WHERE source IN (
    SELECT DISTINCT(destination) from edges WHERE source = '0');
--  Planning Time: 0.344 ms
--  Execution Time: 39.886 ms

-- Mutual friends of A and B:
SELECT DISTINCT(destination) from edges WHERE source = '59' AND destination IN (
    SELECT DISTINCT(destination) from edges WHERE source = '0');
--  Planning Time: 0.228 ms
--  Execution Time: 27.511 ms

-- Friends of A who are not friends with B :
SELECT DISTINCT(destination) from edges WHERE source = '59' AND destination NOT IN (
    SELECT DISTINCT(destination) from edges WHERE source = '0');
-- Planning Time: 0.183 ms
-- Execution Time: 35.751 ms

-- 10 MOST POPULAR PEOPLE :
SELECT destination, COUNT(destination) AS count FROM edges GROUP BY destination ORDER BY count DESC LIMIT 10;
--  Planning Time: 0.169 ms
--  Execution Time: 37.846 ms

-- 10 LEAST POPULAR PEOPLE :
SELECT destination, COUNT(destination) AS count FROM edges GROUP BY destination ORDER BY count ASC LIMIT 10;
-- Planning Time: 0.161 ms
-- Execution Time: 40.295 ms

-- AVERAGE NUMBER OF FRIENDS
SELECT AVG(count) FROM (SELECT COUNT(destination) AS count FROM edges GROUP BY destination)t;
-- Planning Time: 0.161 ms
-- Execution Time: 40.008 ms

-- PEOPLE WITH HIGHER THAN AVG NUMBER OF FRIENDS
SELECT * FROM (SELECT source, count(source) as count from edges GROUP BY source)t
 WHERE count > (SELECT AVG(count) FROM(SELECT COUNT(destination) AS count FROM edges GROUP BY destination)t1);
--  Planning Time: 0.234 ms
--  Execution Time: 61.761 ms

-- PEOPLE WITH K NUMBER OF FRIENDS
SELECT * FROM (SELECT source, count(source) as count from edges GROUP BY source)t WHERE count = 10;
-- Planning Time: 0.187 ms
-- Execution Time: 40.350 ms

-- GIVEN K PEOPLE, CHECK IF A PERSON WHO IS MUTUAL FRIENDS WITH ALL OF THEM, EXISTS
SELECT destination FROM edges WHERE source=0 INTERSECT SELECT destination FROM edges WHERE source=10;
--  Planning Time: 0.149 ms
--  Execution Time: 26.339 ms