FROM        viking617/base
MAINTAINER  viking617617@gmail.com

ENV         LANG C.UTF-8

# 파일 복사 및 requirements 설치
COPY        . /srv/app
RUN         /root/.pyenv/versions/app/bin/pip install -r /srv/app/requirements.txt

# pyenv local 설정
WORKDIR     /srv/app
RUN         pyenv local app

# Nginx
RUN         cp /srv/app/.config/nginx/nginx.conf /etc/nginx/nginx.conf
RUN         cp /srv/app/.config/nginx/app.conf \
                /etc/nginx/sites-available
RUN         rm -rf /etc/nginx/sites-enabled/*
RUN         ln -sf /etc/nginx/sites-available/app.conf \
                    /etc/nginx/sites-enabled/app.conf

# uWSGI
RUN         mkdir -p /var/log/uwsgi/app


# manage.py
WORKDIR     /srv/app/mysite
RUN         /root/.pyenv/versions/app/bin/python manage.py collectstatic --noinput
RUN         /root/.pyenv/versions/app/bin/python manage.py migrate --noinput


# supervisor
RUN         cp /srv/app/.config/supervisor/* \
                /etc/supervisor/conf.d/
CMD         supervisord -n

EXPOSE      80