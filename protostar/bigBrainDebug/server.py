import flask
from flask import request
import logging

log = logging.getLogger("werkzeug")
log.disabled = True
app = flask.Flask(__name__)
app.config["DEBUG"] = True
counter = 0


@app.route("/", methods=["POST"])
def home():
    global counter
    print(counter, request.json)
    counter += 1
    return "success"


app.run()
