from flask import Flask, request
import flask
import mysql.connector

DATABASE_USER = 'phpmyadmin'
DATABASE_PASSWORD = '123456'
DATABASE_HOST = 'localhost'
DATABASE_NAME = 'gearbox_academy_logistics'

app = Flask(__name__)
app.secret_key = "jiugyfhafd76e48w3yrgeurbgi7846e7rt"

my_db = mysql.connector.connect(
    host=DATABASE_HOST,
    user=DATABASE_USER,
    password=DATABASE_PASSWORD,
    database=DATABASE_NAME
)
my_cursor = my_db.cursor()


@app.route('/', methods=['GET'])
def index():
    if not flask.session.get('logged_in'):
        return flask.redirect(flask.url_for('login'))
    return flask.render_template('home.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if 'submit' in request.form:
        email = request.form['email']
        password = request.form['password']

        my_cursor.execute(f'SELECT * FROM users WHERE email=\'{email}\' AND password=\'{password}\'')

        result = my_cursor.fetchall()

        if len(result) == 0:
            return 'Invalid username or password. <a href="/login">Go back?</a>'
        else:
            # here user has logged in
            flask.session['logged_in'] = True
            return flask.redirect(flask.url_for('index'))





    else:
        return flask.render_template('login.html')


@app.route('/logout', methods=['GET'])
def logout():
    if flask.session.get('logged_in'):
        flask.session.clear()
    return flask.redirect(flask.url_for('login'))


if __name__ == '__main__':
    app.run(threaded=True, port=5000, debug=False)
