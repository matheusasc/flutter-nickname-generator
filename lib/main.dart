import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerador',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Gerador de nicks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _nameController = TextEditingController();
  List<String> _nicknameSuggestions = [];

  void _generateNicknameSuggestions(String name) {
    _nicknameSuggestions.clear();
    final random = Random();

    _nicknameSuggestions.add(name);

    List<String> nameParts = name.split(' ');
    if (nameParts.length > 1) {
      String mixedName = nameParts.reversed.join(' ');
      _nicknameSuggestions.add(mixedName);
    }

    if (name.length > 3) {
      String cutName = name.substring(0, name.length - 2);
      _nicknameSuggestions.add(cutName);
    }

    for (int i = 0; i < 3; i++) {
      String randomSuffix = random.nextInt(1000).toString();
      _nicknameSuggestions.add('$name$randomSuffix');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Insira seu nome:',
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Insira seu nome',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String enteredName = _nameController.text;
              _generateNicknameSuggestions(enteredName);

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Sugestões de nicknames'),
                    content: Column(
                      children: _nicknameSuggestions
                          .map((nickname) => Text(nickname))
                          .toList(),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Gerar Nicknames'),
          )
        ],
      ),
    );
  }
}
