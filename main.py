from flask import Flask, request
from flaskext.mysql import MySQL

from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine


app = Flask(__name__)

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = '1234'
app.config['MYSQL_DATABASE_DB'] = 'atlzoo'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

conn = mysql.connect()
cursor = conn.cursor()

cursor.execute("SELECT * FROM admins")
data = cursor.fetchone()
print data
@app.route('/', methods=['GET', 'POST'])
def hello_world():
    print data
    return 'aha'

if __name__ == '__main__':
    app.run()