#!/bin/sh

# Buildpack URL
VERSION=1.9.7
ARCHIVE_NAME=phantomjs-${VERSION}-linux-x86_64
FILE_NAME=${ARCHIVE_NAME}.tar.bz2
BUILDPACK_PHANTOMJS_PACKAGE=https://bitbucket.org/ariya/phantomjs/downloads/${FILE_NAME}

ARCHIVE_DIR=$APP_CHECKOUT_DIR/.phantomjs
ARCHIVE_FILE=$ARCHIVE_DIR/$FILE_NAME
mkdir -p $ARCHIVE_DIR
if ! [ -e $ARCHIVE_FILE ]; then
  echo "-----> Fetching PhantomJS ${VERSION} binaries from ${BUILDPACK_PHANTOMJS_PACKAGE} to ${ARCHIVE_FILE}"
  curl $BUILDPACK_PHANTOMJS_PACKAGE -L -s -o $ARCHIVE_FILE
fi

DUMP_DIR=$ARCHIVE_DIR/extract
mkdir -p $DUMP_DIR
if [ -e $DUMP_DIR ]; then
  echo "-----> Extracting PhantomJS ${VERSION} binaries to ${DUMP_DIR}"
  tar jxf $ARCHIVE_FILE -C $DUMP_DIR
  
  echo "-----> Copying ${DUMP_DIR}/${ARCHIVE_NAME} to ${COMPILE_DIR}"
  mv $DUMP_DIR/$ARCHIVE_NAME $COMPILE_DIR
fi

