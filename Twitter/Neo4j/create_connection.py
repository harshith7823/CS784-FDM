from neo4j import GraphDatabase
import logging
from neo4j.exceptions import ServiceUnavailable
import os

class App:

    def __init__(self, uri, user, password):
        self.driver = GraphDatabase.driver(uri, auth=(user, password))

    def close(self):        
        self.driver.close()

    def create_connection(self, src, dest):
        with self.driver.session() as session:
            result = session.write_transaction(self._create_connection, src, dest)            
            print("Created connection ", result)

    @staticmethod
    def _create_connection(tx, src, dest):
        query = (
            "MERGE (c:Person {id: $src})" 
            "MERGE (d:Person {id: $dest})"
            "MERGE (c)-[r:FOLLOWS]->(d)"
            "RETURN c,d"
        )
        result = tx.run(query, src=src, dest=dest)
        try:
            return [{"p1": row["c"]["id"], "p2": row["d"]["id"]} for row in result]
        except ServiceUnavailable as exception:
            logging.error("{query} raised an error: \n {exception}".format(
                query=query, exception=exception))
            raise

if __name__ == "__main__":
    # uri = "neo4j+s://3cc782b6.databases.neo4j.io"
    # user = "neo4j"
    # password = "9-2lE7ssrtt09vCiRWoV8IH2F_RyiFlV7zSIEF5eiR0"
    uri = "neo4j://localhost:7687"
    user = "neo4j"
    password = "paraschous"
    app = App(uri, user, password)       
    file = open('../twitter_combined.csv', 'r')
    for line in file.readlines():
        line = line.split(" ")  
        app.create_connection(line[0], line[1])
    app.close()




    