import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:la8iny/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const La8iny());
}

class La8iny extends StatelessWidget {
  const La8iny({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La8iny Chat App',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(),
    );
  }
}
