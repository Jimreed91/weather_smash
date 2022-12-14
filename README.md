# weather_smash
## Quick first time experimenting with bash scripting
## leverages https://home.openweathermap.org/ and https://ipinfo.io/ apis

Weather smash is a little shell script to pull some details about the current weather quickly from the commandline. It also gives the
hours until sunset because a quick console reference for that is useful to me. The script will use an api to determine location via IP address
automatically, but can also accept (city, country) as arguments if you want to override this or check the weather elsewhere.

Be aware I'm running linux, not sure how well this will play on os but windows certainly wont be worth it unless youre already set up to run bash

## Standard auto function
![alt text here](https://github.com/Jimreed91/weather_smash/blob/6cbebf116daf96bda4f936207b84bc7c50a319b6/demo_images/auto_chiba.png)
## Overriding with arguments
Note that currently both a city and country input are required if using this option
![alt text here](https://github.com/Jimreed91/weather_smash/blob/6cbebf116daf96bda4f936207b84bc7c50a319b6/demo_images/cairns.png)
![alt text here](https://github.com/Jimreed91/weather_smash/blob/6cbebf116daf96bda4f936207b84bc7c50a319b6/demo_images/skopje.png)

## Just add a free https://home.openweathermap.org/ api key to the file
``` bash
API_KEY={yourapikeyhere}
```
Then to give run permission
``` shell
chmod +rx weather_smash.sh
```
... and you should be good to give it a try

```
./weather_smash.sh
```

## Alias
If you really like it you can set up an alias, this is how it worked for me:
Open up your aliases file to edit
```
nano ~/.aliases
```
and add a line equivelant to this with the path to your weather_smash.sh file...

```
alias weather='/home/james/.local/bin/weather_smash.sh'
```
save the file and now this should work from anywhere by calling 'weather' or whatever you choose

![alt-text](https://github.com/Jimreed91/weather_smash/blob/7b670c4d7044b7d464aa19d1c51d946aa45d591b/demo_images/ALIAS.png)

