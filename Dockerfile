FROM ruby:3.2.2

# Create a non-root user and group
ARG APP_USER=appuser
ARG APP_GROUP=appgroup
ARG UID=1000
ARG GID=1000

# Create the user and group
RUN groupadd -g ${GID} ${APP_GROUP} && \
    useradd -u ${UID} -g ${APP_GROUP} -m -s /bin/bash ${APP_USER}

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set working directory
WORKDIR /app

# Install bundler
RUN gem install bundler:2.4.10

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Set environment variables
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

# Set ownership for bundle directory
RUN mkdir -p ${BUNDLE_PATH} && \
    chown -R ${APP_USER}:${APP_GROUP} ${BUNDLE_PATH}

# Install gems as the application user
USER ${APP_USER}
RUN bundle install

# Switch back to root to copy files
USER root

# Copy the rest of the application
COPY --chown=${APP_USER}:${APP_GROUP} . .

# Set up directories and permissions
RUN mkdir -p tmp/cache && \
    chown -R ${APP_USER}:${APP_GROUP} tmp && \
    chmod -R 755 tmp && \
    rm -rf ~/.bundle/

# Switch to the application user
USER ${APP_USER}

# Start the application
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
