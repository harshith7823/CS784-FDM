// All members of the social circle A

WITH 'circle0_0' AS A
MATCH (p:Person)-[rel:IS_PART_OF_CIRCLE]->(c:Circle{id:A}) 
RETURN (p.id);


// ARE TWO PEOPLE A AND B PART OF A COMMON CIRCLE

WITH '0' AS A, '71' AS B
MATCH (p:Person{id:A})-[:IS_PART_OF_CIRCLE]->(c:Circle),(Q:Person{id:B})-[:IS_PART_OF_CIRCLE]->(c)
RETURN (c.id);


// ALL CIRCLES PERSON ‘A’  IS PART OF

WITH '0' AS A
MATCH (p:Person{id:A})-[:IS_PART_OF_CIRCLE]->(c:Circle)
RETURN (c.id);

// GIVEN CIRCLE A AND B, FIND COMMON PEOPLE

WITH 'circle0_0' AS A, 'circle1_0' AS B
MATCH (p:Person)-[:IS_PART_OF_CIRCLE]->(:Circle{id:A}),(p)-[:IS_PART_OF_CIRCLE]->(:Circle{id:B})
RETURN (p.id);


// NUMBER OF CIRCLES IN THE GRAPH

MATCH (c:Circle)
RETURN COUNT(c);

// K LARGEST SOCIAL CIRCLES

MATCH (p:Person)-[:IS_PART_OF_CIRCLE]->(c:Circle)
RETURN (c.id),COUNT(p)
ORDER BY count(p) desc LIMIT 10


// K SMALLEST SOCIAL CIRCLES

MATCH (p:Person)-[:IS_PART_OF_CIRCLE]->(c:Circle)
RETURN (c.id),COUNT(p)
ORDER BY count(p) asc LIMIT 10


// NUMBER OF GROUPS WITH ONLY 2 MEMBERS

WITH 2 AS K
MATCH (p:Person)-[:IS_PART_OF_CIRCLE]->(c:Circle)
WHERE size((c)--()) = K
RETURN (c.id)


// NUMBER OF GROUPS WITH K MEMBERS

WITH 2 AS K
MATCH (p:Person)-[:IS_PART_OF_CIRCLE]->(c:Circle)
WHERE size((c)--()) = K
RETURN (c.id)


// AVERAGE CIRCLE SIZE

MATCH (n:Circle)
RETURN avg(size((n)--()))


//  IS CIRCLE ‘A’ A SUBSET OF CIRCLE ‘B’

WITH 'circle25_1912' AS A, 'circle10_3437' AS B
MATCH (p:Person)-[:IS_PART_OF_CIRCLE]->(c:Circle{id:A}), (r:Person)-[:IS_PART_OF_CIRCLE]->(d:Circle{id:B})
WITH collect(p.id) AS plist, collect(r.id) AS rlist
// WITH ["3437"] AS plist, collect(r.id) AS rlist
RETURN
CASE size([label IN plist WHERE label IN rlist])
WHEN size(plist) THEN "YES"
ELSE "NO"
END














