# ----------------------------------------------------
#  Dockerfile
# ----------------------------------------------------
# 
#  This is a Weblogic environment.
#
#  URL: 
#   http://localhost:7001/console
#
#  Environment Details:
#    OS       = dedora:latest
#      see (https://hub.docker.com/_/fedora/) for the exact version.
#    Java     = jdk-7u79
#    Weblogic = Weblogic 11g 10.3.6 
#
# ----------------------------------------------------

# Pull base image.
FROM oraclelinux:6

MAINTAINER guok "https://github.com/barryguda-1"

# Update and install
RUN [ "yum", "update",                                "-y" ]

RUN [ "yum", "install", "unzip",                      "-y" ]
RUN [ "yum", "install", "wget",                       "-y" ]
RUN [ "yum", "install", "binutils.x86_64",            "-y" ]
RUN [ "yum", "install", "gcc.x86_64",                 "-y" ]
RUN [ "yum", "install", "gcc-c++.x86_64",             "-y" ]
RUN [ "yum", "install", "glibc.x86_64",               "-y" ]
RUN [ "yum", "install", "glibc.i686",                 "-y" ]
RUN [ "yum", "install", "glibc-devel.i686",           "-y" ]
RUN [ "yum", "install", "libaio.x86_64",              "-y" ]
RUN [ "yum", "install", "libaio-devel.x86_64",        "-y" ]
RUN [ "yum", "install", "libgcc.x86_64",              "-y" ]
RUN [ "yum", "install", "libstdc++.x86_64",           "-y" ]
RUN [ "yum", "install", "libstdc++.i686",             "-y" ]
RUN [ "yum", "install", "libstdc++-devel.x86_64",     "-y" ]
RUN [ "yum", "install", "libXext.i686",               "-y" ]
RUN [ "yum", "install", "libXtst.i686",               "-y" ]
RUN [ "yum", "install", "redhat-lsb-core.x86_64",     "-y" ]
RUN [ "yum", "install", "sysstat.x86_64",             "-y" ]
RUN [ "yum", "install", "tmux.x86_64",                "-y" ]
RUN [ "yum", "install", "vsftpd.x86_64",              "-y" ]
RUN [ "yum", "install", "vim-enhanced",               "-y" ]

# ----------------------------------------------------
#  Install Java
# ----------------------------------------------------
#Create folder oracle
RUN mkdir -p /u02/app/oracle/product

#Work folder
WORKDIR /u02/app/oracle/product

#Add java to docker
#ADD jdk-7u79-linux-x64.rpm ./jdk-7u79-linux-x64.rpm
RUN wget https://www.dropbox.com/s/67mddrwhb6fhaq5/jdk-7u79-linux-x64.rpm
#Copy with sucess
RUN echo "jdk copy sucess"
RUN chmod +x jdk-7u79-linux-x64.rpm
RUN ls -la /u02/app/oracle/product

# Install Java.
RUN rpm -ivh jdk-7u79-linux-x64.rpm 

#Remove installer 
RUN rm -rf jdk-7u79-linux-x64.rpm

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/java/default

# ----------------------------------------------------
#  Install Weblogic Server
# ----------------------------------------------------
# Actual Weblogic 11g 10.3.6 installation and setup procedures
# Create a OFA location to put the weblogic install, create to oracle user so we can set the permissions on the location
RUN groupadd dba      -g 502 && \
    groupadd oinstall -g 501 && \
    useradd -m        -u 501 -g oinstall -G dba -d /home/oracle -s /sbin/nologin -c "Oracle Account" oracle && \
    mkdir -p /u01/app/oracle && \
    chown -R oracle:oinstall /home/oracle && \
    chown -R oracle:oinstall /u01/app/oracle

# Install Weblogic 11gR1 10.3.6 Generic
ADD silent.xml          /u01/app/oracle/silent.xml

WORKDIR /u01/app/oracle/
RUN wget https://www.dropbox.com/s/pbhwgfin6msbknd/wls1036_generic.jar

# Set permission

RUN chmod +x /u01/app/oracle/wls1036_generic.jar

# Install
RUN [ "java","-Dspace.detection=false", "-Xmx1024m", "-jar", "/u01/app/oracle/wls1036_generic.jar", "-mode=silent", "-silent_xml=/u01/app/oracle/silent.xml" ]
RUN rm /u01/app/oracle/wls1036_generic.jar

#USER oracle

# ----------------------------------------------------
#  Install Weblogic Admin Server
# ----------------------------------------------------
USER root
ADD basicWLSDomain_AdminServer.py /u01/app/oracle/product/fmw/wlserver_10.3/common/templates/scripts/wlst/

RUN /bin/bash -c "source /u01/app/oracle/product/fmw/wlserver_10.3/server/bin/setWLSEnv.sh" \
    && /u01/app/oracle/product/fmw/wlserver_10.3/common/bin/wlst.sh /u01/app/oracle/product/fmw/wlserver_10.3/common/templates/scripts/wlst/basicWLSDomain_AdminServer.py

ADD change_weblogic_password.sh /u01/app/oracle/product/fmw/
ADD entrypoint.sh /u01/app/oracle/product/fmw/

RUN [ "chmod", "a+x", "/u01/app/oracle/product/fmw/change_weblogic_password.sh", "/u01/app/oracle/product/fmw/entrypoint.sh" ]

ENTRYPOINT [ "/u01/app/oracle/product/fmw/entrypoint.sh", "AdminServer", "weblogic1234" ]

EXPOSE 7001
EXPOSE 22

# Define default command.
CMD ["bash"]
