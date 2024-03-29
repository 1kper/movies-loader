FROM python:3.10.5
LABEL MAINTAINER mlabouardy

WORKDIR /app 

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY movies.json main.py ./

CMD python main.py
