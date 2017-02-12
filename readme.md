# Pi Hole Summary
Get an email every day with the data from Pi Hole's API.
## Installation
1. Clone the repository on your Pi.

  `git clone https://github.com/MilesGG/Pi-Hole-Summary.git`

2. We must now install Node.js, at the moment the raspbian repository doesn't make installing node.js very easy. To circumvent it, download the appropriate version from nodejs.org and extract it to your directory. Check your version with `node -v`
3. However, the version of npm is perfectly functional. Install it with `sudo apt install npm`
4. Install the dependencies for email sending and automatic updates
`/path/to/npm i emailjs simple-git`
5. We are now going to create a `config.json`, copy the file `bare-config.json` as config.json. Fill in all the data, it won't work if it doesn't have it all.
6. Create a cronjob with `cronjob -e` and write one like this:

  `59 23 * * * /home/pi/node-v6.9.5-linux-armv6l/bin/node /home/pi/pi-hole-summary/index.js`

  Verify that it's registered properly with https://crontab.guru and `cronjob -l`.

7. Run a test flight with `/path/to/node /home/user/pi-hole-summary/index.js`. You should \*hopefully\* have an email in

  Now you should get an email from the setup account at 23:59 every night.
## Config.json Params

|Parameter|Function|Example|
|---|---|---|
|`user`|The email address the bot uses for sending.|`"pihole@opmbx.org"`|
|`password`|The password for the `user` parameter.|`"Password1"`|
|`host`|The SMPT host the bot uses.|`"smtp.openmailbox.org"`|
|`toname`|The name to associate with `toaddr`|`Richard Stallman`|
|`toaddr`|The email address to send to.|`"rms@gnu.org"`|
|`ssl`|Trigger use of SSL in the SMPT negotiation. Do not use quotes|`true`, `false`|
