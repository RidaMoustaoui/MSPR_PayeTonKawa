import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/screens/home_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class QrScanScreen extends StatefulWidget {
  String doubleAuthToken;
  QrScanScreen({required this.doubleAuthToken, super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR_code');
  QRViewController? controller;
  Barcode? qrCode;

  sendEmail(String subject, String body,String recipientemail) async{
    final Email email= Email(
    body : body,
    subject: subject,
    recipients: [recipientemail],
    
    isHTML: false,);
    await FlutterEmailSender.send(email);
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    bool isOk = false;

    controller.scannedDataStream.listen(
      (qrCode) {
        if (qrCode.code == widget.doubleAuthToken && !isOk) {
          isOk = true;
          /**
         * recupère l'utilisateur actuellement connecté
         */
          var authUser = FirebaseAuth.instance.currentUser;
          /**
         * Supprime le token de connexion
         */
          FirebaseFirestore.instance
              .collection('user')
              .doc(authUser!.uid)
              .update({'auth_token': ''});
          /**
         * Redirige vers la page de connexion
         */
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const HomeScreen();
          }));
        } else {
          log("message");
        }
      },
    );
    /**
         * TODO
         * Retirer la redirection
         */
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    }));
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        //buildQrView(widget)
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(borderColor: Colors.blue.shade50),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
