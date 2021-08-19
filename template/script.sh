#!/bin/sh

cd ~/Applications/@project@
java -client -classpath .:@project@.jar:lib/* @jvm.opts@ @main.class@ "$@"

