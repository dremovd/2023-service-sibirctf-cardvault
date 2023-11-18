# ---- Build Stage ----
FROM elixir:1.15-alpine as build_app

# Set environment variables for building the application
ENV MIX_ENV=prod \
    LANG=C.UTF-8

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Create the application build directory
RUN mkdir /app
WORKDIR /app

# Copy over all the necessary application files and directories
COPY config ./config
COPY lib ./lib
COPY mix.exs .
COPY mix.lock .

# Fetch the application dependencies and build the application
RUN mix deps.get
RUN MIX_ENV=prod mix release

# ---- Application Stage ----
FROM elixir:1.15-alpine AS app

ENV LANG=C.UTF-8

# Copy over the build artifact from the previous step and create a non root user
RUN adduser -S app
WORKDIR /home/app
COPY --from=build_app /app/_build .
RUN chown -R app: ./prod
USER app
# Run the app
ENTRYPOINT ["./prod/rel/cardvault/bin/cardvault", "start"]
