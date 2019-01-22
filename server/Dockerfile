FROM bitwalker/alpine-elixir:latest as build

COPY rel ./rel
COPY config ./config
COPY lib ./lib
COPY mix.exs .
COPY mix.lock .

ENV MIX_ENV=prod
RUN mix deps.get
RUN mix release

FROM pentacent/alpine-erlang-base:latest

COPY --from=build /opt/app/_build/prod/rel/server/releases/0.1.0/server.tar.gz .
RUN tar -xvf server.tar.gz

USER default

EXPOSE 4000
ENTRYPOINT ["./bin/server"]
CMD ["foreground"]
