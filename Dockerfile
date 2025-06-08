FROM python:3.13-alpine AS production

WORKDIR /code

RUN apk add --no-cache \
  build-base \
  gcc \
  g++ \
  musl-dev \
  linux-headers

COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
COPY . /code/

RUN uv sync

EXPOSE 8080

CMD ["uv", "run", "fastapi", "run", "--host", "0.0.0.0", "--port", "8080"]
