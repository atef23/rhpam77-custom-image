From registry.redhat.io/rhpam-7/rhpam-businesscentral-rhel8:7.7.0
USER root
WORKDIR /home/jboss
RUN mkdir git-hooks
RUN mkdir .bcgithook
RUN git clone https://github.com/atef23/bcgithook
RUN cp bcgithook/scripts/post-commit.sh git-hooks/post-commit
RUN chmod +x git-hooks/post-commit
RUN cp bcgithook/scripts/default.conf .bcgithook/default.conf
RUN rm -rf bcgithook

COPY logging.properties /opt/eap/standalone/configuration
COPY standalone-update-logging.sh .

RUN dnf install snapd
RUN ln -s /var/lib/snapd/snap /snap
RUN snap install xmlstarlet

RUN chmod +x standalone-update-logging.sh
RUN ./standalone-update-logging.sh

RUN chown -R jboss:root /home/jboss
USER 185
