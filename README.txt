
Introduction
This project contains a generic build file used to build all my projects.
I do my development on linux and some tasks may not work on windows.
All file locations are implicitly derived using the project name.
Ant is required to run the build file:
sudo apt-get install ant

Here is an example of how to run the refactor application:
ant -f ~/Development/git/ant/master.xml -Dproject.name=refactor master-run

Here is a list of the most common tasks:
master-run: compile sources and run the application
master-validate: compile and run all verifications (unit tests, integration tests, checkstyle)
master-install: validate and install artifact in repo
master-deploy-jar: validate and update installed version on linux
master-deploy-war: validate and install application on webserver (local directory)


Configuration
Like I said, all file locations are implicitly derived from the project [name].
So, for example, all sources for [name] are expected to be in [user_home]/Development/git/[name]
Applications are deployed in [user_home]/Applications/[name]/[name].jar
Its dependencies will be deployed in [user_home]/Applications/[name]/lib
Locations may change in the future and the examples above may be out of date.

Ant uses properties to configure paths and most of the properties are configured in config.properties.
This is the central configuration file shared by all projects.
Every project has a ant.properties file which is used for project specific configuration.
Examples of such configuration: setting packaging format (jar/war) or skipping a task.

Properties can be categorized as follows

1) allowing certain tasks to be run. These are intended as a safeguard against accidentally running the wrong task and take (true|false):
+ enable.java => creates java folder structure, not setting this property ensures folders are not created for non-java projects
+ enable.jar => allows the project to be built as a jar file
+ enable.war => allows the project to be built as a war file
+ enable.osgi => create separate osgi bundles for subpackages
+ enable.install => allows the project to be stored in the local repository
+ enable.application => allows the project to be deployed as an application locally
+ enable.mock => create a separate bundle for the com.eriklievaart.[project].mock package in the src/test/java folder

2) skipping tasks
+ skip.test => do not run (unit & integration) tests
+ skip.checkstyle => do not verify coding conventions
+ skip.preprocess => do not run preprocess source fixes (requires ws.jar to be installed)
+ skip.resolve => do not resolve dependencies (requires ws.jar to be installed)

3) enable additional optional tasks:
+ generator.class => generate resources using the specified java main class
+ source.javacc.package.dir => run javacc, generate files in the specified directory

4) override defaults
project.main => specify main class to use when running the application
project.sh.file => specify template for linux shell file to use when launching
deploy.jvm.opts => specify jvm options to activate when running application

Design
The build file is split into the following files
+ master.xml => main entry point into the build file. Specifies tasks that run their dependencies in order.
+ tasks.xml => tasks without dependencies, tasks may fail if their dependencies are not run, if possible, use master.xml instead
+ macros.xml => defines reusable code snippets, to make tasks more succinct
+ config.properties => single definition of all shared properties (mainly filesystem paths)



