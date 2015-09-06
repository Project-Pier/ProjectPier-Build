# Run as a build step using Jenkins CI
# To run outside of jenkins, replace any system variables with values
# of your own liking.
# System variables provided by Jenkins used in this script are:
#  $BUILD_NUMBER
#
# Requires git, sed, and zip to be installed

# File system prep
# File system prep
rm -rf *

# Checkout the core
git clone https://github.com/Project-Pier/ProjectPier-Core.git ./core
rm -rf ./core/.git

# Checkout the Files Plugin and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Plugin-Files.git ./plugin-files
rm -rf ./plugin-files/.git
cp -R ./plugin-files/* ./core/

# Checkout the Form Plugin and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Plugin-Form.git ./plugin-form
rm -rf ./plugin-form/.git
cp -R ./plugin-form/* ./core/

# Checkout the Links Plugin and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Plugin-Links.git ./plugin-links
rm -rf ./plugin-links/.git
cp -R ./plugin-links/* ./core/

# Checkout the Reports Plugin and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Plugin-Reports.git ./plugin-reports
rm -rf ./plugin-reports/.git
cp -R ./plugin-reports/* ./core/

# Checkout the Tags Plugin and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Plugin-Tags.git ./plugin-tags
rm -rf ./plugin-tags/.git
cp -R ./plugin-tags/* ./core/

# Checkout the Tickets Plugin and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Plugin-Tickets.git ./plugin-tickets 
rm -rf ./plugin-tickets/.git
cp -R ./plugin-tickets/* ./core/

# Checkout the Time Plugin and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Plugin-Time.git ./plugin-time
rm -rf ./plugin-time/.git
cp -R ./plugin-time/* ./core/

# Checkout the Wiki Plugin and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Plugin-Wiki.git ./plugin-wiki
rm -rf ./plugin-wiki/.git
cp -R ./plugin-wiki/* ./core/

# Checkout the Marine Theme and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Theme-Marine.git ./theme-marine
rm -rf ./theme-marine/.git
cp -R ./theme-marine/* ./core/

# Checkout the Translations and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Translations.git ./translations
rm -rf ./translations/.git
cp -R ./translations/* ./core/

# Set the version number
sed -i "s/0.8.8/0.9.0-Nightly-$BUILD_NUMBER/g" ./core/init.php
sed -i "s/0.8.8/0.9.0-Nightly-$BUILD_NUMBER/g" ./core/public/install/installation/templates/db/mysql/initial_data.php

# Create output folder and generate build date ID file
mkdir ./pkg
cd ./core
date -u > build_id.txt
echo Release configuration build, contains only plugins, and themes being considered for the next release >> build_id.txt
echo Jenkins Build Number $BUILD_NUMBER >> build_id.txt
zip -r ../pkg/projectpier-master-latest.zip ./*

# Stop here if you only want to build the release configuration.  To also build the "everything" 
# configuration for testing only, include the section below.  Note that this includes some
# tools which may not be safe in a production environment and some plug-ins that may not work as
# well as some themes that do not work very well.

cd ..

# Checkout the Redbase Theme and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Tools.git ./theme-tools
rm -rf ./theme-tools/.git
cp -R ./theme-tools/* ./core/

# Checkout the Redbase Theme and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Theme-Redbase.git ./theme-redbase
rm -rf ./theme-redbase/.git
cp -R ./theme-redbase/* ./core/

# Checkout the Magellan Theme and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Theme-Magellan.git ./theme-magellan
rm -rf ./theme-magellan/.git
cp -R ./theme-magellan/* ./core/

# Checkout the KampPro2 Theme and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Theme-KampPro2.git ./theme-kamppro2
rm -rf ./theme-kamppro2/.git
cp -R ./theme-kamppro2/* ./core/

# Checkout the GreenBase Theme and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Theme-Greenbase.git ./theme-greenbase
rm -rf ./theme-greenbase/.git
cp -R ./theme-greenbase/* ./core/

# Checkout the Bootstrapp Theme and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Theme-Bootstrapp.git ./theme-bootstrap
rm -rf ./theme-bootstrapp/.git
cp -R ./theme-bootstrapp/* ./core/

# Checkout the Reminders Plugin and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Plugin-Reminders.git ./plugin-reminders
rm -rf ./plugin-reminders/.git
cp -R ./plugin-reminders/* ./core/

# Checkout the Wikilinks Plugin and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Plugin-Wikilinks.git ./plugin-wikilinks
rm -rf ./plugin-wikilinks/.git
cp -R ./plugin-wikilinks/* ./core/

# Checkout the i18n Plugin and copy to the core
git clone https://github.com/Project-Pier/ProjectPier-Plugin-i18n.git ./plugin-i18n
rm -rf ./plugin-i18n/.git
cp -R ./plugin-i18n/* ./core/

cd ./core
date -u > build_id.txt
echo Testing configuration, contains plugins and themes not included in the release configuration. >> build_id.txt
echo This configuration is for testing only and should not be used for production systems as it contains
echo plugins, themes and tools that are known to be buggy and/or only meant for development. >> build_id.txt
echo Jenkins Build Number $BUILD_NUMBER >> build_id.txt
zip -r ../pkg/projectpier-master-everything-latest.zip ./*
