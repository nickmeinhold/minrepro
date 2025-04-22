import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _outputString = '';

  Future<void> _retrieveDocs() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('collection')
            .where(FieldPath.documentId, whereIn: ['a', 'set', 'of', 'ids'])
            .get();

    for (final doc in querySnapshot.docs) {
      _outputString += doc['text'] + ' ';
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _retrieveDocs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: Text(_outputString))),
    );
  }
}
