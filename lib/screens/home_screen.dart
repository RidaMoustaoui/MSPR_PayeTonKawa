import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_screen/screens/augmented_reality.dart';

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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AugmentedReality();
            }));
          },
        ),
      ),
    );
  }
}
