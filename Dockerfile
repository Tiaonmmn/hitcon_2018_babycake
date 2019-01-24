FROM ubuntu:latest 
# CakePHP need PHP7.2
LABEL Author="orange"
RUN echo "flag{bc9d24fc-1fd4-11e9-96d9-03295f6e31fc}" > /flag
COPY var/www/html/ /var/www/html/
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 
# Make tzdata install noninteractive
WORKDIR /var/www/html/ 
# As you wish?
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&\
    apt-get update && apt-get install libapache2-mod-php php-mbstring php-intl composer php-simplexml -y &&\ 
    # Apache2 install
    composer config -g repo.packagist composer https://packagist.phpcomposer.com &&\
    composer install &&\
    # Cake PHP Install
    chown -R www-data:www-data . &&\
    chmod +x php-entrypoint 
    # Apache2 Start
ENTRYPOINT ["sh","-c","/var/www/html/php-entrypoint"]
EXPOSE 80