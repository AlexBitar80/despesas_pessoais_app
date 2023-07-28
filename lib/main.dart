import 'package:despesas_pessoais/components/chart_transactions.dart';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';

import 'components/transaction_card_list.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.green[600],
          secondary: Colors.orange[400],
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  final List<Transaction> _transactions = <Transaction>[
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      amount: 310.76,
      date: DateTime.now().subtract(
        const Duration(
          days: 3,
        ),
      ),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      amount: 211.30,
      date: DateTime.now().subtract(
        const Duration(
          days: 4,
        ),
      ),
    ),
    Transaction(
      id: 't3',
      title: 'Conta de Água',
      amount: 211.30,
      date: DateTime.now().subtract(
        const Duration(
          days: 5,
        ),
      ),
    ),
    Transaction(
      id: 't4',
      title: 'Conta de Internet',
      amount: 211.30,
      date: DateTime.now().subtract(
        const Duration(
          days: 6,
        ),
      ),
    ),
    Transaction(
      id: 't5',
      title: 'Conta de Telefone',
      amount: 211.30,
      date: DateTime.now().subtract(
        const Duration(
          days: 7,
        ),
      ),
    ),
  ];

  _addTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: _addTransaction,
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          const Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: [
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    final availbaleHeiht = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: availbaleHeiht * 0.25,
              child: ChartTransactions(recentTransaction: _recentTransactions),
            ),
            SizedBox(
              height: availbaleHeiht * 0.75,
              child: TransactionCardList(
                transactions: _transactions,
                onRemove: _removeTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
    );
  }
}
