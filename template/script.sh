#!/bin/sh

cd ~/Applications/@project@
java -client -classpath .:@project@.jar:lib/* @main.class@ "$@"

