from neo4j import GraphDatabase
import logging
from neo4j.exceptions import ServiceUnavailable
import os

class App:

    def __init__(self, uri, user, password):
        self.driver = GraphDatabase.driver(uri, auth=(user, password))

    def close(self):        
        self.driver.close()

    def create_circle(self, circle):
        with self.driver.session() as session:
            result = session.write_transaction(self._create_and_return_circle, circle)
            for row in result:
                print("Created circle : {p1}".format(p1=row['p1']))

    @staticmethod
    def _create_and_return_circle(tx, circle):
        query = (
            "MERGE (p1:Circle { id: $circle }) "
            "RETURN p1"
        )
        result = tx.run(query, circle=circle)
        try:
            return [{"p1": row["p1"]["id"]} for row in result]
        except ServiceUnavailable as exception:
            logging.error("{query} raised an error: \n {exception}".format(
                query=query, exception=exception))
            raise

    def add_node_to_circle(self, circle, person_id):
        with self.driver.session() as session:
            result = session.write_transaction(self._add_node_to_circle, circle, person_id)
            for row in result:
                print("Added node to circle : {p1}, {p2}".format(p1=row['p1'], p2=row['p2']))

    @staticmethod
    def _add_node_to_circle(tx, circle, person_id):
        query = (
            "MATCH (p1:Circle { id: $circle })"
            "MERGE (p2:Person { id: $person_id })"            
            "MERGE (p2)-[r:IS_PART_OF_CIRCLE]->(p1)"
            "RETURN p1, p2"
        )
        result = tx.run(query, circle=circle, person_id=person_id)
        try:
            return [{"p1": row["p1"]["id"], "p2": row["p2"]["id"]} for row in result]
        except ServiceUnavailable as exception:
            logging.error("{query} raised an error: \n {exception}".format(
                query=query, exception=exception))
            raise

if __name__ == "__main__":
    # Aura queries use an encrypted connection using the "neo4j+s" URI scheme
    uri = "neo4j+s://3cc782b6.databases.neo4j.io"
    user = "neo4j"
    password = "9-2lE7ssrtt09vCiRWoV8IH2F_RyiFlV7zSIEF5eiR0"
    app = App(uri, user, password)
    directory = "../facebook/"
    for filename in os.listdir(directory):        
        if filename.endswith(".circles"):            
            file = open(directory+filename, 'r')
            for line in file.readlines():
                line = line.split()
                circle_name = line[0]+"_"+filename[:len(filename)-8]                
                app.create_circle(circle_name)
                app.add_node_to_circle(circle_name, person_id=filename[:len(filename)-8]) 
                for person_id in line[1:]:
                    app.add_node_to_circle(circle_name, person_id)                
    app.close()




    