FROM amazonlinux:2017.09

RUN yum -y install python36 python36-devel gcc \
     procps libcurl-devel mod_nss crypto-utils \
     unzip

RUN python3 --version

# Create app directory and add app
ENV APP_HOME /app
ENV APP_SRC $APP_HOME/src
RUN mkdir "$APP_HOME"
RUN mkdir -p /artifacts/lambda
RUN python3 -m venv --without-pip ~/.env && \
 curl https://bootstrap.pypa.io/get-pip.py | \
     ~/.env/bin/python3

#copy all requirements files
COPY requirements-testing.txt requirements.txt ./

#Install both using pip
RUN source ~/.env/bin/activate && \
    pip install --install-option="--with-nss" pycurl && \
    pip install -r requirements-testing.txt && \
        source ~/.env/bin/activate && \
            pip install -r requirements.txt
COPY . $APP_HOME
