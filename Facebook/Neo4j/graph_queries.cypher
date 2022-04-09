// Friends of A:

WITH '0' AS A
MATCH (p:Person{id:A})-[rel:IS_FRIENDS_WITH]-(c:Person) 
RETURN c;

// 2nd circle friends of A:

WITH '0' AS A
MATCH (p:Person{id:A})-[rel:IS_FRIENDS_WITH]-(c:Person)
MATCH (c)-[rel:IS_FRIENDS_WITH]-(d:Person)
RETURN d;


// Mutual friends of A and B:

WITH '0' AS A, '59' AS B
MATCH (p:Person{id:A})-[:IS_FRIENDS_WITH]-(c:Person), ((c)-[:IS_FRIENDS_WITH]-(:Person{id:B}))
RETURN c;


// Friends of A who are not friends with B :

WITH '0' AS A, '59' AS B
MATCH (p:Person{id:A})-[:IS_FRIENDS_WITH]-(c:Person)
WHERE NOT exists ((c)-[:IS_FRIENDS_WITH]-(:Person{id:B}))
RETURN c;


// 10 MOST POPULAR PEOPLE :

MATCH (p:Person)-[:IS_FRIENDS_WITH]-(c:Person)
RETURN p.id,count(c)
ORDER BY count(c) desc LIMIT 10


// 10 LEAST POPULAR PEOPLE :

MATCH (p:Person)-[:IS_FRIENDS_WITH]-(c:Person)
RETURN p.id,count(c)
ORDER BY count(c) asc LIMIT 10



// AVERAGE NUMBER OF FRIENDS

MATCH (n:Person)
RETURN avg(size((n)--())) 


// PEOPLE WITH HIGHER THAN AVG NUMBER OF FRIENDS

MATCH (n:Person)
WITH avg(size((n)--())) AS average
MATCH (p:Person)
WHERE size((p)--()) > average
RETURN p


// PEOPLE WITH K NUMBER OF FRIENDS

WITH 10 AS K
MATCH (p:Person)
WHERE size((p)--()) = K
RETURN p.id


// GIVEN K PEOPLE, CHECK IF A PERSON WHO IS MUTUAL FRIENDS WITH ALL OF THEM, EXISTS

WITH '10' AS f1, '1' AS f2
MATCH (p:Person)-[:IS_FRIENDS_WITH]-(c:Person{id:f1})
MATCH (p)-[:IS_FRIENDS_WITH]-(d:Person{id:f2})
RETURN p.id



