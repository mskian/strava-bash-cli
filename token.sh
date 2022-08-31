#
# Create Strava API Account - https://developers.strava.com/docs/getting-started/#account
# Generate Access Token - https://developers.strava.com/docs/authentication/#refreshingexpiredaccesstokens
#

client=YOUR CLIENT ID
clientsecret=YOUR CLIENT SECRET
token=REFRESH TOKEN

# Don't Remove @
gpxlocation=@/home/user/gpx

token=$( curl --silent --output  -X POST https://www.strava.com/api/v3/oauth/token \
  -d client_id=$client \
  -d client_secret=$clientsecret \
  -d grant_type=refresh_token \
  -d refresh_token=$token | jq -r '.access_token' )

echo -e "ACCESSKEY=$token \nDIRLOC=$gpxlocation" | tee .env
