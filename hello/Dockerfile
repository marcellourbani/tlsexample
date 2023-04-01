FROM python:alpine3.18

RUN pip install flask
RUN adduser -D hello
USER hello
COPY server.py /home/hello
EXPOSE 8000

WORKDIR /home/hello
CMD python ./server.py