FROM phusion/passenger-customizable
MAINTAINER xforty technologies "xforty.com"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN /pd_build/utilities.sh
RUN /pd_build/ruby2.2.sh
RUN /pd_build/nodejs.sh
RUN gem install foreman
RUN npm install -g grunt-cli

RUN rm -f /etc/service/nginx/down
ADD nginx.conf /etc/nginx/sites-available/default
ADD setup.sh /etc/my_init.d/20app_setup.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD init-app.sh /root/init-app.sh
ADD runit /root/runit

ONBUILD ADD . /srv/app
ONBUILD RUN bash /root/init-app.sh
