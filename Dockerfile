FROM ruby:2.6.5
ENV LANG C.UTF-8

# Install dependencies
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y vim less libpq-dev build-essential git-core mariadb-client \
    apt-transport-https nodejs yarn --no-install-recommends
# Install capybara-webkit deps
#    && apt-get install -y xvfb qt5-default libqt5webkit5-dev \
#    gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

RUN apt-get install -y postgresql-client  

# Clean up
RUN apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /var/lib/dpkg /var/lib/cache

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

#Cache bundle install
WORKDIR /workspace
RUN gem install rails capistrano bundler ed25519 bcrypt_pbkdf
# Rails application
ENV APP_ROOT /workspace

RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY . $APP_ROOT
RUN ls
RUN gem install bundler
RUN bundle install
RUN yarn install --check-files
EXPOSE 3000
CMD rm -f tmp/pids/server.pid && rails server -b '0.0.0.0'

