import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_screen/screens/qr_scan_screen.dart';
import 'package:login_screen/utils/helper_functions.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../utils/constants.dart';
import '../animations/change_screen_animation.dart';
import 'bottom_text.dart';
import 'top_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:http/http.dart';
// import 'package:emailjs/emailjs.dart';

enum Screens {
  createAccount,
  welcomeBack,
}

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  late final List<Widget> createAccountContent;
  late final List<Widget> loginContent;
  final signupName = TextEditingController();
  final signupMail = TextEditingController();
  final signupPassword = TextEditingController();
  final loginMail = TextEditingController();
  final loginPassword = TextEditingController();

  // final qrKey = GlobalKey(debugLabel: 'QR_code');
  // final serverID = '';
  // final templateID = '';
  // final userID = '';

  Widget inputField1(String hint, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            controller: signupName,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField2(String hint, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            controller: signupMail,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField3(String hint, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            obscureText: true,
            controller: signupPassword,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField4(String hint, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            controller: loginMail,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField5(String hint, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            obscureText: true,
            controller: loginPassword,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget createQRCode(String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 268),
      child: QrImage(
        data: data,
        size: 100,
        backgroundColor: Colors.white,
      ),
    );
  }

  // void sendMail() {
  //   //EmailJS.send(serviceID, templateID);
  //   final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  //   //POST https://api.emailjs.com/api/v1.0/email/send
  // }

  verifConMethod(String page) async {
    if (page == "Créer") {
      if (signupName.text != "" &&
          signupMail.text != "" &&
          signupPassword.text != "") {
        var auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: signupMail.text.trim(),
            password: signupPassword.text.trim());

        if (auth.user != null) {
          var doubleAuthToken = const Uuid().v4();
          /**
           * TODO mettre cette appel API dans une classe à part
           */
          String pseudo = signupName.text.trim();
          String email = signupMail.text.trim();

          FirebaseFirestore.instance
              .collection('user')
              .doc(auth.user!.uid)
              .set(({'email': '$email', 'pseudo': '$pseudo'}));
        }

        /*
        * TODO
        * Redirect to SignIn page
        */
        Fluttertoast.showToast(
            msg: "Votre compte a été créé.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    if (page == "Connexion") {
      if (loginMail.text != "" && loginPassword.text != "") {
        String doubleAuthToken = '';
        var auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: loginMail.text.trim(), password: loginPassword.text.trim());

        if (auth.user != null) {
          doubleAuthToken = const Uuid().v4().toString();
          /**
           * TODO mettre cette appel API dans une classe à part
           */
          FirebaseFirestore.instance
              .collection('user')
              .doc(auth.user!.uid)
              .update({'auth_token': '$doubleAuthToken'});
        }

        Fluttertoast.showToast(
            msg: "Bienvenue",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);

        sendMail() async {
          String username = 'sskman8855@gmail.com';
          String password = 'Salman95';
          final smtpServer = gmail(username, password);

          final message = Message()
            ..from = Address(username)
            ..recipients.add(loginMail.text)
            ..subject = 'Flutter Send Mail'
            ..html = "<h3>Thanks for connecting with us!</h3>\n<p></p>";
          try {
            final sendReport = await send(message, smtpServer);
            debugPrint('Message sent:$sendReport');
          } on MailerException catch (e) {
            debugPrint("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
            debugPrint(e.toString());
            debugPrint("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
          }
        }

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return QrScanScreen(
            doubleAuthToken: doubleAuthToken,
          );
        }));
        await sendMail();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return createQRCode(doubleAuthToken);
        }));
      }
    }
  }

  Widget loginButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          verifConMethod(title);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: kSecondaryColor,
          shape: const StadiumBorder(),
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    createAccountContent = [
      inputField1('Nom d\'utilisateur', Ionicons.person),
      inputField2('Adresse mail', Ionicons.mail_unread),
      inputField3('Mot de passe', Ionicons.lock_closed),
      loginButton('Créer')
    ];

    loginContent = [
      inputField4('Adresse mail', Ionicons.mail_unread),
      inputField5('Mot de passe', Ionicons.lock_closed),
      loginButton('Connexion'),
    ];

    ChangeScreenAnimation.initialize(
      vsync: this,
      createAccountItems: createAccountContent.length,
      loginItems: loginContent.length,
    );

    for (var i = 0; i < createAccountContent.length; i++) {
      createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.createAccountAnimations[i],
        child: createAccountContent[i],
      );
    }

    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.loginAnimations[i],
        child: loginContent[i],
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    ChangeScreenAnimation.dispose();
    signupName.dispose();
    signupMail.dispose();
    signupPassword.dispose();
    loginMail.dispose();
    loginPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 136,
          left: 24,
          child: TopText(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: createAccountContent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: loginContent,
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: BottomText(),
          ),
        ),
      ],
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
