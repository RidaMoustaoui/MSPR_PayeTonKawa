import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class AugmentedReality extends StatefulWidget {
  const AugmentedReality({super.key});

  @override
  State<AugmentedReality> createState() => _AugmentedRealityState();
}

class _AugmentedRealityState extends State<AugmentedReality> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Réalité augmentée'),
          ),
          body: Center(
              child: Column(children: <Widget>[
                ElevatedButton(
                  child: const Text(
                    'Test2',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    debugPrint("bonjour2");
                  },
                ),
          ]))),
    );
  }
}
