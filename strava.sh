#!/bin/bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Santhosh Veer
#   file:      strava.sh
#   created:   30.08.2022
#   revision:  30.08.2022
#   version:   0.1
# -----------------------------------------------------------------------------
#
#  Bash Shell Script to Upload GPX file on your Strava Profile Activity
#
#  DOCS - https://developers.strava.com/docs/uploads/
#  Create Strava API Account - https://developers.strava.com/docs/getting-started/#account
#  Reference - https://gist.github.com/michaellihs/bb262e2c6ee93093485361de282c242d
#
# -----------------------------------------------------------------------------

# Load ENV Variables
. .env

# Version Info
VERSION=0.1

## File name
SCRIPTNAME=$(basename "$0")

# Strava API key
ACCESSKEY=$ACCESSKEY

# Get Activity Status
get_status(){

echo -e "\\n"
echo -e "\\033[1;32m Get Activity Post Status \\033[0m"
echo -e "\\n"

echo -n "Enter the Activity ID: "
read -r activityid

echo -e "\\n"

# If no Inputs you will see this Alert message
if [[ ! $activityid ]]; then
    echo -e "\\033[1;31m Error: Activity ID Missing \\033[0m \\n"
    exit 1
fi

# Curl request
curl https://www.strava.com/api/v3/uploads/$activityid -H "Authorization: Bearer $ACCESSKEY"

echo -e "\\n"

}

# Upload GPX File to Strava
upload_gpx(){

echo -e "\\n"
echo -e "\\033[1;32m == Upload GPX File to Strava == \\033[0m"
echo -e "\\n"

echo -n "Enter your Activity Type (Run or Walk or Ride): "
read -r ridetype

echo -n "Enter GPX File Name: "
read -r filename

echo -e "\\n"

 # If no Inputs you will see this Alert message
 if [[ ! $ridetype ]]; then
    echo -e "\\033[1;31m Error: Ride Type Missing \\033[0m \\n"
    exit 1
fi

  if [[ ! $filename ]]; then
    echo -e "\\033[1;31m Error: File name is Missing \\033[0m \\n"
    exit 1
fi

# Curl request
  curl -X POST https://www.strava.com/api/v3/uploads \
  -H "Authorization: Bearer $ACCESSKEY" \
  -F activity_type=$ridetype \
  -F name="🔘 Activity Posted via CLI ☑" \
  -F description="#⃣ This Activity Upload via GPX File #⃣" \
  -F data_type="gpx" \
  -F file=$DIRLOC/$filename.gpx

}

# Help Message
help(){
  echo -e "\\n"
  echo -e  "$SCRIPTNAME [options]
        
           Example:
           strava.sh -l

          Options:
          -l   Get Upload Status
          -s   Upload GPX File to Strava
          -h   Display Help Message
          -v   Check CLI Version
          \\n"
}

# No input params triggers this error
check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      echo -e "\\n"
      echo -e "\\033[1;31m Error:  No input \\033[0m \\n"
      help
      exit 1
    fi
}

# Check for required packages
check_requirements(){
  local requirements=("$@")
  for app in "${requirements[@]}"; do
    type "$app" >/dev/null 2>&1 || \
      { echo >&2 "$app is required but it's not installed. Aborting."; exit 1; }
  done
}

# Main Functions
main(){
  check_for_empty_input "$@"
  check_requirements jq curl

  while getopts ':lsvh' flag; do
  case "$flag" in 
l)
  get_status
  ;;
s)
  upload_gpx
  ;;
v)
  echo -e "\\033[1;32m Version $VERSION \\033[0m"
  exit 0
  ;;
h) 
help
exit 0
;;
  ?)
  echo "script usage: $SCRIPTNAME [-l] [-s] [-v] [-h]" >&2
  exit 1
  ;;
*)

 esac
done
  shift $((OPTIND-1))
}

main "$@"

exit 0