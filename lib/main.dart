import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Just do It'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _tarefas = [];
  String input = "";

  @override
  void initState() {
    super.initState();
  }

  void _addTarefa() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text("Digite a tarefa"),
            content: TextField(
              onChanged: (String tarefa) {
                input = tarefa;
              },
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      _tarefas.add(input);
                    });

                    Navigator.of(context).pop();
                  },
                  child: Text("Adicionar"))
            ],
          );
        });
    setState(() {
      //_tarefas.add();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        brightness: Brightness.dark, // status bar brightness
      ),
      body: ListView.builder(
          itemCount: _tarefas.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(_tarefas[index]),
                child: Card(
                  elevation: 1,
                  margin: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(_tarefas[index]),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          _tarefas.remove(_tarefas[index]);
                        });
                      },
                    ),
                  ),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTarefa,
        tooltip: 'Adicionar tarefa',
        child: Icon(Icons.add),
      ),
    );
  }
}
