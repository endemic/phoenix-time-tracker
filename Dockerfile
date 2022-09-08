FROM elixir:1.14-alpine

RUN apk update
RUN apk add --no-cache \
    build-base \
    sqlite-dev \
    inotify-tools \
    tzdata

# Set timezone for container
RUN cp /usr/share/zoneinfo/America/New_York /etc/localtime

RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR /app

COPY mix.exs mix.lock ./

RUN mix deps.get
RUN mix deps.compile

EXPOSE 4000

CMD ["mix", "phx.server"]
