import { doc, getDoc } from "firebase/firestore";

const functions = require("firebase-functions");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.sendEmail = functions.auth.user().beforeSignIn(async (user) => {
  functions.logger.info(user.email + " triggered mail send ", { structuredData: true });


  const docRef = doc(db, "user", user.id);
  const docSnap = await getDoc(docRef);
  const token = docSnap.auth_token;
  functions.logger.info(token, { structuredData: true });
  //const qr = new QRious();

  //qr.value = user.id;



  // var storageRef = firebase.storage().ref();
  // var ref = storageRef.child('qr.png');
  // ref.putString(qr.toDataURL(), 'data_url').then(function(snapshot) {
  //   console.log('Uploaded a data_url string!');
  // });
});
