#!/bin/bash

xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -s "/_:server/_:profile/ln:subsystem" -t elem -n file-handler -v "" \
  /opt/eap/standalone/configuration/standalone-openshift.xml

xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -i "/_:server/_:profile/ln:subsystem/ln:file-handler[not(@name)]" -t 'attr' -n name -v "FILE" \
  /opt/eap/standalone/configuration/standalone-openshift.xml

xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -s "/_:server/_:profile/ln:subsystem/ln:file-handler[@name='FILE']" -t elem -n formatter -v "" \
  /opt/eap/standalone/configuration/standalone-openshift.xml
  
xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -s "/_:server/_:profile/ln:subsystem/ln:file-handler[@name='FILE']" -t elem -n file -v "" \
  /opt/eap/standalone/configuration/standalone-openshift.xml
  
xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -s "/_:server/_:profile/ln:subsystem/ln:file-handler[@name='FILE']" -t elem -n file -v "" \
  /opt/eap/standalone/configuration/standalone-openshift.xml
  
xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -i "/_:server/_:profile/ln:subsystem/ln:file-handler[@name='FILE']/ln:file" -t 'attr' -n relative-to -v "jboss.server.log.dir" \
  /opt/eap/standalone/configuration/standalone-openshift.xml
  
xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -i "/_:server/_:profile/ln:subsystem/ln:file-handler[@name='FILE']/ln:file" -t 'attr' -n path -v "server.log" \
  /opt/eap/standalone/configuration/standalone-openshift.xml 

xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -i "/_:server/_:profile/ln:subsystem/ln:file-handler[@name='FILE']/ln:formatter/ln:named-formatter" -t 'attr' -n name -v "COLOR-PATTERN" \
  /opt/eap/standalone/configuration/standalone-openshift.xml

xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -s "/_:server/_:profile/ln:subsystem/ln:root-logger/ln:handlers" -t 'elem' -n handler -v "" \
  /opt/eap/standalone/configuration/standalone-openshift.xml

xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -s "/_:server/_:profile/ln:subsystem/ln:root-logger/ln:handlers/ln:handler[not(@name)]" -t 'attr' -n name -v "FILE" \
  /opt/eap/standalone/configuration/standalone-openshift.xml
