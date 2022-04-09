-- All members of the social circle A
SELECT * FROM circles WHERE circle_info='circle0_0';
--  Planning Time: 0.238 ms
--  Execution Time: 1.227 ms

-- ARE TWO PEOPLE A AND B PART OF A COMMON CIRCLE
SELECT circle_info FROM circles WHERE member=245 INTERSECT SELECT circle_info FROM circles WHERE member=71;
--  Planning Time: 0.191 ms
--  Execution Time: 2.199 ms

-- ALL CIRCLES PERSON ‘A’  IS PART OF
SELECT circle_info FROM circles WHERE member=0;
--  Planning Time: 0.067 ms
--  Execution Time: 1.124 ms

-- GIVEN CIRCLE A AND B, FIND COMMON PEOPLE
SELECT member FROM circles WHERE circle_info='circle0_0'
    INTERSECT SELECT member FROM circles WHERE circle_info='circle1_0';
--  Planning Time: 0.174 ms
--  Execution Time: 2.309 ms

-- NUMBER OF CIRCLES IN THE GRAPH
SELECT COUNT(DISTINCT(circle_info)) FROM circles;
--  Planning Time: 0.059 ms
--  Execution Time: 11.279 ms

-- K LARGEST SOCIAL CIRCLES
SELECT circle_info, COUNT(circle_info) AS count FROM circles GROUP BY circle_info ORDER BY count DESC LIMIT 10;
--  Planning Time: 0.100 ms
--  Execution Time: 4.350 ms

-- K SMALLEST SOCIAL CIRCLES
SELECT circle_info, COUNT(circle_info) AS count FROM circles GROUP BY circle_info ORDER BY count ASC LIMIT 10;
--  Planning Time: 0.099 ms
--  Execution Time: 4.207 ms

-- NUMBER OF GROUPS WITH ONLY 2 MEMBERS
SELECT circle_info FROM (SELECT circle_info, COUNT(circle_info) AS count FROM circles GROUP BY circle_info)t WHERE count=2;
--  Planning Time: 0.157 ms
--  Execution Time: 4.145 ms

-- AVERAGE CIRCLE SIZE
SELECT AVG(count) FROM (SELECT circle_info, COUNT(circle_info) AS count FROM circles GROUP BY circle_info)t;
--  Planning Time: 0.114 ms
--  Execution Time: 4.240 ms

-- IS CIRCLE ‘A’ A SUBSET OF CIRCLE ‘B’
SELECT (
    array_agg(member) <@ (SELECT array_agg(member) FROM circles WHERE circle_info='circle10_3437'))
    AS is_contained FROM circles WHERE circle_info='circle25_1912';
--  Planning Time: 0.206 ms
--  Execution Time: 2.379 ms