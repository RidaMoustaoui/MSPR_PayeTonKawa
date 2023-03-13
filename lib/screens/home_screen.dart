import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_screen/screens/augmented_reality.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text(('Réalitée Augmentée')),
          onPressed: () {
              testRestAPI("");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AugmentedReality();
            }));
          },
        ),
      ),
    );
  }
  void testRestAPI(String arguments) async {
    var url = Uri.https("615f5fb4f7254d0017068109.mockapi.io", "/api/v1/products", {'q': '{https}'});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      // debugPrint(response.body);
      var jsonResponse = convert.jsonDecode(response.body);
      var productName = jsonResponse[0]['name']; // IMPORTNANT : comment dynamiser le 0? // pas tres important : dynamiser le name et le reste des colonnes
      debugPrint(productName);
    }
    else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }
  }
}
