import 'package:flutter/material.dart';
import 'package:login_screen/screens/augmented_reality.dart';
import 'package:login_screen/screens/produits.dart';

class ProduitDetail extends StatefulWidget {
  Products produit;
  ProduitDetail({required this.produit, super.key});

  @override
  State<ProduitDetail> createState() => _ProduitDetailState();
}

class _ProduitDetailState extends State<ProduitDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Détails du produit'),
        ),
        body: Material(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.grey.shade50,
          elevation: 3,
          child: ListTile(
              title: Text(
                  "\nNom : \n\t${widget.produit.name}\n\nDescription : \n\t${widget.produit.description}\n\nPrix : \n\t${widget.produit.price} Euros\n\nCouleur : \n\t${widget.produit.color}\n\nStock : \n\t${widget.produit.stock}\n"))
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const AugmentedReality();
        }));
        },
        child: const Icon(Icons.adb_rounded),
      ),
      );
  }
}
