FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y nodejs build-essential
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

EXPOSE 3000

CMD ["/app/entrypoints/entrypoint.sh"]
