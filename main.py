from flask import Flask, request  # for reading form data from client
import flask  # The framework for python's web development
import mysql.connector  # for connecting to MySQL database
import bcrypt  # for hashing passwords
import os  # for saving uploaded images to file system
import json  # for manipulating AJAX request data
import paho.mqtt.client as mqtt
import time
"""
    Set your MySQL's password here
"""
DATABASE_USER = 'root'
DATABASE_PASSWORD = ''
DATABASE_HOST = 'localhost'
DATABASE_NAME = 'gearbox_academy_logistics'

IMAGES_DIRECTORY = './static/images/'

app = Flask(__name__)
app.secret_key = "jiugyfhafd76e48w3yrgeurbgi7846e7rt"

my_db = mysql.connector.connect(
    host=DATABASE_HOST,
    user=DATABASE_USER,
    password=DATABASE_PASSWORD,
    database=DATABASE_NAME
)
my_cursor = my_db.cursor(dictionary=True)


#############################
# User section begins here  #
#############################

@app.route('/', methods=['GET'])
def index():
    if not flask.session.get('logged_in'):
        return flask.redirect(flask.url_for('login'))

    def make_ordinal(n):
        """
        Convert an integer into its ordinal representation::

            make_ordinal(0)   => '0th'
            make_ordinal(3)   => '3rd'
            make_ordinal(122) => '122nd'
            make_ordinal(213) => '213th'
        """
        n = int(n)
        if 11 <= (n % 100) <= 13:
            suffix = 'th'
        else:
            suffix = ['th', 'st', 'nd', 'rd', 'th'][min(n % 10, 4)]
        return str(n) + suffix

    user_id = flask.session.get('user_id')

    my_cursor.execute('SELECT DISTINCT item_id FROM logs WHERE user_id = %s', (user_id,))
    items = my_cursor.fetchall()

    labels = []
    days_labels = []

    explode_first_pie_chart = True

    for item in items:
        my_cursor.execute('SELECT name FROM items WHERE id = %s', (item.get('item_id'),))
        name = my_cursor.fetchone().get('name')

        my_cursor.execute('SELECT count(item_id) FROM logs WHERE item_id = %s ORDER BY COUNT(item_id)',
                          (item.get('item_id'),))
        count = my_cursor.fetchone().get('count(item_id)')

        if explode_first_pie_chart:
            labels.append({
                'label': name,
                'exploded': 'true',
                'y': count
            })
            explode_first_pie_chart = False
        else:
            labels.append({
                'label': name,
                'y': count
            })
    # might not work well at the beginning of a month or a year
    # above solved now
    my_cursor.execute('SELECT DATE_FORMAT(date_time, "%d") AS date FROM logs'
                      ' WHERE user_id = %s AND  MONTH(date_time) = MONTH(CURRENT_DATE()) '
                      'AND YEAR(date_time) = YEAR(CURRENT_DATE()) ORDER BY date_time ASC',
                      (user_id,))
    dates = my_cursor.fetchall()
    dates = [d['date'] for d in dates]
    dates_set = list(set(dates))
    dates_set.sort()

    for date in dates_set:
        days_labels.append({
            'label': make_ordinal(date),
            'y': dates.count(date)
        })

    return flask.render_template('home.html', labels=labels, days_labels=days_labels)


@app.route('/logout', methods=['GET'])
def logout():
    flask.session.clear()
    return flask.redirect(flask.url_for('index'))


@app.route('/login', methods=['GET', 'POST'])
def login():
    if 'submit' in request.form:
        email = request.form['email']
        password = request.form['password']

        my_cursor.execute(f'SELECT * FROM users WHERE email=%s', (email,))
        result = my_cursor.fetchall()
        if len(result) == 0:
            flask.session['error-message'] = f'User with this email "{email}" does not exist'
            return flask.render_template('login.html')

        hashed_password = result[0].get('password')
        if not bcrypt.checkpw(password.encode('utf-8'), hashed_password.encode('utf-8')):
            flask.session['error-message'] = f'You Entered A Wrong Password'
            return flask.render_template('login.html')

        # here user has logged in successfully
        flask.session['logged_in'] = True
        flask.session['user_id'] = result[0].get('id')
        flask.session['user'] = result[0]
        return flask.redirect(flask.url_for('index'))

    else:
        return flask.render_template('login.html')


@app.route('/edit-profile', methods=['GET', 'POST'])
def edit_profile():
    if not flask.session.get('logged_in'):
        return flask.redirect(flask.url_for('login'))

    user_id = flask.session.get('user_id')

    if 'submit' in request.form:
        first_name = request.form['firstname']
        second_name = request.form['lastname']
        mobile = request.form['mobile']

        my_cursor.execute('UPDATE users SET first_name=%s, second_name=%s, mobile=%s WHERE id = %s',
                          (first_name, second_name, mobile, user_id))
        my_db.commit()

        if not request.form['password'] == '':
            # here is where we hash our passwords to store them securely
            hashed_password = bcrypt.hashpw(request.form['password'].encode('utf-8'), bcrypt.gensalt())
            my_cursor.execute('UPDATE users SET password=%s WHERE id = %s', (hashed_password, user_id))
            my_db.commit()

        if not request.files['photo'].filename == '':
            photo = request.files['photo']
            image_path = f'users/{second_name}-{photo.filename}'
            photo.save(os.path.join(IMAGES_DIRECTORY, image_path))

            my_cursor.execute('UPDATE users SET profile_pic=%s WHERE id = %s', (image_path, user_id))
            my_db.commit()

        my_cursor.execute(f'SELECT * FROM users WHERE id=%s', (user_id,))
        user = my_cursor.fetchone()
        flask.session['user'] = user

        flask.session['success-message'] = f'Details updated successfully'
        return flask.redirect(flask.url_for('index'))

    my_cursor.execute(f'SELECT * FROM users WHERE id=%s', (user_id,))
    user = my_cursor.fetchone()

    return flask.render_template('edit-profile.html', user=user)


@app.route('/search-items', methods=['GET', 'POST'])
def search_items():
    # first check if user is logged in
    if not flask.session.get('logged_in'):
        return flask.redirect(flask.url_for('login'))

    if 'add-item-to-cart' in request.form:
        item_id = request.form['id']
        user_id = flask.session.get('user_id')

        my_cursor.execute('INSERT INTO cart (user_id, item_id, quantity) '
                          'VALUES (%s,%s,"1")',
                          (user_id, item_id))
        my_db.commit()

        my_cursor.execute('SELECT name FROM items WHERE id = %s', (item_id,))
        result = my_cursor.fetchone()

        return flask.jsonify(result)

    my_cursor.execute(f'SELECT * FROM items')
    items = my_cursor.fetchall()

    return flask.render_template('search-items.html', items=items)


@app.route('/checkout', methods=['GET', 'POST'])
def checkout():
    # first check if user is logged in
    if not flask.session.get('logged_in'):
        return flask.redirect(flask.url_for('login'))

    user_id = flask.session.get('user_id')

    if 'delete-item-from-cart' in request.form:
        item_id = request.form['id']
        my_cursor.execute('DELETE FROM cart WHERE user_id = %s AND item_id = %s', (user_id, item_id))
        my_db.commit()

        my_cursor.execute('SELECT id,name FROM items WHERE id = %s', (item_id,))
        result = my_cursor.fetchone()

        return flask.jsonify(result)
    elif 'open-locks' in request.form:
        items = request.form['items']

        shelves_to_open = []


        for item in json.loads(items):
            my_cursor.execute('SELECT shelf,drawer FROM items WHERE id = %s', (item.get('id'),))
            result = my_cursor.fetchone()
            shelves_to_open.append(result.get('shelf'))

            my_cursor.execute('INSERT INTO logs (user_id, item_id, quantity)'
                              'VALUES (%s,%s,%s)', (user_id, item.get('id'), item.get('quantity')))
            my_db.commit()

        # here is where we should communicate with the nodeMcu to open locks

        # MQTT SECTION
        client = mqtt.Client("P1")
        broker_address = "192.168.0.200"
        client.connect(broker_address)
        # shelves_to_open1=' '.join(str(e) for e in shelves_to_open)
        for shelves in shelves_to_open:
            client.publish("inTopic", shelves)



        # confirm if locks are open

        # client.subscribe("outTopic")


        # clear users cart items
        my_cursor.execute('DELETE FROM cart WHERE user_id = %s ', (user_id,))
        my_db.commit()

        return flask.jsonify('success')

    my_cursor.execute('SELECT * FROM cart WHERE user_id = %s', (user_id,))
    results = my_cursor.fetchall()

    if len(results) == 0:
        flask.session['error-message'] = 'Choose some items first'
        return flask.redirect(flask.url_for('search_items'))

    items = []
    # probably should use mysql join here
    for result in results:
        my_cursor.execute('SELECT * FROM items WHERE id = %s', (result.get('item_id'),))
        items.append(my_cursor.fetchone())

    return flask.render_template('checkout.html', items=items)


#############################
# Admin section begins here #
#############################


@app.route('/admin', methods=['GET'])
def admin():
    if not flask.session.get('admin_logged_in'):
        return flask.redirect(flask.url_for('admin_login'))
    return flask.render_template('admin/home.html')


@app.route('/admin-login', methods=['GET', 'POST'])
def admin_login():
    if 'submit' in request.form:
        email = request.form['email']
        password = request.form['password']

        my_cursor.execute(f'SELECT * FROM admin WHERE email=\'{email}\' AND password=\'{password}\'')

        result = my_cursor.fetchall()

        if len(result) == 0:
            flask.session['error-message'] = 'Invalid email or password.'
            return flask.render_template('admin/login.html')

        else:
            # here Admin has logged in successfully
            flask.session['admin_logged_in'] = True
            return flask.redirect(flask.url_for('admin'))

    else:

        return flask.render_template('admin/login.html')


############################
# Admin management section #
############################

@app.route('/manage-users', methods=['GET', 'POST'])
def manage_users():
    # first check if admin is logged
    if not flask.session.get('admin_logged_in'):
        return flask.redirect(flask.url_for('admin_login'))

    if 'add-user' in request.form:
        first_name = request.form['firstname']
        second_name = request.form['lastname']
        email = request.form['email']
        mobile = request.form['mobile']

        # here is where we hash our passwords to store them securely
        hashed_password = bcrypt.hashpw(email.encode('utf-8'), bcrypt.gensalt())

        my_cursor.execute('INSERT INTO users (first_name, second_name, email, mobile, profile_pic, password) '
                          'VALUES (%s,%s,%s,%s,"profile.jpg",%s)',
                          (first_name, second_name, email, mobile, hashed_password))
        my_db.commit()

        flask.session['success-message'] = f'User {first_name} {second_name} added successfully'
    elif 'delete-user' in request.form:
        user_id = request.form['id']

        my_cursor.execute('DELETE FROM users WHERE id = %s', (user_id,))
        my_db.commit()

        flask.session['success-message'] = f'User Deleted successfully'
    elif 'get-row' in request.form:
        user_id = request.form['id']
        my_cursor.execute('SELECT id, first_name, second_name FROM users WHERE id = %s', (user_id,))
        user = my_cursor.fetchone()
        return flask.jsonify(user)

    my_cursor.execute(f'SELECT * FROM users')
    users = my_cursor.fetchall()

    return flask.render_template('admin/manage-users.html', users=users)


@app.route('/manage-items', methods=['GET', 'POST'])
def manage_items():
    # first check if admin is logged in
    if not flask.session.get('admin_logged_in'):
        return flask.redirect(flask.url_for('admin_login'))

    if 'add-item' in request.form:
        name = request.form['name']
        shelf = request.form['shelf']
        drawer = request.form['drawer']
        quantity = request.form['quantity']
        description = request.form['description']
        link = request.form['link']
        if request.files['photo'].filename == '':
            image_path = 'profile.jpg'
        else:
            photo = request.files['photo']
            image_path = f'items/{name}-{photo.filename}'
            photo.save(os.path.join(IMAGES_DIRECTORY, image_path))

        my_cursor.execute('INSERT INTO items (name, image, shelf, drawer, quantity, description, external_link) '
                          'VALUES (%s,%s,%s,%s,%s,%s, %s)',
                          (name, image_path, shelf, drawer, quantity, description, link))
        my_db.commit()

        flask.session['success-message'] = f'Item {name} added successfully'
    elif 'edit-item' in request.form:
        item_id = request.form['id']
        name = request.form['name']
        shelf = request.form['shelf']
        drawer = request.form['drawer']
        quantity = request.form['quantity']
        description = request.form['description']
        link = request.form['link']
        if request.files['photo'].filename == '':
            my_cursor.execute('UPDATE items SET name=%s, shelf=%s, drawer=%s, quantity=%s, description=%s, '
                              'external_link=%s '
                              'WHERE id = %s', (name, shelf, drawer, quantity, description, link, item_id))
        else:
            photo = request.files['photo']
            image_path = f'items/{name}-{photo.filename}'
            photo.save(os.path.join(IMAGES_DIRECTORY, image_path))

            my_cursor.execute('UPDATE items SET name=%s, image=%s, shelf=%s, drawer=%s, quantity=%s, description=%s, '
                              'external_link=%s '
                              'WHERE id = %s', (name, image_path, shelf, drawer, quantity, description, link, item_id))

        my_db.commit()

        flask.session['success-message'] = f'Item {name} updated successfully'

    elif 'delete-item' in request.form:
        user_id = request.form['id']

        my_cursor.execute('DELETE FROM items WHERE id = %s', (user_id,))
        my_db.commit()

        flask.session['success-message'] = f'Item Deleted successfully'
    elif 'get-row' in request.form:
        user_id = request.form['id']
        my_cursor.execute('SELECT * FROM items WHERE id = %s', (user_id,))
        user = my_cursor.fetchone()
        return flask.jsonify(user)

    my_cursor.execute(f'SELECT * FROM items')
    items = my_cursor.fetchall()

    return flask.render_template('admin/manage-items.html', items=items)


if __name__ == '__main__':
    app.run(threaded=True, port=5000, debug=False, host='0.0.0.0')
