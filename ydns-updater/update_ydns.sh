#!/bin/sh

update_domain() {
  if [ -z ${1+x} ]
  then
    echo "No domain passed, nothing to do.."
    return 0
  fi
  if [ -z ${2+x} ]
  then
    echo "No IP Version passed, nothing to do.."
    return 0
  fi
  
  if [ -z ${3+x} ]
  then
    OUT=$(curl -${2} --basic --silent -u "$YDNS_USER:$YDNS_PASSWD" "https://ydns.io/api/v1/update/?host=${1}")
  else
    OUT=$(curl -${2} --basic --silent -u "$YDNS_USER:$YDNS_PASSWD" "https://ydns.io/api/v1/update/?host=${1}&ip=${3}")
  fi
  if [ "${OUT}" = "ok" ]; then
    echo "Successfully updated IPv${2} '${1}' ${3}";
  else
    echo "Error updating IPv${2} '${1}': ${OUT}";
  fi
}

domains=$(env | grep ^DOMAIN | cut -d '=' -f2)

if [ -z "${domains}" ]
then
    echo "No domains set. Example: DOMAIN1=mydomain.example.org"
    exit 1
fi

if [ -z "${ENABLE_IPV4}" ] && [ -z "${ENABLE_IPV6}" ]
then
    echo "No IP version enabled, set at least one: ENABLE_IPV4, ENABLE_IPV6"
    exit 1
fi

OLDIP=""
while [ true ]
do
    IP=`curl --silent https://api.my-ip.io/ip`
    if [ -z "${IP}" ]; then
      echo No IP detected
    else
      if [ "a${OLDIP}" = a${IP} ]; then
        echo No IP change detected - still ${IP}
      else
        if [ -n "${OlDIP}" ]; then echo "current: ${OLDIP} new: ${IP}";fi
        OLDIP=${IP}
        for domain in ${domains}; do
            if [ -n "${ENABLE_IPV4}" ]; then
              update_domain ${domain} 4 ${IP}
            fi
            if [ -n "${ENABLE_IPV6}" ]; then
              update_domain ${domain} 6 ${IP}
            fi
        done
      fi
    fi
    sleep ${UPDATE_DELAY}
done
