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

COPY --from=build /opt/app/_build/prod/rel/scrapper/releases/0.1.0/scrapper.tar.gz .
RUN tar -xvf scrapper.tar.gz

USER default

ENTRYPOINT ["./bin/scrapper"]
CMD ["foreground"]
