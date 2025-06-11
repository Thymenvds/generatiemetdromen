
FROM python:3.9

WORKDIR /server

COPY ./mijnvisie/requirements.txt /server/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /server/requirements.txt

COPY ./mijnvisie /server

# CMD [ "ls" ]
CMD ["fastapi", "run", "server.py", "--port", "8000"]