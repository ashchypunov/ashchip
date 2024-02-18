FROM python:3.10-alpine

ENV APP_HOME="/app" \
    USER="app" \
    UID=9999 \
    GID=9999

RUN apk add --no-cache curl \
    && curl -sSL https://install.python-poetry.org | POETRY_HOME=/opt/poetry python \
    && cd /usr/local/bin \
    && ln -s /opt/poetry/bin/poetry \
    && poetry config virtualenvs.create false \
    # add user
    && addgroup -g "${GID}" "${USER}" \
    && adduser -s /bin/sh -D -u "${UID}" "${USER}" -G "${USER}"

WORKDIR "${APP_HOME}"

COPY . "${APP_HOME}"

RUN poetry install --no-root --only main \
    && chown -R "${USER}":"${USER}" "${APP_HOME}"

USER  "${USER}"

CMD ["uvicorn", "main:app", "--host", "0.0.0.0"]
