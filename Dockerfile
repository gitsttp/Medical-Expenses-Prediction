FROM python:3.11.9-slim
LABEL maintainer="Anny"
ENV PYTHONUNBUFFERED 1

# Copy requirements file
COPY ./requirements_docker.txt requirements_docker.txt

# Copy webapp and models
COPY ./webapp /webapp
COPY ./models/models.joblib /webapp/models/models.joblib

WORKDIR /webapp
EXPOSE 8000

# Create a virtual environment, install pip, and install dependencies
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /requirements_docker.txt && \
    adduser --disabled-password --no-create-home webapp

# Add virtual environment to PATH
ENV PATH="/py/bin:$PATH"

# Switch to non-root user
USER webapp
