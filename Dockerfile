FROM ruby:alpine3.17

ENV APP_HOME /app
ENV RACK_ENV development

RUN apk add --no-cache build-base

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

RUN gem install bundler -v $(tail -1 Gemfile.lock)
RUN bundle install --jobs $(nproc) --retry 3

COPY . $APP_HOME

EXPOSE 8080
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "8080"]
