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



