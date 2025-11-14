# Utiliser une version plus récente de Python
FROM python:3.10-slim

# Installer dépendances système
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Créer un utilisateur non-root
RUN adduser --disabled-password --gecos "" appuser

# Définir le répertoire de travail
WORKDIR /app

# Copier uniquement les dépendances Python d’abord (meilleur cache)
COPY requirements.txt .

# Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste du code de l’application
COPY . .

# Passer à l’utilisateur non-root
USER appuser

# Exposer le port de ton application
EXPOSE 5000

ENV HOST=0.0.0.0

# Commande de démarrage
CMD ["python", "app.py"]