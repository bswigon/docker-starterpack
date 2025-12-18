# Symfony Docker Starterpack

Gotowy do użycia starterpack dla projektów Symfony z pełną konfiguracją Docker.

## 🚀 Stack Technologiczny

- **PHP 8.3** (FPM Alpine)
- **Symfony 7.3**
- **MySQL 8.0**
- **Nginx** (stable-alpine)
- **Redis** (cache)
- **RabbitMQ** (message broker)

## 📋 Wymagania

- Docker
- Docker Compose
- Git

## 🛠️ Instalacja

### 1. Sklonuj/Skopiuj projekt

```bash
# Jeśli to nowy projekt
git clone <twoje-repo> moj-projekt
cd moj-projekt
```

### 2. Skonfiguruj zmienne środowiskowe

```bash
cd symfony_app
cp .env.local.example .env.local
# Edytuj .env.local i ustaw APP_SECRET
```

### 3. Uruchom Docker

```bash
cd ..  # Wróć do głównego katalogu
docker-compose up -d --build
```

### 4. Zainstaluj zależności PHP

```bash
docker-compose exec php composer install
```

### 5. Utwórz bazę danych

```bash
docker-compose exec php php bin/console doctrine:database:create
docker-compose exec php php bin/console doctrine:migrations:migrate
```

### 6. (Opcjonalnie) Zainstaluj zależności npm

```bash
cd symfony_app
npm install
npm run dev
```

## 🌐 Dostęp do aplikacji

- **Aplikacja Symfony**: http://localhost:8080
- **RabbitMQ Management**: http://localhost:15672 (guest/guest)
- **MySQL**: localhost:3306

## 📚 Przydatne komendy

```bash
# Uruchom kontenery
docker-compose up -d

# Zatrzymaj kontenery
docker-compose down

# Zobacz logi
docker-compose logs -f

# Wejdź do kontenera PHP
docker-compose exec php sh

# Uruchom komendy Symfony
docker-compose exec php php bin/console cache:clear
docker-compose exec php php bin/console make:controller

# Uruchom testy
docker-compose exec php php bin/phpunit
```

## 🗂️ Struktura projektu

```
.
├── Dockerfile                  # Konfiguracja PHP-FPM
├── docker-compose.yml          # Orchestracja serwisów
├── docker/
│   └── nginx/
│       └── default.conf        # Konfiguracja Nginx
└── symfony_app/
    ├── config/                 # Konfiguracja Symfony
    ├── public/                 # Punkt wejścia (index.php)
    ├── src/                    # Kod aplikacji
    ├── templates/              # Szablony Twig
    ├── tests/                  # Testy
    └── composer.json           # Zależności PHP
```

## 🔧 Konfiguracja

### Zmiana portów

Edytuj `docker-compose.yml`:

```yaml
nginx:
  ports:
    - "8080:80"  # Zmień 8080 na inny port
```

### Zmiana wersji PHP/MySQL

Edytuj `Dockerfile` lub `docker-compose.yml` i zmień wersje obrazów.

## 📝 Licencja

Proprietary - dostosuj według potrzeb projektu.
