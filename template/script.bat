@echo off

cd @home@/Applications/@project@

if "%1"=="-c" (
	java -client -classpath .;@project@.jar;lib/* @jvm.opts@ @main.class@ %2%
) else (
	start javaw -client -classpath .;@project@.jar;lib/* @jvm.opts@ @main.class@ %1
)

