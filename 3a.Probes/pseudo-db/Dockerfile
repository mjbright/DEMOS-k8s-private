
FROM docker.io/library/python:3

ADD app.py /

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install flask

#CMD [ "python", "./app.py" ]
ENTRYPOINT [ "./app.py" ]

