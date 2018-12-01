from flask import Flask, request, render_template, redirect, url_for, flash, session
from flaskext.mysql import MySQL

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
    if request.method == 'POST' and 'cancelReg' in request.form:
        return render_template('Login.html')
    elif request.method == 'POST' and 'login' in request.form:
        validated = loginHelper(request.form)
        if validated == 0:
            return render_template('visitorHomes.html')
        elif validated == 1:
            return render_template('staffhome.html')
        elif validated == 2:
            return render_template('adminhome.html')
        else:
            return render_template('badLogin.html')
    else:
        return render_template('Login.html')

def loginHelper(list):
    input_email = str(list['email'])
    input_password = str(list['password'])
    conn = mysql.connect()
    cursor = conn.cursor()
    db_names = ['visitors', 'staff', 'admins']
    for db in db_names:
        cursor.execute("SELECT * FROM " + db + " WHERE Email = %s", (input_email))
        data = cursor.fetchall()
        if len(data) == 1:
            username = data[0][0]
            password = data[0][1]
            if db == 'visitor':
                exception_password = ['password4', 'password5', 'password6', 'password7']
            elif db == 'staff':
                exception_password = ['password1', 'password2', 'password3']
            else:
                exception_password = ['adminpassword']
            if check_password_hash(password, input_password) or (password in exception_password and password == input_password):
                session['username'] = username
                if db == 'visitors':
                    return 0
                elif db == 'staff':
                    return 1
                else:
                    return 2
            else:
                return -1
    return -1


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
            if db_name == 'visitors':
                othername = 'staff'
            else:
                othername = 'visitors'
            cursor.execute("SELECT * FROM admins WHERE Username = %s", (username))
            notHaveName = cursor.fetchone() == None
            cursor.execute("SELECT * FROM " + othername + " WHERE Username = %s", (username))
            notHaveName = cursor.fetchone() == None and notHaveName
            cursor.execute("SELECT * FROM " + db_name + " WHERE Username = %s", (username))
            notHaveName = cursor.fetchone() == None and notHaveName

            cursor.execute("SELECT * FROM admins WHERE Email = %s", (email))
            notHaveEmail = cursor.fetchone() == None
            cursor.execute("SELECT * FROM " + othername + " WHERE Email = %s", (email))
            notHaveEmail = cursor.fetchone() == None and notHaveName
            cursor.execute("SELECT * FROM " + db_name + " WHERE Email = %s", (email))
            notHaveEmail = cursor.fetchone() == None and notHaveName

            if notHaveName and notHaveEmail:
                cursor.execute("INSERT INTO " + db_name + " (Username, Password, Email) VALUES(%s, %s, %s)", (username, password, email))
                conn.commit()
                move_to_login = True
            else:
                flash('Username or email already exists')
        else:
            flash('Passwords do not match')
        cursor.close()
        return move_to_login

@app.route('/logout', methods=['GET', 'POST'])
def logout():
    print session
    session.pop('username', None)
    session.clear()
    print session
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run()