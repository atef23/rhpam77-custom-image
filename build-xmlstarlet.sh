#! /bin/sh -x
# 
#  $Id: run-xmlstarlet-build,v 1.17 2005/03/19 05:01:28 mgrouch Exp $

# Correct versions here for the latest releases
VER_LIBXML=2.6.18
VER_LIBXSLT=1.1.13
VER_XMLSTAR=1.0.1

# get source files
# Correct URLs for file locations here
wget --passive-ftp ftp://xmlsoft.org/libxml2-${VER_LIBXML}.tar.gz
wget --passive-ftp ftp://xmlsoft.org/libxslt-${VER_LIBXSLT}.tar.gz
wget http://umn.dl.sourceforge.net/sourceforge/xmlstar/xmlstarlet-${VER_XMLSTAR}.tar.gz
#wget http://xmlstar.sourceforge.net/downloads/xmlstarlet-${VER_XMLSTAR}.tar.gz

# unarchive

gzip -cd < libxml2-${VER_LIBXML}.tar.gz | tar xvf -
gzip -cd < libxslt-${VER_LIBXSLT}.tar.gz | tar xvf -
gzip -cd < xmlstarlet-${VER_XMLSTAR}.tar.gz | tar xvf -

# build libxml2

BUILD_LOC=`pwd`
export BUILD_LOC


# patch libxml2
cd libxml2-${VER_LIBXML}/include/libxml
patch  << !EOF
*** include/libxml/xmlexports.h-orig    Fri Oct 29 11:11:23 2004
--- include/libxml/xmlexports.h Wed Nov  3 11:33:19 2004
***************
*** 92,100 ****
    #undef XMLPUBFUN
    #undef XMLPUBVAR
    #undef XMLCALL
    #if defined(IN_LIBXML) && !defined(LIBXML_STATIC)
      #define XMLPUBFUN __declspec(dllexport)
!     #define XMLPUBVAR __declspec(dllexport)
    #else
      #define XMLPUBFUN
      #if !defined(LIBXML_STATIC)
--- 92,103 ----
    #undef XMLPUBFUN
    #undef XMLPUBVAR
    #undef XMLCALL
+ /*
    #if defined(IN_LIBXML) && !defined(LIBXML_STATIC)
+ */
+   #if !defined(LIBXML_STATIC)
      #define XMLPUBFUN __declspec(dllexport)
!     #define XMLPUBVAR __declspec(dllexport) extern
    #else
      #define XMLPUBFUN
      #if !defined(LIBXML_STATIC)
!EOF

cd ${BUILD_LOC}/libxml2-${VER_LIBXML}
./configure --prefix=/usr --enable-ipv6=no
make
#make install
#make tests


# patch libxslt
cd ../libxslt-${VER_LIBXSLT}/libexslt
patch  << !EOF
*** date.c	Thu Jan 27 21:08:14 2005
--- date.c-new	Thu Jan 27 21:09:15 2005
***************
*** 1935,1941 ****
--- 1935,1945 ----
  
      year = exsltDateYear(dateTime);
      if (xmlXPathIsNaN(year))
+ #ifdef __MINGW32__
+ 	return xmlXPathNewFloat(year);
+ #else
  	return xmlXPathNewFloat(xmlXPathNAN);
+ #endif
  
      if (IS_LEAP((long)year))
  	return xmlXPathNewBoolean(1);
!EOF

# build libxslt

cd ${BUILD_LOC}/libxslt-${VER_LIBXSLT}
./configure --prefix=/usr --enable-ipv6=no --with-libxml-src=${BUILD_LOC}/libxml2-${VER_LIBXML}
make
#make install
#make tests

# build xmlstarlet

cd ../xmlstarlet-${VER_XMLSTAR}
./configure --prefix=/usr --with-libxml-src=${BUILD_LOC}/libxml2-${VER_LIBXML} \
 --with-libxslt-src=${BUILD_LOC}/libxslt-${VER_LIBXSLT} --enable-ipv6=no
make
#make install
#make tests

cd ${BUILD_LOC}
