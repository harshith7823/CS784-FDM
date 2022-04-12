
// People A follows:

WITH '0' AS A
MATCH (p:Person{id:A})-[rel:FOLLOWS]->(c:Person)
RETURN c;

// People followed by A:

WITH '0' AS A
MATCH (p:Person)-[rel:FOLLOWS]->(c:Person{id:A})
RETURN p;


// Followers of A's followers:

WITH '0' AS A
MATCH (:Person{id:A})<-[:FOLLOWS]-(c:Person)
MATCH (c)<-[:FOLLOWS]-(d:Person)
RETURN d;


// People followed by both of A and B:

WITH '0' AS A, '59' AS B
MATCH (:Person{id:A})-[:FOLLOWS]->(c:Person),((:Person{id:B})-[:FOLLOWS]->(c))
RETURN c;


// People A follows but B doesn't:

WITH '0' AS A, '59' AS B
MATCH (p:Person{id:A})-[:FOLLOWS]->(c:Person)
WHERE NOT exists ((:Person{id:B})-[:FOLLOWS]->(c))
RETURN c;


// 10 MOST POPULAR PEOPLE :

MATCH (p:Person)<-[:FOLLOWS]-(c:Person)
RETURN p.id,count(c)
ORDER BY count(c) desc LIMIT 10


// 10 LEAST POPULAR PEOPLE :

MATCH (p:Person)<-[:FOLLOWS]-(c:Person)
RETURN p.id,count(c)
ORDER BY count(c) asc LIMIT 10


// AVERAGE NUMBER OF FOLLOWERS

MATCH (n:Person)
RETURN avg(size((n)--())) 


// PEOPLE WITH HIGHER THAN AVG NUMBER OF FOLLOWERS

MATCH (n:Person)
WITH avg(size((n)--())) AS average
MATCH (p:Person)
WHERE size((p)--()) > average
RETURN p


// PEOPLE WITH K NUMBER OF FOLLOWERS

WITH 10 AS K
MATCH (p:Person)
WHERE size((p)--()) = K
RETURN p.id

