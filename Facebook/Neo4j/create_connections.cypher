
# Delete all nodes and relationships
MATCH  (n)
DETACH DELETE n


LOAD CSV WITH HEADERS FROM 'file:////facebook_combined.csv' AS row FIELDTERMINATOR " "
MERGE (c:Person {id: row.p1})
MERGE (d:Person {id: row.p2})
RETURN row

MATCH (n:Person)
RETURN COUNT(n)

LOAD CSV WITH HEADERS FROM 'file:////facebook_combined.csv' AS row FIELDTERMINATOR " " MATCH (j:Person {id: row.p1})
MATCH (m:Person {id: row.p2})
MERGE (j)-[r:IS_FRIENDS_WITH]-(m)
RETURN j, r, m

MATCH (p:Person{id:'339'})-[rel:IS_FRIENDS_WITH]-(c:Person)
RETURN COUNT(c);

