FROM ruby:3.1.2-slim
RUN apt update && apt install -y build-essential libpq-dev

WORKDIR /usr/src/app
COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app
RUN bundle config set --local without 'development test'
RUN bundle install --jobs 4 --retry 3

COPY . /usr/src/app

EXPOSE 3000
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
