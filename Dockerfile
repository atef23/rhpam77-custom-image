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

RUN dnf install wget
RUN wget https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/30/Everything/x86_64/os/Packages/x/xmlstarlet-1.6.1-12.fc30.x86_64.rpm
RUN rpm –qpR xmlstarlet-1.6.1-12.fc30.x86_64.rpm
RUN rpm –i xmlstarlet-1.6.1-12.fc30.x86_64.rpm

RUN chmod +x standalone-update-logging.sh
RUN ./standalone-update-logging.sh

RUN chown -R jboss:root /home/jboss
USER 185
