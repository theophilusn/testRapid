#!/bin/bash

# The environment name to pull form. These names are defined in the drush site aliases
ENVIRONMENT="dev"

while (( "$#" )); do
  case "$1" in
    -env|--environment|--environment=*)
      if [ "${1##--environment=}" != "$1" ]; then
        ENVIRONMENT="${1##--environment=}"
        shift
      else
        ENVIRONMENT=$2
        shift 2
      fi
      ;;
    --)
      shift
      break
      ;;
    -*|--*=)
      exit 1
      ;;
    *)
      shift
      ;;
  esac
done

echo "👇 Syncing Files and Database from ${ENVIRONMENT}."
/bin/chgrp www-data /run/host-services/ssh-auth.sock && /bin/chmod g+w /run/host-services/ssh-auth.sock
drush sql:sync @${ENVIRONMENT} @self -y
drush rsync @${ENVIRONMENT}:%files ./web/sites/default/files -y
drush cr
echo "✨ Sync Completed ✨"
