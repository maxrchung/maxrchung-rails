FROM ruby:2.7.5

RUN apt-get update -qq
RUN apt-get install -y nodejs

WORKDIR /app
COPY . /app
RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-e", "production"]