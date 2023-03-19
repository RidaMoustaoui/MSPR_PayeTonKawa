import 'package:flutter/material.dart';
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
        borderRadius:
            const BorderRadius.all(Radius.circular(20)),
        color: Colors.grey.shade50,
        elevation: 3,
        child: ListTile(
          title: Text("\nDescription : \n\n"+widget.produit.description+"\n"),
        ))
    );
  }
}
