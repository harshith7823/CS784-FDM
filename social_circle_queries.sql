-- All members of the social circle A
SELECT * FROM circles WHERE circle_info='circle0_0';

-- ARE TWO PEOPLE A AND B PART OF A COMMON CIRCLE
SELECT circle_info FROM circles WHERE member=245 INTERSECT SELECT circle_info FROM circles WHERE member=71;

-- ALL CIRCLES PERSON ‘A’  IS PART OF
SELECT circle_info FROM circles WHERE member=0;

-- GIVEN CIRCLE A AND B, FIND COMMON PEOPLE
SELECT member FROM circles WHERE circle_info='circle0_0'
INTERSECT SELECT member FROM circles WHERE circle_info='circle1_0';

-- NUMBER OF CIRCLES IN THE GRAPH
SELECT COUNT(DISTINCT(circle_info)) FROM circles;

-- K LARGEST SOCIAL CIRCLES
SELECT circle_info, COUNT(circle_info) AS count FROM circles GROUP BY circle_info ORDER BY count DESC LIMIT 10;

-- K SMALLEST SOCIAL CIRCLES
SELECT circle_info, COUNT(circle_info) AS count FROM circles GROUP BY circle_info ORDER BY count ASC LIMIT 10;

-- NUMBER OF GROUPS WITH ONLY 2 MEMBERS
SELECT circle_info FROM (SELECT circle_info, COUNT(circle_info) AS count FROM circles GROUP BY circle_info)t WHERE count=2;

-- AVERAGE CIRCLE SIZE
SELECT AVG(count) FROM (SELECT circle_info, COUNT(circle_info) AS count FROM circles GROUP BY circle_info)t;

-- IS CIRCLE ‘A’ A SUBSET OF CIRCLE ‘B’
SELECT (
    array_agg(member) <@ (SELECT array_agg(member) FROM circles WHERE circle_info='circle10_3437'))
    AS is_contained FROM circles WHERE circle_info='circle25_1912';