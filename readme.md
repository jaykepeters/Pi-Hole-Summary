# Pi Hole Summary
Get an email every day with the data from Pi Hole's API.
## Installation
Clone the repository on your Pi.

`git clone https://github.com/MilesGG/Pi-Hole-Summary.git`

We must now install Node.js, at the moment the raspbian repository doesn't make installing node.js very easy. To circumvent it, download the appropriate version from nodejs.org and extract it to your directory. Check your version with `node -v`

Install the dependencies for email sending
`/path/to/npm i emailjs`

Add your account.

    ...
    user: "miles@aaathats3as.com",
    password: "password123",
    host: "smtp.aaathats3as.com",
    ssl: true
    ...
    from: "Pi Hole Bot <miles@aaathats3as.com>",
    to: "Miles <miles@aaathats3as.com>",
    ...


Create a cronjob with `cronjob -e` and write one like this:

`59 23 * * * /home/pi/node-v6.9.5-linux-armv6l/bin/node /home/pi/pi-hole-summary/index.js`

Verify that it's registered properly with https://crontab.guru and `cronjob -l`.

Run a test flight with `/path/to/node /home/user/pi-hole-summary/index.js`. You should \*hopefully\* have an email in

Now you should get an email from the setup account at 23:59 every night.
