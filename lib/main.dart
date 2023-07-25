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
      id: 't0',
      title: 'Novo controle de PS4',
      amount: 400.00,
      date: DateTime.now().subtract(
        const Duration(
          days: 2,
        ),
      ),
    ),
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
      amount: 320.76,
      date: DateTime.now().subtract(
        const Duration(
          days: 4,
        ),
      ),
    ),
  ];

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

  _addTransaction(String title, double amount) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChartTransactions(recentTransaction: _recentTransactions),
            TransactionCardList(transactions: _transactions),
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
