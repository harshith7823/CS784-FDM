
# Delete all nodes and relationships
MATCH  (n)
DETACH DELETE n


LOAD CSV WITH HEADERS FROM 'https://drive.google.com/uc?id=1Nh08CL09TtgsKddVef9h_IwUc7ngTRZ-&export=download' AS row FIELDTERMINATOR " "
MERGE (c:Person {id: row.p1})
MERGE (d:Person {id: row.p2})
RETURN row

MATCH (n:Person)
RETURN COUNT(n)

LOAD CSV WITH HEADERS FROM 'https://drive.google.com/uc?id=1Nh08CL09TtgsKddVef9h_IwUc7ngTRZ-&export=download' AS row FIELDTERMINATOR " "
MATCH (j:Person {id: row.p1})
MATCH (m:Person {id: row.p2})
MERGE (j)-[r:FOLLOWS]->(m)
RETURN j, r, m

MATCH (p:Person{id:'221036078'})-[rel:FOLLOWS]->(c:Person)
RETURN COUNT(c);

