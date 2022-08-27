import 'package:fire_base/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const RootPage(),
  );
}

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireBase test',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController controller = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.ref();
  String readText = 'Не получено никаких данных';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FireBase test'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            MaterialButton(
              child: const Text('Создать запись'),
              onPressed: () {
                createRecord();
              },
            ),
            MaterialButton(
              child: const Text('Просмотреть запись'),
              onPressed: () {
                setState(() {
                  getData();
                });
              },
            ),
            MaterialButton(
              child: const Text('Редактировать запись'),
              onPressed: () {
                updateData();
              },
            ),
            MaterialButton(
              child: const Text('Удалить запись'),
              onPressed: () {
                deleteData();
              },
            ),
            Text(
              readText,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  createRecord() {
    databaseReference.child("post_1").set(
      {'title': controller.text},
    );
  }

  getData() {
    databaseReference.child('post_1').once().then(
          (value) => {
            readText = value.snapshot.value.toString(),
          },
        );
  }

  updateData() {
    databaseReference.child('post_1').update(
      {'title': 'newText'},
    );
  }

  deleteData() {
    databaseReference.child('post_1').remove();
  }
}
