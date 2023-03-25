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
      body: Text(widget.produit.description),
    );
  }
}
