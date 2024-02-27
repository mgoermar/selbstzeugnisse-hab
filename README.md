## Primary dependencies

- php
- php extension openssl
- php extension xsl

## build dependencies

- xmlcalabash

## Download required libraries

```bash
php bin/composer.phar install
```

## Start a local server

Execute file start_server.bat or

```bash
php -S 127.0.0.1:9999 -t public public/index.php
```

## Run the make file

On unix and on windows using the git bash you can run:

```bash
make target
```
