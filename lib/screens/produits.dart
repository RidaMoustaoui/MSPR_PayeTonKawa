import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Produits extends StatefulWidget {
  const Produits({super.key});

  @override
  State<Produits> createState() => _ProduitsState();
}

class _ProduitsState extends State<Produits> {

  Future<List<Products>> fetchProducts() async {
    var response = await http.get(Uri.parse("https://615f5fb4f7254d0017068109.mockapi.io/api/v1/products"));
    if (response.statusCode == 200) {
      final List resultat = convert.jsonDecode(response.body);
      return resultat.map(((e)=>Products.fromJson(e))).toList();
      // return Products.fromJson(convert.jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Produits'),
        ),
        body: FutureBuilder<List<Products>>(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  ...snapshot.data!.map((e) => ListTile(
                          title: Text(e.name),
                          subtitle: Text('Prix : '+e.price+"€"+"\nDescription : "+e.description+"\nCouleur : "+e.color+"\nStock : "+e.stock.toString()),
                        ),
                      )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}

class Products{
  final String id;
  final String name;
  final String price;
  final String description;
  final String color;
  final int stock;

  const Products(
    {
      required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.color,
      required this.stock
    }
  );

  factory Products.fromJson(Map<String, dynamic> json){
    return Products(
      id:           json["id"],
      name:         json["name"],
      price:        json['details']["price"],
      description:  json['details']["description"],
      color:        json['details']["color"],
      stock:        json['stock']
    );
  }
}