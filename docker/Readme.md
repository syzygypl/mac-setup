# Syzygy local dev environment

 * [Traefik](https://traefik.szg.dev)
 * [Consul](https://consul.szg.dev)
 * [Mailhog](https://mailhog.szg.dev)
 * [Portainer](https://portainer.szg.dev)

## Services

 * Mysql: `docker.for.mac.localhost:3306` or `localhost:3306`
 * Redis: `docker.for.mac.localhost:6379` or `localhost:6379`
 * Elasticsearch 1.7: `docker.for.mac.localhost:9200` or `elasticsearch.dev`
 * SMTP server (mailhog): `docker.for.mac.localhost:1025` or `localhost:1025`

## Accepting Root certificate

    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain nassau-https-proxy/data/v0/ssl.proxy.nassau.narzekasz.pl.crt

## Configuring resolver

    # https://github.com/chulkilee/dev-docker/blob/master/scripts/add-resolver.sh

    echo "nameserver 127.0.0.1" | sudo tee /etc/resolver/test /etc/resolver/dev /etc/resolver/consul
    sudo killall -HUP mDNSResponder

## Default `docker-compose.yml` in your project

```
version: "3"
services:
    # Your main service to start:
    www: 
        # use your custom Dockerfile, but hide it in a subdirectory, so you don’t have a large build context
        build: .docker/
        # remember to bind your services to a public interface
        command: bin/console server:run 0.0.0.0:80
        working_dir: /app
        volumes:
            # :delegated strategy improves performance
            - ./:/app:delegated
            # yay, a shared composer cache & settings!
            - composer:/home/composer
        environment:
            # this is needed for the shared cache to work
            COMPOSER_HOME: /home/composer

    browsersync:
        build: .docker/
        command: gulp browsersync
        working_dir: /app
        environment:
          BACKEND_URL: "http://backend"
          NPM_HOME: "/home/npm"
        links:
          - www:backend
        volumes:
            - ./:/app:delegated
            # shared npm cache
            - npm:/home/npm

# you need to attach to the default szg docker network
networks:
    default:
        external:
            name: szg_default

# also, you need to attach the shared cache volumes
volumes:
    composer:
        external:
            name: szg_composer
    npm:
        external:
            name: szg_npm
```
