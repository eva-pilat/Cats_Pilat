# For your convenience 
alias PlistBuddy=/usr/libexec/PlistBuddy

#PLIST
rm exportOptions.plist
PLIST="exportOptions.plist"
PlistBuddy -c "Add :destination string export" $PLIST
PlistBuddy -c "Add :method string development" $PLIST
PlistBuddy -c "Add :signingStyle string manual" $PLIST
PlistBuddy -c "Add :teamID string D85QWSUNYA" $PLIST
PlistBuddy -c "Add :signingCertificate string 'Apple Development: Yeva Matvieieva (777U5VP82Z)'" $PLIST
PlistBuddy -c "Add :provisioningProfiles dict" $PLIST
PlistBuddy -c "Add :provisioningProfiles:'ua.edu.ukma.apple-env.matvieieva.CatsAndModules-YevaPilat2' string 'c86a6c1d-cb86-4b95-8ae7-5e42c4862cd3'" $PLIST

WORKSPACE=CatsAndModules_YevaPilat2.xcworkspace
SCHEME="CatsAndModules_YevaPilat2 (CatsAndModules_YevaPilat2 project)"
CONFIG=Release
DEST="generic/platform=iOS"
ARCHIVE_PATH="./Archive.xcarchive"
EXPORT_PATH="./Exported_$1"
EXPORT_OPTIONS_PLIST="./exportOptions.plist"

# IMPLEMENT: 
# Read script input parameter and add it to your Info.plist. Values can either be CATS or DOGS

if [ "$1" != "CATS" ] && [ "$1" != "DOGS" ]; then
  echo "Помилка аргументу: очікується CATS або DOGS."
  exit 1
fi


#PlistBuddy -c "set :AnimalMode $1" "./CatsAndModules_YevaPilat2/CatsAndModules_YevaPilat2/CatsAndModules_YevaPilat2-Info.plist"

# IMPLEMENT:
# Clean build folder
xcodebuild clean -workspace "${WORKSPACE}" -scheme "${SCHEME}" -configuration "${CONFIG}"

# IMPLEMENT:
# Create archive

#xcodebuild archive \
#-archivePath "${ARCHIVE_PATH}" \
#-workspace "${WORKSPACE}" \
#-scheme "${SCHEME}" \
#-configuration "${CONFIG}" \
#-destination "${DEST}"

xcodebuild archive \
-workspace "${WORKSPACE}" \
-scheme "${SCHEME}" \
-configuration "${CONFIG}" \
-destination "${DEST}" \
-archivePath "${ARCHIVE_PATH}" \
ANIMAL_MODE_VALUE="$1"

# IMPLEMENT:
# Export archive

xcodebuild -exportArchive \
-archivePath "${ARCHIVE_PATH}" \
-exportPath "${EXPORT_PATH}" \
-exportOptionsPlist "${EXPORT_OPTIONS_PLIST}"

rm -r $ARCHIVE_PATH

echo "я відпрацював!"
