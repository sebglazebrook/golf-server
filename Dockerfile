FROM ruby:alpine

WORKDIR /code

ADD Gemfile* /code/

RUN bundle install

ADD . /code/

CMD ["rackup", "--host", "0.0.0.0", "-p", "9292"]
