# docker-magento

## Config Host
```
127.0.0.1   m2.io
# LAN_IP    m2.io
```

## Base Services
```sh
docker-compose up
```

- phpMyAdmin: http://m2.io:8080/
- email: http://m2.io:8025/

## Multiple Services
```sh
bin/init
docker-compose -f docker-compose.yml \
    -f docker-compose.apache.php56.yml \
    -f docker-compose.apache.php70.yml \
    -f docker-compose.apache.php71.yml \
    up
```

- Apache PHP 5.6: http://m2.io:8056/
- Apache PHP 7.0: http://m2.io:8070/
- Apache PHP 7.1: http://m2.io:8071/
