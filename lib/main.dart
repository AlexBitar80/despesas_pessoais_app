import 'package:despesas_pessoais/components/transaction_card.dart';
import 'package:despesas_pessoais/models/transaction.dart';
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

  final _transactions = <Transaction>[
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      amount: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      amount: 211.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Conta de Água',
      amount: 211.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Conta de Telefone',
      amount: 211.30,
      date: DateTime.now(),
    ),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Despesas Pessoais'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Card(
                color: Colors.blue,
                child: Text('Gráfico'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _transactions
                    .map(
                      (transaction) => TransactionCard(
                        title: transaction.title,
                        amount: transaction.amount,
                        date: transaction.date,
                      ),
                    )
                    .toList(),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Título',
                        ),
                      ),
                      TextField(
                        controller: valueController,
                        decoration: const InputDecoration(
                          labelText: 'Valor (R\$)',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text(
                              'Nova Transação',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => {
                              print(titleController.text),
                              print(valueController.text),
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
