# weblogic-environment
This is a weblogic environment.

---
## Environment

With this dockerfile, it will build an environment consists of below softwares.
* OS = dedora:latest (see https://hub.docker.com/_/fedora/ for the exact version.)
* Java     = jdk-7u79
* Weblogic = Weblogic 11g 10.3.6 

---
## URL
This is a default weblogic admin console URL.
* http://localhost:7001/console
* ID = weblogic
* Password = weblogic123

---
## Installation
```sh
# [Sample Variables]
# directory_contains_this_dockerfile=/usr/local/docker/weblogic-environment
# your_repository_name=my-repo
# your_image_name=weblogic-environment

$ cd ${directory_contains_this_dockerfile}
$ docker build -t ${your_repository_name}/${your_image_name} .
```

---
## How-to
### run a docker container
```sh
# with a "detached" option
$ docker run -i -t -p 7001:7001 -d ${your_repository_name}/${your_image_name}   /bin/bash
# without a "detached" option
$ docker run -i -t -p 7001:7001 ${your_repository_name}/${your_image_name}   /bin/bash
```
### ssh to a running container
```sh
# get an container id which you want to ssh to.
$ docker ps
$ docker exec -i -t ${container_id} bash
```

---
## Todos
* switch to CentOS
* run a sftpd from a beginning
* configure necessary weblogic adm server and weblogic server to more easily use this
* set up a "shared folders" to share a directory b/w a host and a docker container.
* remove a dependency from **dl.dropboxusercontent.com** to get softwares..
* delete unnecessary setup from the dockerfile if exists..

---
## Special Thanks to
* https://github.com/jefersonbsa/docker-java-7
* https://github.com/jefersonbsa/docker-weblogic
* https://github.com/jefersonbsa/docker-weblogic-admin/blob/master/Dockerfile

---
## License
[GPLv3](http://www.gnu.org/licenses/gpl-3.0.en.html)
