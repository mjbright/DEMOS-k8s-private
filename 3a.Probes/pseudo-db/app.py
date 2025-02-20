#!/usr/bin/env python3

import time
import socket # for hostname
import os,sys

# STARTUP delays:
START_DELAY=10
INIT_DELAY=10

PORT=9000

STARTED=False
INIT=False
SERVING=False
#default_index_template='index.html'
#index_title='Welcome'
#template_folder='flask.templates'


from flask import Flask, request, make_response

app = Flask(__name__)

def die(msg):
    print(f"die: {sys.argv[0]} - {msg}")
    sys.exit(1)

def writefile(path, text='hello world\n', mode='w'):
    ofd = open(path, mode)
    ofd.write(text)
    ofd.close()

def return_text(resp_text, code=200):
    headers={ 'content-type':'text/plain' }
    response = make_response(resp_text, code)
    response.headers = headers
    return response

@app.route('/readyz')
def readyz():
    resp_text=f"READY: Received request to '/readyz'\n"
    if SERVING:
        return return_text(resp_text, code=200)

    return return_text(resp_text, code=503)

@app.route('/healthz')
def healthz():
    resp_text=f"STARTED: Received request to '/healthz'\n"
    if STARTED:
        return return_text(resp_text, code=200)

    return return_text(resp_text, code=503)


@app.route('/')
def root():
    #print(f"\nROOT / - Directory contents={os.listdir('.')}")
    print(f"CLIENT_IP={request.remote_addr}")
    CLIENT_IP=request.remote_addr

    #host=socket.gethostname()

    resp_text=f"Received request to '/'\n"

    #for client in cli_clients:
    #if client in ua:
    return return_text(resp_text, code=200)

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_all(path):
    #return 'You want path: %s' % path
    resp_text=f"UNHANDLED PATH: Received request to '/{path}'\n"
    return return_text(resp_text, code=404)

a=0
while a < len(sys.argv)-1:
    a+=1
    if sys.argv[a] == '-p':
        a+=1
        PORT=int(sys.argv[a])
        continue

    if sys.argv[a] == '-s':
        a+=1
        START_DELAY=int(sys.argv[a])
        continue

    if sys.argv[a] == '-i':
        a+=1
        INIT_DELAY=int(sys.argv[a])
        continue

    die(f"Unknown option <{sys.argv[a]}>")

if __name__ == "__main__":
    date = time.strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{date}] Starting ...")
    time.sleep(START_DELAY)
    writefile('/tmp/started.txt', text='DB started\n')
    STARTED=True

    date = time.strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{date}] Initializing DB ...")
    time.sleep(INIT_DELAY)
    writefile('/tmp/initialized.txt', text='DB initialized\n')
    INIT=True

    print(f"[{date}] Starting DB Server on port {PORT} ...")
    writefile('/tmp/listening.txt', text=f'DB listening on port {PORT}\n')
    SERVING=True
    app.run(host='0.0.0.0', port=PORT)

