FROM elixir:1.14-alpine

RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR /app

