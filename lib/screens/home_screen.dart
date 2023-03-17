import 'package:flutter/material.dart';
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
    return MaterialApp(  
      home: Scaffold(  
          appBar: AppBar(  
            title: const Text('Page d\'accueil'),  
          ),  
          body: Center(child: Column(children: <Widget>[  
            Container(  
              margin: const EdgeInsets.all(25),  
              child: ElevatedButton(  
                child: const Text('Produits', style: TextStyle(fontSize: 20.0),),  
                onPressed: () {
                  testRestAPI("");
                }, 
              ),  
            ),  
            ElevatedButton(  
              child: const Text('Réalité augmentée', style: TextStyle(fontSize: 20.0),),  
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AugmentedReality();
            }));
          }, 
            ),  
          ]  
         ))  
      ),  
    );  
  }

  void testRestAPI(String arguments) async {
    var url = Uri.https("615f5fb4f7254d0017068109.mockapi.io",
        "/api/v1/products", {'q': '{https}'});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      // debugPrint(response.body);
      var jsonResponse = convert.jsonDecode(response.body);
      for (int i = 0; i < jsonResponse.length; i++) {
        debugPrint(jsonResponse[i]['id']);
        debugPrint(jsonResponse[i]['name']);
        debugPrint(jsonResponse[i]['details']['price']);
        debugPrint(jsonResponse[i]['details']['description']);
        debugPrint(jsonResponse[i]['details']['color']);
        debugPrint('${jsonResponse[i]['stock']}');
      }
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }
  }
}
