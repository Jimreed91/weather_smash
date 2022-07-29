#!/bin/bash

#Put your https://openweathermap.org/ api key here
API_KEY=6245de93abf71f6848e9bab04b8ea1cb


#text
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
clear='\033[0m'

#bgcolors
# Color variables
bg_red='\033[0;41m'
bg_green='\033[0;42m'
bg_yellow='\033[0;43m'
bg_blue='\033[0;44m'
bg_magenta='\033[0;45m'
bg_cyan='\033[0;46m'

#text
function bold_green {
    tput bold
    tput setaf 2
    echo -n "$@"

    tput sgr0
}

function temp_color {
  if [[ ${1} > 32 ]]
then
  echo ${red} ${1} ${clear}
elif [[ ${1} > 27 ]]
then
  echo ${yellow} ${1} ${clear}
elif [[ ${1} > 20 ]]
then
  echo ${green} ${1} ${clear}
elif [[ ${1} > 12 ]]
then
  echo ${blue} ${1} ${clear}
elif [[ ${1} > 8 ]]
then
  echo ${cyan} ${1} ${clear}
else
  echo ${1}
fi
}


#Auto geolocation
ip_info="$(curl -s https://ipinfo.io/json | jq .)"
ip_address="$(echo ${ip_info} | jq -r '.ip')"
auto_city="$(echo ${ip_info} | jq -r '.city')"
auto_country="$(echo ${ip_info} | jq -r '.country')"

#User can input arguments when running to override location
city=${1-${auto_city}}
country=${2-${auto_country}}
#Open weather api call
content=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=${city},${country}&limit=5&appid=${API_KEY}&units=metric")

user="$(whoami)"
#City/Country (actual returned by api not input)
location="$(echo "$content" | jq -r '.name'),$(echo "$content" | jq -r '.sys.country')"

#Weather conditions
humidity="$(echo "$content" | jq -r '.main.humidity')"
temp=$(echo "$content" | jq -r '.main.temp')
min_temp=$(echo "$content" | jq -r '.main.temp_min')
max_temp=$(echo "$content" | jq -r '.main.temp_max')
description=$(echo "$content" | jq -r '.weather[0].description')

#Time related
date_time=$(echo "$content" | jq -r '.dt')
sunset_time=$(echo "$content" | jq -r '.sys.sunset')
seconds_to_sunset=$(expr "$sunset_time" - "$date_time" )
time_to_sunset=$(date -d @"$seconds_to_sunset" -u +%H:%M:%S)

#View

echo "Starting Bash-Weather-Smash..."
date -d @"$date_time"
echo -e ${clear}"=========================================="${clear}
sleep 1
echo -e "Here is the current weather report for $(bold_green $location)"
sleep 1
sleep 1
echo -e $(bold_green "==========================================")
echo "$(bold_green Conditions:) $description"
sleep 1
echo -e "$(bold_green Temperature:) $(temp_color ${temp})°C || $(bold_green Low:) $(temp_color ${min_temp})°C || $(bold_green High:) $(temp_color ${max_temp})°C"
sleep 1
echo "$(bold_green Humidity:) $humidity%"
echo -e $(bold_green "==========================================")
sleep 1
echo "Time until sunset (H/M/S): $time_to_sunset "
echo -e ${clear}"=========================================="${clear}
