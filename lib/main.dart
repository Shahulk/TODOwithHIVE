import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox<String>("Friends");
  runApp( const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   late Box<String> friendsBox;
  final idcontroller = TextEditingController();
  final namecontroller = TextEditingController();

  @override
  void initState() {
    friendsBox = Hive.box<String>('Friends');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: const Text(
          "TODO",
              style: TextStyle(fontSize: 30),
        )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: friendsBox.listenable(),
                  builder: (context, Box<String> Friends, _) {
                    return ListView.separated(
                        itemCount: Friends.keys.length,
                        separatorBuilder: (_, i) => Divider(),
                        itemBuilder: (ctx, i) {
                          final key = Friends.keys.toList()[i];
                          final value = Friends.get(key);

                          return ListTile(
                            title: Text(value.toString()),
                            subtitle: Text(key),
                          );
                        });
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: Text("Create",),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            child: SizedBox(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration:
                                          InputDecoration(label: Text("Key")),
                                      controller: idcontroller,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        label: Text("Value"),
                                      ),
                                      controller: namecontroller,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        child: Text("Submit"),
                                        onPressed: () {
                                          final key = idcontroller.text;
                                          final value = namecontroller.text;
                                          friendsBox.put(key, value);

                                          idcontroller.clear();
                                          namecontroller.clear();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: Text("Update"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            child: SizedBox(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration:
                                      InputDecoration(label: Text("Key")),
                                      controller: idcontroller,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        label: Text("Value"),
                                      ),
                                      controller: namecontroller,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(primary: Colors.black),
                                        child: Text("Submit"),
                                        onPressed: () {
                                          final key = idcontroller.text;
                                          final value = namecontroller.text;
                                          friendsBox.put(key, value);

                                          idcontroller.clear();
                                          namecontroller.clear();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: Text("Delete"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            child: SizedBox(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration:
                                      InputDecoration(label: Text("Key")),
                                      controller: idcontroller,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        child: Text("Submit"),
                                        onPressed: () {
                                          final key = idcontroller.text;

                                    friendsBox.delete(key);

                                          idcontroller.clear();

                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
