FROM python:3.9-slim-buster AS pythonbase

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

#deps
RUN apt-get update && apt-get install -y --no-install-recommends \
        libffi-dev \
        libnacl-dev \
        python3-dev \
        gcc \
        opus-tools \
        ffmpeg

FROM pythonbase AS discord

WORKDIR /app
ADD /app /app

# Install pip requirements
RUN python -m pip install -r requirements.txt

# Switching to a non-root user
RUN useradd appuser && chown -R appuser /app
USER appuser