FROM python:3.11

WORKDIR /mijnvisie

COPY ./mijnvisie/requirements.txt /mijnvisie/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /mijnvisie/requirements.txt

COPY ./mijnvisie /mijnvisie

# CMD [ "ls" ]
CMD ["fastapi", "run", "main.py", "--port", "8000"]