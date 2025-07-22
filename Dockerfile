FROM ruby:3.2

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs && \
    rm -rf /var/lib/apt/lists/*

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy app code
COPY . .

# Expose port
EXPOSE 3000

# Set environment (optional)
ENV RAILS_ENV=development

# Run DB setup + server
CMD rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0 -p 3000

