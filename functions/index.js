const functions = require("firebase-functions");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.sendEmail = functions.auth.user().beforeSignIn((user) => {
  functions.logger.info(user.email + " triggered mail send ", {structuredData: true});
});
