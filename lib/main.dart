import 'package:despesas_pessoais/components/transaction_user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Despesas Pessoais'),
        ),
        body: const SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  color: Colors.blue,
                  child: Text('Gráfico'),
                ),
                TransactionUser()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
