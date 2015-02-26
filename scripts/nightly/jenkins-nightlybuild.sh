# Run as a build step using Jenkins CI
# To run outside of jenkins, replace any system variables with values
# of your own liking.
# System variables provided by Jenkins used in this script are:
#  $BUILD_NUMBER
#
# Requires git, sed, and zip to be installed

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
echo Jenkins Build Number $BUILD_NUMBER >> build_id.txt
zip -r ../pkg/projectpier-master-latest.zip ./*
