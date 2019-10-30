FROM ruby
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install

# Start the main process.
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]
