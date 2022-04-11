import psycopg2
import csv
import os

conn = None


def connect(dbname):
    """ Connect to the PostgreSQL database server """
    global conn
    try:
        # read connection parameters

        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect("dbname="+dbname +" user=akul")

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
            "CREATE TABLE IF NOT EXISTS circles (circle_info varchar, member integer);")
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

    conn.commit()  # <--- makes sure the change is shown in the database


def loadEdgeData(path):
    m = set()
    cur = conn.cursor()
    insertQuery = "INSERT INTO edges(source, destination) VALUES (%s, %s)"
    try:
        with open(path, 'r') as file:
            reader = csv.reader(file, delimiter=' ')
            for src, dest in reader:
                data = (int(src), int(dest))
                if data not in m:
                    cur.execute(insertQuery, data)
                    conn.commit()
                    m.add(data)
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


def loadCircleData(path):
    circleFiles = []
    for file in os.listdir(path):
        if file.endswith(".circles"):
            circleFiles.append(os.path.join(
                path, file))
    cur = conn.cursor()
    insertQuery = "INSERT INTO circles(circle_info, member) VALUES (%s, %s)"
    try:
        for fileName in circleFiles:
            source = os.path.basename(fileName)
            source = os.path.splitext(source)[0]
            with open(fileName, 'r') as file:
                lines = file.readlines()
                for line in lines:
                    entries = line.split('\t')
                    circleInfo=entries[0]+"_" + source
                    for i in range(1,len(entries)):
                        data = (circleInfo, int(entries[i]))
                        cur.execute(insertQuery, data)
                        conn.commit()
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


if __name__ == '__main__':
    #connect("facebook")
    # createTables()
    # loadEdgeData("/users/akul/facebook_combined.txt")
    # loadCircleData("/users/akul/facebook/")

    connect("twitter")
    createTables()
    loadEdgeData("/users/akul/twitter_combined.txt")
    loadCircleData("/users/akul/twitter/")
    if conn is not None:
        conn.close()
        print('Database connection closed.')
