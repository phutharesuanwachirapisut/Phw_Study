import sqlite3

connection_ = sqlite3.connect("chinook.db")
print("Connect Success!!")

cursor = connection_.execute("select * from customers as API;")
for row in cursor:
    print("CustomerID: ", row[0], row[1], row[2])
    print("----------------------")
connection_.close()
