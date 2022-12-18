# this is my base image
FROM alpine:3.14

# Install python and pip
RUN apk add --update python3
RUN apk add --update py3-pip

# install Python modules needed by the Python app
COPY requirements.txt /usr/src/app/
#RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt
RUN pip3 install --no-cache-dir -r /usr/src/app/requirements.txt

# copy files required for the app to run
COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/

# tell the port number the container should expose
EXPOSE 5000

# run the application
# CMD ["python", "/usr/src/app/app.py"]
CMD ["python3", "/usr/src/app/app.py"]
