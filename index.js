var fs = require("fs");
var http = require("http");
var email = require("emailjs");
var git = require("simple-git");

// This is where your email config goes.
var config = JSON.parse(fs.readFileSync("config.json"));
var server = email.server.connect({
        user: config.user,
        password: config.password,
        host: config.host,
        ssl: config.ssl
});

// Get the current date
function today() {
     var date = new Date();
     var year = date.getFullYear();
     var month = date.getMonth() + 1;
     month = (month < 10 ? "0" : "") + month;
     var day = date.getDate();
     day = (day < 10 ? "0" : "") + day;
     return month + "/" + day + "/" + year;
 }

// HTTP GET stats from localhost
http.get('http://127.0.0.1/admin/api.php', (res) => {
     res.setEncoding('utf8');
     res.on('data', function (body) {
         var obj = JSON.parse(body);
         var summary = "This is your daily Pi-hole summary for " + today() + ".\n\nDomains being blocked: " +
         obj.domains_being_blocked.toLocaleString() + "\nDNS queries today: " + obj.dns_queries_today.toLocaleString() + "\nAds blocked today: " +
         obj.ads_blocked_today.toLocaleString() + "\nAds to total queries: " + Math.floor((obj.ads_percentage_today/100) * 100) + '%';

        // send the message itself
         server.send({
             text: summary,
             from: "Pi-hole Bot <" + config.user  + ">",
             to: config.toname + " <" + config.toaddr + ">",
             subject: "Your Daily Pi-hole Summary for " + today()
         }, function (err, message) { console.log("Errors: " + err); });

     });
});
