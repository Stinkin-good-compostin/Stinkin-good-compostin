import sqlite3
from flask import Flask, send_from_directory, jsonify, request, render_template

app = Flask(__name__)

@app.route('/static/<path:filename>')
def send_static(filename):
    return send_from_directory('static', filename)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/subscriptions')
def subscriptions():
    return render_template('subscriptions.html')

@app.route('/post', methods=['POST'])
def post():
    f = request.form
    
    email = f['email']
    phone = f['phone']
    adress_location = f['adress-location']
    dump_location = f['dump-location']

    conn = sqlite3.connect("formData.db")
    c = conn.cursor()
    c.execute("""CREATE TABLE IF NOT EXISTS Form (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        phone TEXT UNIQUE,
        adress_location TEXT,
        dump_location TEXT
    );""")

    c.execute("INSERT INTO Form (email, phone, adress_location, dump_location) VALUES (?, ?, ?, ?)", (email, phone, adress_location, dump_location))

    conn.commit()
    conn.close()

    return jsonify(
        {
         'email': f'{email}', 
         'phone': f'{phone}', 
         'adress_location': f'{adress_location}', 
         'dump_location': f'{dump_location}'
        }
    )

@app.route('/delete', methods=['DELETE'])
def delete():
    conn = sqlite3.connect("formData.db")
    c = conn.cursor()
    c.execute("DELETE FROM Form;")
    conn.commit()
    conn.close()

if __name__ == '__main__':
    app.run(debug=True)