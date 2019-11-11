
class GryphPushService {
    async sendPush({}) {
        var apn = require('apn');
        var options = {
            token: {
             key: "../resources/AuthKey_R7H2UN93CJ.p8",
            keyId: "R7H2UN93CJ",
            teamId: "667D8S5SPP"
            },
            production: false
        };
       
        var apnProvider = new apn.Provider(options);

        var note = new apn.Notification();

        note.expiry = Math.floor(Date.now() / 1000) + 3600; // Expires 1 hour from now.
        note.sound = "ping.aiff";
        note.alert = "You have a new message";
        note.payload = {'messageFrom': 'John Appleseed'};
        
        apnProvider.send(note, "0373d6d1cfc3ed2fe261460f541a9fa1cd5c966e5e8200c3777cb1e33e310333").then( (result) => {
            console.log(result);

            apnProvider.shutdown();
        });
    }
}