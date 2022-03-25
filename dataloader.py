import psycopg2
import csv
import os

conn = None


def connect():
    """ Connect to the PostgreSQL database server """
    global conn
    try:
        # read connection parameters

        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect("dbname=facebook user=pramod1")

        # create a cursor
        cur = conn.cursor()

        print('PostgreSQL database version:')
        cur.execute('SELECT version()')

        # display the PostgreSQL database server version
        db_version = cur.fetchone()
        print(db_version)

        # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


def createTables():
    cur = conn.cursor()
    try:
        cur.execute(
            "CREATE TABLE IF NOT EXISTS edges (source integer, destination integer);")
        cur.execute(
            "CREATE TABLE IF NOT EXISTS circles (source integer, circle_number integer, member integer);")
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

    conn.commit()  # <--- makes sure the change is shown in the database


def loadEdgeData():
    cur = conn.cursor()
    insertQuery = "INSERT INTO edges(source, destination) VALUES (%s, %s)"
    try:
        with open('facebook_combined.txt', 'r') as file:
            reader = csv.reader(file, delimiter=' ')
            for src, dest in reader:
                data = (int(src), int(dest))
                cur.execute(insertQuery, data)
                conn.commit()
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


def loadCircleData():
    circleFiles = []
    for file in os.listdir("/users/pramod1/dev/facebook"):
        if file.endswith(".circles"):
            circleFiles.append(os.path.join(
                "/users/pramod1/dev/facebook", file))
    cur = conn.cursor()
    insertQuery = "INSERT INTO circles(source, circle_number, member) VALUES (%s, %s, %s)"
    try:
        for fileName in circleFiles:
            source = os.path.basename(fileName)
            source = os.path.splitext(source)[0]
            with open(fileName, 'r') as file:
                lines = file.readlines()
                for line in lines:
                    entries = line.split('\t')
                    circleNumber = entries[0].replace("circle",'')
                    for i in range(1,len(entries)):
                        data = (int(source), int(circleNumber), int(entries[i]))
                        cur.execute(insertQuery, data)
                        conn.commit()
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


if __name__ == '__main__':
    connect()
    createTables()
    # loadEdgeData()
    loadCircleData()
    if conn is not None:
        conn.close()
        print('Database connection closed.')
