FROM bitwalker/alpine-elixir:1.8.0 as build

COPY rel ./rel
COPY priv ./priv
COPY config ./config
COPY lib ./lib
COPY mix.exs .
COPY mix.lock .

ENV MIX_ENV=prod
RUN mix deps.get
RUN mix release

FROM bitwalker/alpine-elixir:1.8.0

RUN apk add postgresql-client

WORKDIR /opt/app

COPY --from=build /opt/app/_build/prod/rel/scrapper/releases/0.1.0/scrapper.tar.gz .
RUN tar -xvf scrapper.tar.gz

COPY ./bin/entrypoint.sh ./bin/entrypoint.sh
RUN chmod +x ./bin/entrypoint.sh

ENTRYPOINT ["/bin/bash", "bin/entrypoint.sh"]
