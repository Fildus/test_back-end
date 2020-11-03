# test Back-end

## Development server
* ```make dev``` start the database and the application

### website
http://localhost:8000/

### adminer
http://localhost:8888/
* Serveur=***db***
* Utilisateur=***root***
* Mot de passe=***root***

## Install the application
* ```make install``` install the application

## Test the application
* ```make test``` test the application (**phpunit**)
* ```make tt``` Automatically restart tests (**phpunit-watcher**)
* ```make lint``` Checks that the code does not contain any errors (**phpstan**)

## Correct typos
* ```make fix``` correct typos (**php-cs-fixer**)

## Clean
* ```make clean``` clean volumes, networks and containers (**dev**)

## Shell commands

|run|command|
|---|---|
|php|`env USER_ID=$(id -u) GROUP_ID=$(id -g) docker-compose exec php php`|
|composer|`env USER_ID=$(id -u) GROUP_ID=$(id -g) docker-compose exec php composer`|
|yarn|`env USER_ID=$(id -u) GROUP_ID=$(id -g) docker-compose exec node yarn`|