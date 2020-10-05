import subprocess as sp
import pymysql
import pymysql.cursors
from tabulate import tabulate
from datetime import datetime
now = datetime.now()
# row["age"] = now.year - dob.year - ((today.month, today.day) < (born.month, born.day))


def viewTable(rows):

    a = []
    try:
        a.append(list(rows[0].keys()))
    except:
        print("\n-----------------\nEMPTY TABLE\n-----------------\n")
        return
    for row in rows:
        b = []
        for k in row.keys():
            b.append(row[k])
        a.append(b)
    print(tabulate(a, tablefmt="psql", headers="firstrow"))
    print()
    return


def view():
    print("\nChoose the data that you want to see.\n\n")
    print("1.   VISITORS")  # selection
    print("2.   STAFF")
    print("3.   ATTRACTIONS")
    print("4.   TICKETS")
    print("5.   MAINTAINANCE SCHEDULE")
    print("6.   TICKET TYPES AND COST")
    print("7.   LIST ALL MANAGEMENT STAFF")  # Projection
    print("8.   LIST ALL MAINTAINING STAFF")
    print("9.   LIST ALL OPERATING STAFF")
    print("10.  TOTAL PRICE FOR PHOTOS FOR A VISITOR")  # aggregation
    print("11:  PHOTOS OF A PERSON ")
    print("12.  NUMBER OF VISITORS PER DAY")
    print("13.  NUMBER OF VISITORS ON WEEKEND")
    print("14:  POPULAR ATTRACTIONS")  # analysis
    print("15.  MOST PHOTOS TAKEN ATTRACTION")
    # need search by text
    print("\n")
    ch = input("Enter: ")

    if ch == '1':
        query = "SELECT * FROM VISITOR"
    elif ch == '2':
        query = "SELECT * FROM STAFF"
    elif ch == '3':
        query = "SELECT * FROM ATTRACTION"
    elif ch == '4':
        query = "SELECT * FROM TICKET"
    elif ch == '5':
        query = "SELECT * FROM MAINTAINANCE_SCHEDULE"
    elif ch == '6':
        query = "SELECT * FROM TICKET_COST"
    elif ch == '7':
        query = """SELECT fname,lname,sex from STAFF where position="Manager";"""
    elif ch == '8':
        query = """SELECT fname,lname,sex from STAFF where position="Maintainer";"""
    elif ch == '9':
        query = """SELECT fname,lname,sex from STAFF where position="Operator";"""
    elif ch == '10':
        ticketid = int(input("TICKET ID: "))
        query = "SELECT SUM(photo_cost) as TOTAL_COST FROM ((SELECT photo_size FROM PHOTO WHERE ticket_id=%d) as P INNER JOIN PHOTO_COST as C ON P.photo_size=C.photo_size)" % (ticketid)
    elif ch == '11':
        ticketid = int(input("TICKET ID: "))
        query = "select photo_time AS TIME ,attraction_id AS LOCATION,photo_cost AS COST from ((select photo_time,photo_size,attraction_id from PHOTO where ticket_id=%d) as P INNER JOIN PHOTO_COST as C ON P.photo_size=C.photo_size)" % (
            ticketid)
    elif ch == '12':
        query = "SELECT COUNT(*) as NUMBER_OF_VISITORS,DATE(issued_time) as DATE FROM TICKET GROUP BY DATE(issued_time)"
    elif ch == '13':
        query = "SELECT COUNT(*) as NUMBER_OF_VISITORS,WEEKDAY(issued_time) as DAY FROM TICKET WHERE WEEKDAY(issued_time)=5 OR WEEKDAY(issued_time)=6 GROUP BY WEEKDAY(issued_time)"
    elif ch == '14':
        query = "select D.attraction_id as ATTRACTION from (select COUNT(*) as count,attraction_id from VISITED_ATTRACTIONS group by attraction_id) as D inner join (select AVG(count) as avg from (select COUNT(*) as count from VISITED_ATTRACTIONS group by attraction_id) as A ) as B ON D.count > B.avg"
    else:
        print("You have entered an invalid option.")
        return
    print(query)
    try:
        no_of_rows = cur.execute(query)
    except Exception as e:
        print(e)
        print("\n\nError!\n")
        return

    rows = cur.fetchall()
    viewTable(rows)
    con.commit()


def update():
    print("\nChoose the data that you want to update.\n\n")
    print("1.   Staff")
    print("2.   Visitor")
    print("3.   Photo")
    print("4.   Attraction")
    print("5.   Maintainance Schedule")
    print("\n")
    ch = int(input("Enter: "))
    if ch == 1:
        l = 0
        query = "UPDATE STAFF "
        query2 = "WHERE "
        row = ["id", "fname", "lname", "sex", "date_of_birth", "join_date", "working_hours",
               "position", "salary", "door_no", "street", "pincode", "attraction_id"]
        for i in row:
            if input('update %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                if l == 0:
                    query += "SET %s=\"%s\"," % (i, inp)
                    l = 1
                else:
                    query += "%s=\"%s\"," % (i, inp)
        for i in row:
            if input('use as condition %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                query2 += "%s=\"%s\" AND " % (i, inp)
    elif ch == 2:
        l = 0
        query = "UPDATE VISITOR "
        query2 = "WHERE "
        row = ["ssn", "date_of_birth", "fname", "lname", "sex"]
        for i in row:
            if input('update %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                if l == 0:
                    query += "SET %s=\"%s\"," % (i, inp)
                    l = 1
                else:
                    query += "%s=\"%s\"," % (i, inp)
        for i in row:
            if input('use as condition %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                query2 += "%s=\"%s\" AND " % (i, inp)
    elif ch == 3:
        l = 0
        query = "UPDATE PHOTO "
        query2 = "WHERE "
        row = ["ticket_id", "attraction_id", "photo_time", "photo_size"]
        for i in row:
            if input('update %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                if l == 0:
                    query += "SET %s=\"%s\"," % (i, inp)
                    l = 1
                else:
                    query += "%s=\"%s\"," % (i, inp)
        for i in row:
            if input('use as condition %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                query2 += "%s=\"%s\" AND " % (i, inp)
    elif ch == 4:
        l = 0
        query = "UPDATE ATTRACTION "
        query2 = "WHERE "
        row = ["attraction_id", "name", "for_adult", "for_child"]
        for i in row:
            if input('update %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                if l == 0:
                    query += "SET %s=\"%s\"," % (i, inp)
                    l = 1
                else:
                    query += "%s=\"%s\"," % (i, inp)
        for i in row:
            if input('use as condition %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                query2 += "%s=\"%s\" AND " % (i, inp)
    elif ch == 5:
        l = 0
        query = "UPDATE MAINTAINANCE_SCHEDULE "
        query2 = "WHERE "
        row = ["id", "attraction_id", "start_time", "end_time"]
        for i in row:
            if input('update %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                if l == 0:
                    query += "SET %s=\"%s\"," % (i, inp)
                    l = 1
                else:
                    query += "%s=\"%s\"," % (i, inp)
        for i in row:
            if input('use as condition %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                query2 += "%s=\"%s\" AND " % (i, inp)
    else:
        print("You have entered an invalid option.")
        return
    query = query[:-1]
    query += " "
    query2 = query2[0:-4]
    query += query2
    print(query)
    try:
        cur.execute(query)
        con.commit()
        print("Updated in Database")
    except Exception as e:
        print(e)
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", e)

    return


def insert():
    print("1.   Visitor")
    print("2.   Staff")
    print("3.   Attraction")
    print("4.   Ticket")
    print("5.   Photo")
    print("6.   Maintainance Schedule")
    print("\n")
    ch = input("Enter: ")
    if ch == '1':
        row = {}
        print("Enter visitor details: ")
        name = (input("Name (Fname Lname): ")).split(' ')
        row["fname"] = name[0]
        row["lname"] = name[1]
        row["ssn"] = input("SSN: ")
        row["dob"] = input("Birth Date (YYYY-MM-DD): ")
        row["sex"] = input("Sex (Male/Female|Others): ")
        query = "INSERT INTO VISITOR(ssn,date_of_birth,fname,lname,sex) VALUES ('%s','%s','%s','%s','%s')" % (
            row["ssn"], row["dob"], row["fname"], row["lname"], row["sex"])
    elif ch == '2':
        row = {}
        print("Enter staff details: ")
        name = (input("Name (Fname Lname): ")).split(' ')
        row["fname"] = name[0]
        row["lname"] = name[1]
        row["id"] = input("ID: ")
        row["dob"] = input("Birth Date (YYYY-MM-DD): ")
        row["sex"] = input("Sex (Male/Female|Others): ")
        row["jd"] = input("Join Date (YYYY-MM-DD): ")
        row["wh"] = input("Working Hours (Day1-Day2 Time1-Time2): ")
        row["position"] = input("Position (Manager/Maintainer/Operator): ")
        row["wa"] = int(input("Attraction: "))
        row["salary"] = input("Salary: ")
        row["do"] = input("Door number: ")
        row["street"] = input("Street: ")
        row["pin"] = input("Pincode: ")
        query = "INSERT INTO STAFF(id,fname,lname,sex,date_of_birth,join_date,working_hours,position,salary,door_no,street,pincode,attraction_id) VALUES ('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s')" % (
            row["id"], row["fname"], row["lname"], row["sex"], row["dob"], row["jd"], row[
                "wh"], row["position"], row["salary"], row["do"], row["street"], row["pin"], row["wa"]
        )
    elif ch == '3':
        row = {}
        print("Enter attraction details: ")
        row["name"] = (input("Name : "))
        row["id"] = input("ID: ")
        row["forchild"] = int(input("For child(1/0): "))
        row["foradult"] = int(input("For adult(1/0): "))
        query = "INSERT INTO ATTRACTION(attraction_id,name,for_child,for_adult) VALUES ('%s','%s',%d,%d)" % (
            row["id"], row["name"], row["forchild"], row["foradult"]
        )
    elif ch == '4':
        row = {}
        print("Enter ticket details: ")
        row["id"] = input("ID: ")
        row["ssn"] = input("SSN: ")
        row["ticket_type"] = int(
            input("Ticket type (for_child 1 / for adult 2): "))
        row["sid"] = input("Issued by: ")
        query = "INSERT INTO TICKET(ticket_id,ssn,ticket_type,staff_id) VALUES ('%s','%s',%d,'%s')" % (
            row["id"], row["ssn"], row["ticket_type"], row["sid"]
        )
    elif ch == '5':
        row = {}
        print("Enter photo details: ")
        row["ticket_id"] = input("Ticket ID: ")
        row["attraction_id"] = input("Attraction ID: ")
        row["photo_size"] = input("Photo size: ")
        query = "INSERT INTO PHOTO(ticket_id,attraction_id,photo_size) VALUES ('%s','%s','%s')" % (
                row["ticket_id"], row["attraction_id"], row["photo_size"])
    elif ch == '6':
        row = {}
        print("Enter Maintainance Schedule Details: ")
        row["id"] = input("Enter Staff ID: ")
        row["attraction_id"] = input("Enter Attraction ID: ")
        row["starttime"] = input("Enter Start time (YYYY-MM-DD HH:MM:SS): ")
        row["endtime"] = input("Enter End time (YYYY-MM-DD HH:MM:SS): ")
        query = "INSERT INTO MAINTAINANCE_SCHEDULE(maintainer,attraction_id,start_time,end_time) VALUES ('%s','%s','%s','%s') " % (
            row["id"], row["attraction_id"], row["starttime"], row["endtime"]
        )
    else:
        print("You have entered an invalid option.")
        return
    print(query)
    try:
        cur.execute(query)
        con.commit()
        print("Inserted Into Database")
    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)

    return


def owncommand():

    query = input("Enter Command: \n")
    try:
        no_of_rows = cur.execute(query)
    except Exception as e:
        print(e)
        con.rollback()
        print("Failed to execute")
        print(">>>>>>>>>>>>>", e)
        return

    rows = cur.fetchall()
    viewTable(rows)
    con.commit()

    return


def delete():

    print("\nChoose the data that you want to delete.\n\n")
    print("1.   Staff")
    print("2.   Visitor")
    print("3.   Photo")
    print("4.   Maintainance Schedule")
    print("\n")
    ch = int(input("Enter: "))
    if ch == 1:
        l = 0
        query = "DELETE FROM STAFF WHERE "
        row = ["id", "date_of_birth", "join_date", "fname", "lname",
               "sex", "attraction_id", "salary", "door_number", "street", "pincode"]
        for i in row:
            if input('Use %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                if l == 0:
                    query += " %s=\"%s\" " % (i, inp)
                    l = 1
                else:
                    query += " AND %s=\"%s\" " % (i, inp)
    elif ch == 2:
        l = 0
        query = "DELETE FROM VISITOR WHERE "
        row = ["ssn", "date_of_birth", "fname", "lname", "sex"]
        for i in row:
            if input('Use %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                if l == 0:
                    query += " %s=\"%s\" " % (i, inp)
                    l = 1
                else:
                    query += " AND %s=\"%s\" " % (i, inp)
    elif ch == 3:
        l = 0
        query = "DELETE FROM PHOTO WHERE "
        row = ["ticket_id", "attraction_id", "photo_time", "photo_size"]
        for i in row:
            if input('Use %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                if l == 0:
                    query += " %s=\"%s\" " % (i, inp)
                    l = 1
                else:
                    query += " AND %s=\"%s\" " % (i, inp)
    elif ch == 4:
        l = 0
        query = "DELETE FROM MAINTAINANCE_SCHEDULE WHERE "
        row = ["maintainer", "attraction_id", "start_time", "end_time"]
        for i in row:
            if input('Use %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                if l == 0:
                    query += " %s=\"%s\" " % (i, inp)
                    l = 1
                else:
                    query += " AND %s=\"%s\" " % (i, inp)
    elif ch == 6:
        l = 0
        query = "DELETE FROM MAINTAINANCE_SCHEDULE WHERE "
        row = ["maintainer", "attraction_id", "start_time", "end_time"]
        for i in row:
            if input('Use %s (y/n): ' % (i)) == 'y':
                inp = input("Enter %s: " % (i))
                if l == 0:
                    query += " %s=\"%s\" " % (i, inp)
                    l = 1
                else:
                    query += " AND %s=\"%s\" " % (i, inp)
    else:
        print("You have entered an invalid option.")
        return

    print(query)
    try:
        cur.execute(query)
        con.commit()
        print("Updated in Database")
    except Exception as e:
        print(e)
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", e)

    return


def check(ch):
    if(ch == 1):
        view()
    elif(ch == 2):
        insert()
    elif(ch == 3):
        update()
    elif(ch == 4):
        delete()
    elif(ch == 5):
        owncommand()
    else:
        print("Error: Invalid Option")


def refreshDatabase():
    global cur

    # Deleting incorrectly entered data in insert function
    # Have to write this function.
    print("Hello: Refreshing database")  # Test printline.


# Global
while(1):
    tmp = sp.call('clear', shell=True)
    # The two lines below should be uncommented
    # username = input("Username: ")
    # password = input("Password: ")

    username = 'root'
    password = 'sql'

    try:
        con = pymysql.connect(host='127.0.0.1',
                              user=username,
                              password=password,
                              db='project',
                              cursorclass=pymysql.cursors.DictCursor,
                              port=5005)
        tmp = sp.call('clear', shell=True)
        if(con.open):
            print("Connected")
        else:
            print("Failed to connect")

        tmp = input("Enter any key to CONTINUE>")

        with con.cursor() as cur:
            exit = 0
            while(1):
                tmp = sp.call('clear', shell=True)
                # refreshDatabase()
                print("1.   View Options")
                print("2.   Addition Options")
                print("3.   Update Options")
                print("4.   Delete Options")
                print("5.   Enter Own Commad")
                print("6.   Logout")
                ch = int(input("\nEnter: "))
                if(ch == 6):
                    print("Exiting.")
                    exit = 1
                    break
                else:
                    check(ch)
                    tmp = input("Enter any key to CONTINUE>")
        if exit == 1:
            break
    except:
        tmp = sp.call('clear', shell=True)
        print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
        tmp = input("Enter any key to CONTINUE>")
