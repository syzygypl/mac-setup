# Mac setup with Ansible

[![Build Status](https://travis-ci.org/syzygypl/mac-setup.svg?branch=master)](https://travis-ci.org/syzygypl/mac-setup)

```bash
$ curl -sL https://raw.githubusercontent.com/syzygypl/mac-setup/master/bootstrap.sh | bash
```

This script will setup your Mac with software that we use in **Syzygy Warsaw** on a daily basis. All You need is paste above line to Terminal and execute.

It will install `Apache 2.4` and `PHP 5.6`, `7.1` and `7.2` with required extensions and configure sites to be served from `~/Sites/*.loc/web` directories.
DNS records of `*.loc` are being handled by `Dnsmasq` so no changes in `/etc/hosts` are required.

You can check software being installed below. If no version is provided - we use the newest.

## Apps

- [1Password](https://1password.com/)
- [Atom](https://atom.io/)
- [Charles](https://www.charlesproxy.com/)
- [Cocoa REST client](https://mmattozzi.github.io/cocoa-rest-client/)
- [Docker](https://www.docker.com/products/docker)
- [Firefox Developer Edition](https://www.mozilla.org/firefox/developer)
- [Google Chrome](https://www.google.com/chrome/)
- [PHPStorm](https://www.jetbrains.com/phpstorm/)
- [iTerm2](https://www.iterm2.com/)
- [Java](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- [Skype](https://www.skype.com/)
- [Slack](https://slack.com/)
- [Discord](https://discordapp.com/)
- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [WKhtmlTOpdf](http://wkhtmltopdf.org/)
- [Sequel PRO](https://www.sequelpro.com/)
- [RoboMongo](https://robomongo.org/)
- [KeePassX](https://www.keepassx.org/)
- [KeKa](http://www.kekaosx.com/)
- [MacDown](https://macdown.uranusjr.com/)

## Window-less software

- [Apache 2.4](https://httpd.apache.org/)
- [tree](http://mama.indstate.edu/users/ice/tree/)
- [wget](https://www.gnu.org/software/wget/)
- [Fish Shell](https://fishshell.com)
- [Bash Shell](https://www.gnu.org/software/bash/)
- [pv](https://www.ivarch.com/programs/pv.shtml)
- [ssh-copy-id](https://www.openssh.com/)
- [Redis](http://redis.io/)
- [MySQL 5.7](https://dev.mysql.com/doc/refman/5.7/en/)
- [PHP](https://php.net)
- [PHP Xdebug](http://xdebug.org)
- [PHP Redis](https://github.com/phpredis/phpredis)
- [PHP Imagick](https://pecl.php.net/package/imagick)
- [PHP APCu](https://pecl.php.net/package/apcu)
- [PHP YAML](https://pecl.php.net/package/yaml)
- [Composer](http://getcomposer.org)
- [ImageMagick](https://www.imagemagick.org/)
- [Ruby](https://www.ruby-lang.org/)
- [ElasticSearch 5.6](https://www.elastic.co/products/elasticsearch)
- [heroku-toolbelt](https://cli.heroku.com)
- [Node](https://nodejs.org/)
- [nvm](https://github.com/creationix/nvm)
- [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html)
- [rsync 3.1](https://rsync.samba.org/)
- [coreutils](https://www.gnu.org/software/coreutils)

## Configuration

### PHP

`/usr/local/etc/php/*/php.ini`:

```ini
upload_max_filesize   20M
post_max_size         80M
memory_limit          10G
date.timezone         'Europe/Warsaw'
```

### Apache

`/usr/local/etc/httpd/httpd.conf`:

```
LoadModule  vhost_alias_module  libexec/mod_vhost_alias.so
LoadModule  rewrite_module      libexec/mod_rewrite.so
LoadModule  php5_module         /usr/local/opt/php@5.6/lib/httpd/modules/libphp5.so
LoadModule  php7_module         /usr/local/opt/php@7.1/lib/httpd/modules/libphp7.so
LoadModule  php7_module         /usr/local/opt/php@7.2/lib/httpd/modules/libphp7.so

Include     /usr/local/etc/httpd/extra/httpd-vhosts.conf
Include     /usr/local/etc/httpd/extra/httpd-php.conf

User        {{ ansible_ssh_user }}
Group       staff
ServerName  {{ ansible_hostname }}.local
```

`/usr/local/etc/apache2/2.4/extra/httpd-vhosts.conf`:

```
<Directory /Users/{{ ansible_ssh_user }}/Sites>
  Require all granted
  AllowOverride All
  DirectoryIndex index.php index.html
</Directory>

<VirtualHost *:80>
  DocumentRoot /Users/{{ ansible_ssh_user }}/Sites/
</VirtualHost>

<VirtualHost *:80>
  ServerName loc
  ServerAlias *.loc

  CustomLog /var/log/apache2/loc.access_log vcommon
  ErrorLog /var/log/apache2/loc.error_log
  VirtualDocumentRoot /Users/{{ ansible_ssh_user }}/Sites/%-2.0.%-1.0/web/

  LogFormat "%{Host}i %l %u %t \"%r\" %>s %b" vcommon
  Options +FollowSymLinks
  DirectoryIndex index.php
  FallbackResource /index.php

  SetEnvIf Request_URI ^ Debug=1 DEBUG=1 SYMFONY_ENV=dev APP_ENV=dev
  SetEnvIf Host ([^\.]+).loc APP_NAME=$1
  SetEnvIf Host app.([^\.]+) APP_NAME=$1
  SetEnvIf Cookie "APP_NAME=(\w+)" APP_NAME=$1

</VirtualHost>

# Additional VirtualHosts
IncludeOptional /usr/local/etc/httpd/vhosts/*.conf
```

`/usr/local/etc/httpd/httpd-php.conf`:

```
<FilesMatch \.php$>
  SetHandler application/x-httpd-php
</FilesMatch>
```

### Dnsmasq

`/etc/resolver/loc`:

```
nameserver 127.0.0.1
```

`/usr/local/etc/dnsmasq.conf`:

```
address=/.loc/127.0.0.1
```

###  Services

All services are managed via `brew services` command.

```bash
$ brew services list

Name              Status  User Plist
dnsmasq           started root /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
elasticsearch@5.6 started kuba /Users/kuba/Library/LaunchAgents/homebrew.mxcl.elasticsearch@5.6.plist
httpd             started root /Library/LaunchDaemons/homebrew.mxcl.httpd.plist
mongodb           started kuba /Users/kuba/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
mysql@5.7         started kuba /Users/kuba/Library/LaunchAgents/homebrew.mxcl.mysql@5.7.plist
php               stopped
php@5.6           stopped
php@7.1           stopped
redis             started kuba /Users/kuba/Library/LaunchAgents/homebrew.mxcl.redis.plist
```

`dnsmasq` and `apache` should be started as `root`:

```bash
$ sudo brew services start httpd
==> Successfully started `httpd` (label: homebrew.mxcl.httpd)

$ sudo brew services start dnsmasq
==> Successfully started `dnsmasq` (label: homebrew.mxcl.dnsmasq)
```

Rest can be started as regular user (no `sudo` required):

```bash
$ brew services start redis
==> Successfully started `redis` (label: homebrew.mxcl.redis)

$ brew services start elasticsearch@5.6
==> Successfully started `elasticsearch@5.6` (label: homebrew.mxcl.elasticsearch@5.6)

$ brew services start mysql@5.7
==> Successfully started `mysql@5.7` (label: homebrew.mxcl.mysql@5.7)
```

Other commands available for `brew services` are `restart` and `stop`.


## Cleanup old brew PHP

```bash
$ brew update
$ brew upgrade
$ brew cleanup

# check what packages are installed
$ brew list | grep php

# uninstall old php packages
$ brew uninstall --force php56 php56-apcu php56-opcache php56-xdebug php56-yaml php56-igbinary php56-intl php56-redis php56-imagick php56-mcrypt
$ brew uninstall --force php70 php70-apcu php70-opcache php70-xdebug php70-yaml php70-igbinary php70-intl php70-redis php70-imagick php70-mcrypt
$ brew uninstall --force php71 php71-apcu php71-opcache php71-xdebug php71-yaml php71-igbinary php71-intl php71-redis php71-imagick php71-mcrypt
$ brew uninstall --force php72 php72-apcu php72-opcache php72-xdebug php72-yaml php72-igbinary php72-intl php72-redis php72-imagick php72-mcrypt
$ brew cleanup

# check if everything was uninstalled Successfully
$ brew list | grep php

# remove old configs
$ rm -Rf /usr/local/etc/php/*
```
