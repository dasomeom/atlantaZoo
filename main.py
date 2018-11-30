from flask import Flask, request, render_template, redirect, url_for, flash, Blueprint
from flaskext.mysql import MySQL
from wtforms import Form, StringField, PasswordField, validators

from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.secret_key = b'gomtaengtang'

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = '1234'
app.config['MYSQL_DATABASE_DB'] = 'atlzoo'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)




@app.route('/', methods=['GET', 'POST'])
def index():
    return redirect(url_for('login'))


@app.route('/login', methods=['GET', 'POST'])
def login():
    return render_template('Login.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        if 'renderReg' in request.form:
            return render_template('Register.html')
        elif 'cancelReg' in request.form:
            return redirect(url_for('login'))
        elif 'regVis' in request.form:
            db_name = 'visitors'
        else:
            db_name = 'staff'
        signal = RegisterUser(request.form, db_name)
        if signal:
            return redirect(url_for('login'))
        else:
            return redirect(url_for('register'))
    return render_template('Register.html')

def RegisterUser(list, db_name):
    if len(list) == 5:
        conn = mysql.connect()
        cursor = conn.cursor()

        email = str(list['email'])
        username = str(list['username'])
        password = generate_password_hash(str(list['password']))
        password2 = str(list['password2'])

        move_to_login = False
        if check_password_hash(password, password2):
            cursor.execute("SELECT * FROM " + db_name + " WHERE Username = %s", (username))
            if cursor.fetchone() == None:
                cursor.execute("INSERT INTO " + db_name + " (Username, Password, Email) VALUES(%s, %s, %s)", (username, password, email))
                conn.commit()
                move_to_login = True
            else:
                flash('Username already exists')
        else:
            flash('Passwords do not match')
        cursor.close()
        return move_to_login


if __name__ == '__main__':
    app.run()