# // https://jeanklaas.com/blog/efficient-docker-containers-with-multi-stage-builds/
FROM ruby:2.7.5-alpine AS builder

# build-base: make and building things
# postgresql-dev: postgres
# nodejs: assets:precompile
# tzdata: Rails time zone
RUN apk add --no-cache build-base postgresql-dev nodejs tzdata

WORKDIR /app
COPY . /app

ENV RAILS_ENV=production
ARG SECRET_KEY_BASE
RUN bundle config deployment true
RUN bundle config without development test
RUN bundle install

RUN bundle exec rails assets:precompile
RUN rm -rf /app/tmp/*

FROM ruby:2.7.5-alpine

RUN apk add --no-cache postgresql-dev nodejs tzdata

WORKDIR /app
COPY --from=builder /app /app

ENV RAILS_ENV=production
RUN bundle config path vendor/bundle
RUN bundle config without development test

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server"]