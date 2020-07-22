#!/bin/bash

xmlstarlet ed --inplace -N logging-namespace="urn:jboss:domain:logging:6.0" \
  -s /_:server/_:profile/logging-namespace:subsystem -t elem -n file-handler -v "" \
  standalone-openshift.xml

xmlstarlet ed --inplace -N logging-namespace="urn:jboss:domain:logging:6.0" \
  -i "/_:server/_:profile/logging-namespace:subsystem/logging-namespace:file-handler[not(@name)]" -t 'attr' -n name -v "FILE" \
  standalone-openshift.xml

xmlstarlet ed --inplace -N logging-namespace="urn:jboss:domain:logging:6.0" \
  -s "/_:server/_:profile/logging-namespace:subsystem/logging-namespace:file-handler[@name='FILE']" -t elem -n formatter -v "" \
  standalone-openshift.xml

xmlstarlet ed --inplace -N logging-namespace="urn:jboss:domain:logging:6.0" \
  -s "/_:server/_:profile/logging-namespace:subsystem/logging-namespace:file-handler[@name='FILE']/logging-namespace:formatter" -t elem -n named-formatter -v "" \
  standalone-openshift.xml

xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -i "/_:server/_:profile/ln:subsystem/ln:file-handler[@name='FILE']/ln:formatter/ln:named-formatter" -t 'attr' -n name -v "COLOR-PATTERN" \
  standalone-openshift.xml

xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -s "/_:server/_:profile/ln:subsystem/ln:root-logger/ln:handlers" -t 'elem' -n handler -v "" \
  standalone-openshift.xml

xmlstarlet ed --inplace -N ln="urn:jboss:domain:logging:6.0" \
  -s "/_:server/_:profile/ln:subsystem/ln:root-logger/ln:handlers/ln:handler[not(@name)]" -t 'attr' -n name -v "FILE" \
  standalone-openshift.xml
