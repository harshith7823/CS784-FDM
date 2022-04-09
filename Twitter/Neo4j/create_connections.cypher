
# Delete all nodes and relationships
MATCH  (n)
DETACH DELETE n

LOAD CSV WITH HEADERS FROM 'file:////twitter_combined.csv' AS row FIELDTERMINATOR " " 
MERGE (c:Person {id: row.p1})
MERGE (d:Person {id: row.p2})
MERGE (c)-[r:FOLLOWS]->(d) RETURN COUNT(r);

MATCH (p:Person{id:'221036078'})-[rel:FOLLOWS]->(c:Person)
RETURN COUNT(c);

