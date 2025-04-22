import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minrepro/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _ = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _outputString = '';

  Future<void> _setAndRetrieveDocs() async {
    await FirebaseFirestore.instance.collection('collection').doc('a').set({
      'text': 'a',
    });
    await FirebaseFirestore.instance.collection('collection').doc('b').set({
      'text': 'b',
    });
    await FirebaseFirestore.instance.collection('collection').doc('c').set({
      'text': 'c',
    });
    await FirebaseFirestore.instance.collection('collection').doc('d').set({
      'text': 'd',
    });

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('collection')
            .where(FieldPath.documentId, whereIn: ['a', 'b', 'c', 'd'])
            .get();

    for (final doc in querySnapshot.docs) {
      _outputString += doc['text'] + ' ';
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _setAndRetrieveDocs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: Text(_outputString))),
    );
  }
}
