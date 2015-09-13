#Change admin password script
#change_weblogic_password.sh <server> <newpassword>
source /u01/app/oracle/product/fmw/wlserver_10.3/server/bin/setWLSEnv.sh
java weblogic.security.utils.AdminAccount weblogic $2 /u01/app/oracle/product/fmw/user_projects/domains/basicWLSSDomain/security/
echo username=weblogic  >  /u01/app/oracle/product/fmw/user_projects/domains/basicWLSSDomain/servers/$1/security/boot.properties
echo password=$2        >> /u01/app/oracle/product/fmw/user_projects/domains/basicWLSSDomain/servers/$1/security/boot.properties
