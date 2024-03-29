# pull official base image
FROM python:3.7

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Install Poetry
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | POETRY_HOME=/opt/poetry python && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false 

# Copy poetry.lock* in case it doesn't exist in the repo
COPY ./pyproject.toml ./poetry.lock* /app/

# Allow installing dev dependencies to run tests
ARG INSTALL_DEV=false
RUN bash -c 'if [[ $INSTALL_DEV == true ]] ; then poetry install --no-root ; else poetry install --no-root --no-dev ; fi'

# jupyter notebook --ip=0.0.0.0 --allow-root --NotebookApp.custom_display_url=http://0.0.0.0:8888
ARG INSTALL_JUPYTER=false
RUN bash -c "if [ $INSTALL_JUPYTER == 'true' ] ; then pip install notebook ; fi"

# Copy project
COPY . /app

ENV PYTHONPATH=/app

ENTRYPOINT [ "./scripts/entrypoint.sh" ]