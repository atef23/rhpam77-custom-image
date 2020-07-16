From registry.redhat.io/rhpam-7/rhpam-businesscentral-rhel8:7.7.0
USER root
WORKDIR /home/jboss
RUN mkdir git-hooks
RUN mkdir .bcgithook
RUN git clone https://github.com/atef23/bcgithook
RUN cp bcgithook/scripts/post-commit.sh git-hooks/post-commit
RUN cp bcgithook/scripts/default.conf .bcgithook/default.conf
RUN rm -rf bcgithook
RUN chown -R jboss:0 /home/jboss
USER 1001
