import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HHH(),
    );
  }
}

class HHH extends StatefulWidget {
  @override
  State<HHH> createState() => _HHHState();
}

class _HHHState extends State<HHH> {
  // const ADD({Key? key}) : super(key: key);
  final _id = TextEditingController();
  final _moTa = TextEditingController();

  final _maMonHoc = TextEditingController();

  final _tenMonHoc = TextEditingController();
  var _output = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 234, 255, 5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('ID:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _id,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('Mã môn học:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _maMonHoc,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('Tên Môn học:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _tenMonHoc,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('Mô Tả:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _moTa,
                      )),
                ],
              ),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  CollectionReference collection =
                      FirebaseFirestore.instance.collection('MonHoc');
                  await collection.add({
                    "moTa": _moTa.text,
                    "maMonHoc": _maMonHoc.text,
                    "tenMonHoc": _tenMonHoc.text
                  });
                },
                child: Text(
                  'Create',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      CollectionReference collection =
                          FirebaseFirestore.instance.collection('MonHoc');
                      collection.doc(_id.text).update({
                        "moTa": _moTa.text,
                        "maMonHoc": _maMonHoc.text,
                        "tenMonHoc": _tenMonHoc.text
                      });
                    },
                    child: Text(
                      'Update',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      CollectionReference collection =
                          FirebaseFirestore.instance.collection('MonHoc');
                      collection.doc(_id.text).delete();
                    },
                    child: Text(
                      'Delete',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      CollectionReference collection =
                          FirebaseFirestore.instance.collection('MonHoc');
                      QuerySnapshot querySnapshot = await collection.get();
                      List<DocumentSnapshot> documents = querySnapshot.docs;
                      setState(() {
                        for (var doc in documents) {
                          _output = _output + doc.data().toString();
                        }
                      });
                    },
                    child: Text(
                      'Print',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(_output),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
