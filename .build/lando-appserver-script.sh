#!/bin/bash

LIGHT_CYAN='\033[106m'
NO_COLOR='\033[0m' # No Coloer

# Run composer install
echo -e "${LIGHT_CYAN}[🌊 RapidKit]${NO_COLOR} ⚙️ Installing Composer packages..."
composer install
echo -e "${LIGHT_CYAN}[🌊 RapidKit]${NO_COLOR} ✨ Installed Composer packages ✨"

# Copy settings.local.php and development.services.yml
echo -e "${LIGHT_CYAN}[🌊 RapidKit]${NO_COLOR} 📂 Copying settings.local.php to web/sites/default..."
cp .build/settings.local.php web/sites/default
echo -e "${LIGHT_CYAN}[🌊 RapidKit]${NO_COLOR} 📂 Copying development.services.yml to web/sites..."
cp .build/development.services.yml web/sites
echo -e "${LIGHT_CYAN}[🌊 RapidKit]${NO_COLOR} ✨ Files Copied! ✨"

# Run install profile if the database is empty
TABLES=$(drush sql:query "use drupal10;show tables;")
if [[ -z "$TABLES" ]]; then
  echo -e "${LIGHT_CYAN}[🌊 RapidKit]${NO_COLOR} 💧 Installing RapidKit Install Profile..."

  INSTALL_PROFILE_CMD=(drush site:install rapidkit_profile --db-url=mysql://drupal10:drupal10@database/drupal10 --site-name="RapidKit" --account-name=admin --account-pass=admin --yes)

  # If there are any config files in the config directory, append the existing-config argument
  # shellcheck disable=SC2144
  if [ -n "$(find config/ -name '*.yml' -print -quit)" ]; then
    INSTALL_PROFILE_CMD+=(--existing-config)
  fi

  "${INSTALL_PROFILE_CMD[@]}"
  echo -e "${LIGHT_CYAN}[🌊 RapidKit]${NO_COLOR} ✨ Profile Installed! Login as admin/admin ✨"
else
  echo -e "${LIGHT_CYAN}[🌊 RapidKit]${NO_COLOR} 💧 Database already exist! Skipping Profile Install"
fi