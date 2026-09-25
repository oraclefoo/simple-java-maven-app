#!/usr/bin/env bash

set -euo pipefail

echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'
set -x
mvn -B jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'The following command reads the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
set -x
NAME=$(mvn -B -q help:evaluate -Dexpression=project.name -DforceStdout)
set +x

echo 'The following command behaves similarly to the previous one but'
echo 'reads the value of the <version/> element within <project/> instead.'
set -x
VERSION=$(mvn -B -q help:evaluate -Dexpression=project.version -DforceStdout)
set +x

echo 'The following command runs and outputs the execution of your Java'
echo 'application (which Jenkins built using Maven) to the Jenkins UI.'
set -x
java -jar "target/${NAME}-${VERSION}.jar"
