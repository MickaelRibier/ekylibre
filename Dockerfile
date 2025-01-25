# Étape de Build
FROM ruby:3.3.1 as build
WORKDIR /rails

# Variables d'environnement
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_JOBS="4" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_PATH="/usr/local/bundle"

# Installer les dépendances système
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    libvips \
    pkg-config \
    curl \
    nodejs \
    yarn

# Copier les fichiers de l'application
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY . .


# Précompilation des assets
RUN chmod +x ./bin/rails
RUN SECRET_KEY_BASE=temporary_dummy_key RAILS_ENV=production bundle exec rails assets:precompile --trace

# Étape finale
FROM ruby:3.3.1 as final
WORKDIR /rails

# Installer les dépendances système pour le déploiement
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    curl \
    postgresql-client \
    libvips

# Copier les artefacts depuis l'étape de build
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Nettoyage
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Créer un utilisateur non-root et attribuer les permissions
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
RUN chmod +x /rails/bin/docker-entrypoint

# Passer à l'utilisateur rails pour des raisons de sécurité
USER rails:rails

# Entrypoint pour préparer la base de données
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Healthcheck pour vérifier l'état de l'application
HEALTHCHECK --interval=15s --timeout=3s --start-period=0s --start-interval=5s --retries=3 \
    CMD curl -f http://localhost:3000/up || exit 1

# Exposer le port 3000
EXPOSE 3000

# Commande par défaut pour démarrer le serveur
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]