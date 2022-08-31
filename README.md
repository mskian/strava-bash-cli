# Strava CLI

Bash Shell Script to Upload GPX file on your Strava Profile Activity  

## Requirements

- cURL
- jq
- Strava API

## Create API

- Create an Application from your Strava Account - <https://developers.strava.com/docs/getting-started/#account>
- After creating your App you can get your Client, Client Secret, Access Token, and Refresh Token
- Access Token is your API key it will expire in 6 Hours once you Generate
- For that we have Sperate file `token.sh` to Refresh the Expired API Key - Just add your Client ID, Secret, Refresh Token, and GPX File location
- it will autogenerate the `.env` file with New API and GPX File location

## Setup

- Use git to clone or download this Repo

```sh
git clone https://github.com/mskian/strava-bash-cli.git
cd strava-bash-cli
```

- Update Permission

```sh
chmod +x strava.sh
chmod +x token.sh
```

- Execute the Script

```sh
./strava.sh
```

- Generate New API Key

```sh
./token.sh
```

## How to use

- Display a Help Message

- `./strava.sh -h`

```sh
strava.sh [options]
        
           Example:
           strava.sh -l

          Options:
          -l   Get Upload Status
          -s   Upload GPX File to Strava
          -h   Display Help Message
          -v   Check CLI Version
```

- `./strava.sh -s` - Upload your GPX File
- `./strava.sh -l`- Check the Upload Status using Activity ID that you Got while Uploading GPX File

## Tested Apps

- OpenTracks GPX File - <https://github.com/OpenTracksApp/OpenTracks>
- MI band GPX File - Export via Zepp Life App
- you can use this CLI on your Android Device by using Termux - <https://github.com/termux/termux-app>

## Reference

- Strava Upload GPX File via cURL - <https://gist.github.com/michaellihs/bb262e2c6ee93093485361de282c242d>
- Getting Started with the Strava API - <https://developers.strava.com/docs/getting-started/>
- Generate NEW API - <https://developers.strava.com/docs/authentication/#refreshingexpiredaccesstokens>

## LICENSE

MIT
