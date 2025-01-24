FROM ruby:3.2

# Installer les dépendances système
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

# Configurer le répertoire de l'application
WORKDIR /app

# Copier le code source
COPY . /app

# Installer les gems
RUN gem install bundler && bundle install

# Installer les dépendances front-end
RUN yarn install

# Précompilation des assets
RUN SECRET_KEY_BASE=temporary_dummy_key ./bin/rails assets:precompile

# Exposer le port
EXPOSE 3000

# Commande de démarrage
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
