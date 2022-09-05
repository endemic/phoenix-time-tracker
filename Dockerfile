FROM elixir:1.14-alpine

RUN apk update
RUN apk add --no-cache \
    build-base \
    sqlite-dev \
    inotify-tools

RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR /app

EXPOSE 4000

CMD ["mix", "phx.server"]
