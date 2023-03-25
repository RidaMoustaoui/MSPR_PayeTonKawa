import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AugmentedReality extends StatefulWidget {
  const AugmentedReality({super.key});

  @override
  State<AugmentedReality> createState() => _AugmentedRealityState();
}

class _AugmentedRealityState extends State<AugmentedReality> {
  late ArCoreController arCoreController;
  _onArCoreViewCreated(ArCoreController _arcoreController) {
    arCoreController = _arcoreController;
    // _addSphere(arCoreController);
    _addToon(arCoreController);
  }

  _addToon(ArCoreController _arcoreController) {
    final node = ArCoreReferenceNode(
      name: 'Toon',
      object3DFileName: 'Toon.sfb',
      scale: vector.Vector3(0.5,0.5,0.5),
      position: vector.Vector3(0, 0, -1),
       rotation: vector.Vector4(0,180,0,0),
    );
    _arcoreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réalité augmentée'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }
}
