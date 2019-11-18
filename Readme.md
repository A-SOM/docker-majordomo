# Welcome to Docker Majordomo!

Доброго дня. Это предварительная версия majordomo под docker с правильным стеком.
#todo English version.


# Stack
 - Supervisord - как центральный процесс запуска всех daemon
 - Nginx - как web-сервер
 - php-fpm - как php-сервер
 - cycle.php через supervisord для стабильности

## Что появится

В ближайших планах разработка под **alpine** образа. Так же чистка некоторых хвостов  и доработка **init**-скриптов и **make** файла. Так же вывод всего в стабильный образ в **regestry** и разработка **модулей** под docker-связку.

## Поддерживаемые в данный момент OS

Mainstream: Любая Linux os с поддержкой Docker и Docker-compose.
Windows: как дополнительная os, через ubuntu WSL
MacOs и Raspberry в ближайшем будущем будут протестированы.

## Установка под Linux

todo сделать её внятней.

 1. Склонировать данный репозиторий.
 2. Скопировать config.env.dist в config.env и настраиваем под себя 
`cp config.env.dist config.env`
 3. Подтянуть git
`make clone_code"
 4. Устанавливаем docker и docker-compose для себя. Как вариант(плохой) и перезапускаем сервер:
`sudo apt get update && sudo apt-get install docker docker-compose && sudo usermod -aG docker $USER && reboot`
 5. Запускаем сборку и подгружаем базу данных. У вас спросят удалять ли базу данных. Соглашаемся.
`make install && make init-db`
 6. Настраиваем в ./app config.php. Учтите, host mysql теперь: 127.0.0.1(а не localhost) и в Define('BASE_URL указываем ваш ip-адрес системы.
`cp -f ./app/config.php.sample ./app/config.php && nano ./app/config.php`
 7. Перезапускам всё, что бы заново иницилизировать cycle.
 8. Открываем 127.0.0.1 или localhost или ip где запущен докер. Радуемся.

## Баги с правами
Некоторые части могут быть не отлажены корректно. Поэтому в данный момент права выдаются не корректно. Что бы исправить:
`make exec-app`
`chown -R www-data:www-data /var/www`
`chmod -R 777 /var/www`

todo: исправить эту дичь.

# Отзывы
Всем отзывам буду рад в Issue.