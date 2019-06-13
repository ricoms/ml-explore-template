FROM python:3.6-jessie


RUN apt-get update -y && apt-get install -y --no-install-recommends \
            libev-dev \
            wget \
            python \
            nginx \
            ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Here we get all python packages.
COPY requirements.txt .
RUN pip install -r requirements.txt

# Set some environment variables. PYTHONUNBUFFERED keeps Python from
# buffering our standard output stream, which means that logs can be
# delivered to the user quickly. PYTHONDONTWRITEBYTECODE keeps Python 
# from writing the .pyc files which are unnecessary in this case. We 
# also update PATH so that the train and serve programs are found when
# the container is invoked.
ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program/:${PATH}"
ENV ML_PREFIX="/opt/ml/"

# Set up the program and config in the image
COPY src /opt/program
RUN mkdir -p /opt/ml/input/config && \
    mkdir -p /opt/ml/input/data/training && \
    mkdir -p /opt/ml/model && \
    mkdir -p /opt/ml/output

WORKDIR /opt/program

EXPOSE 8080

CMD ["--L", "local"]