# Pi-hole Summary
Get an email every day with the data from Pi-hole's API.

## Installation
1. Install Node.js
- Enter the following commands below to install Node.js on your Raspberry Pi (Version may not be current)
```
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt install -y nodejs
```
- Be careful, piping to Bash can be dangerous

2. Clone the repository
```
git clone https://github.com/jaykepeters/Pi-hole-summary.git /opt/Pi-hole-summary`
cd /opt/Pi-Hole-Summary
```

3. Install the required dependencies
```
npm i emailjs simple-git
```

4. We are now going to create a `config.json` file, copy the file `bare-config.json` as config.json. Fill in all the data, it won't work if it doesn't have it all.
```
nano bare-config.json
mv bare-config.json config.json
```

5. Create a Cron Job with `cronjob -e` and append the following to the very bottom of the file:
```
59 23 * * * /usr/bin/node /opt/Pi-hole-summary/index.js
```
Now you should get an email from the setup account at 23:59 every night.

6. Run a test flight with `node /opt/Pi-hole-summary/index.js`. You should get the email. 

### Example E-mail
![Example E-mail][example.png]

## Tips
- For Gmail Users, ensure 2FA is enabled on your Google Account. Generate an App Password. In `config.json`, you put the app password as the password, and fill out the appropiate information. Google's sending server is `smtp.gmail.com`

## Config.json Params

|Parameter|Function|Example|
|---|---|---|
|`user`|The email address the bot uses for sending.|`"pihole@opmbx.org"`|
|`password`|The password for the `user` parameter.|`"Password1"`|
|`host`|The SMPT host the bot uses.|`"smtp.openmailbox.org"`|
|`toname`|The name to associate with `toaddr`|`Richard Stallman`|
|`toaddr`|The email address to send to.|`"rms@gnu.org"`|
|`ssl`|Trigger use of SSL in the SMPT negotiation. Do not use quotes|`true`, `false`|
