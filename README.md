# Mac setup with Ansible

[![Build Status](https://travis-ci.org/syzygypl/mac-setup.svg?branch=master)](https://travis-ci.org/syzygypl/mac-setup)

```bash
$ curl -sL https://raw.githubusercontent.com/syzygypl/mac-setup/master/bootstrap.sh | bash
```

This script will setup your Mac with software that we use in **Syzygy Warsaw** on a daily basis. All You need is paste above line to Terminal and execute.

It will install `Apache 2.4` and `PHP 5.6` with required extensions and configure sites to be served from `~/Sites/*.dev/web` directories.
DNS records of `*.dev` are being handled by `Dnsmasq` so no changes in `/etc/hosts` are required.

You can check software being installed below. If no version is provided - we use newest.

## Apps

- [Atom](https://atom.io/)
- [Cocoa REST client](https://mmattozzi.github.io/cocoa-rest-client/)
- [Docker](https://www.docker.com/products/docker)
- [Firefox](https://www.mozilla.org/firefox/)
- [Google Chrome](https://www.google.com/chrome/)
- [PHPStorm](https://www.jetbrains.com/phpstorm/)
- [iTerm2](https://www.iterm2.com/)
- [Java](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- [Skype](https://www.skype.com/)
- [Slack](https://slack.com/)
- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [WKhtmlTOpdf](http://wkhtmltopdf.org/)
- [Sequel PRO](https://www.sequelpro.com/)
- [RoboMongo](https://robomongo.org/)

## Window-less software

- [Apache 2.4](https://httpd.apache.org/)
- [tree](http://mama.indstate.edu/users/ice/tree/)
- [wget](https://www.gnu.org/software/wget/)
- [Fish Shell](https://fishshell.com)
- [pv](https://www.ivarch.com/programs/pv.shtml)
- [ssh-copy-id](https://www.openssh.com/)
- [Redis](http://redis.io/)
- [MySQL 5.6](https://dev.mysql.com/doc/refman/5.6/en/)
- [PHP 5.6](https://php.net)
- [PHP Xdebug](http://xdebug.org)
- [PHP Intl](http://php.net/manual/en/book.intl.php)
- [PHP Redis](https://github.com/phpredis/phpredis)
- [PHP Imagick](https://pecl.php.net/package/imagick)
- [PHP Mcrypt](http://php.net/manual/en/book.mcrypt.php)
- [PHP Opcache](http://php.net/manual/en/book.opcache.php)
- [PHP APCu](https://pecl.php.net/package/apcu)
- [PHP YAML](https://pecl.php.net/package/yaml)
- [Composer](http://getcomposer.org)
- [ImageMagick](https://www.imagemagick.org/)
- [Ruby](https://www.ruby-lang.org/)
- [ElasticSearch 1.7](https://www.elastic.co/products/elasticsearch)
- [heroku-toolbelt](https://cli.heroku.com)
- [Node 0.12](https://nodejs.org/)
- [nvm](https://github.com/creationix/nvm)
- [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html)
- [rsync 3.1](https://rsync.samba.org/)
- [coreutils](https://www.gnu.org/software/coreutils)
- [Gulp](http://gulpjs.com/)
- [Hologram](https://trulia.github.io/hologram/)
