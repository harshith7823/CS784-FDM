LOAD CSV WITH HEADERS FROM 'https://drive.google.com/u/0/uc?id=16Xa5rup5dRkHEKVRen-QsPAPgrkXmPIZ&export=download' AS row FIELDTERMINATOR " "
MERGE (c:Personad {name: row.p1})
MERGE (d:Personad {name: row.p2})
RETURN row

MATCH (n:Personad)
RETURN n

LOAD CSV WITH HEADERS FROM 'https://drive.google.com/u/0/uc?id=16Xa5rup5dRkHEKVRen-QsPAPgrkXmPIZ&export=download' AS row FIELDTERMINATOR " "
MATCH (j:Personad {name: row.p1})
MATCH (m:Personad {name: row.p2})
MERGE (j)-[r:IS_FRIENDS_WITH]->(m)
RETURN j, r, m
