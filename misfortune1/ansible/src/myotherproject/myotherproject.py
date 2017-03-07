from flask import Flask
application = Flask(__name__)

@application.route("/")
def hello():
    return "<h1 style='color:red'>Hello There...I see you've found me on some other TCP port...</h1>"

if __name__ == "__main__":
    application.run(host='0.0.0.0')
