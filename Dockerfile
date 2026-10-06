From python

WORKDIR /the/workdir/app

COPY requirements.txt .

RUN pip install -r requirements.txt

EXPOSE 5000

CMD [ "executable" ]
