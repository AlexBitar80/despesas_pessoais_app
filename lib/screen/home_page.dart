import 'dart:io';
import 'package:despesas_pessoais/components/chart_transactions.dart';
import 'package:despesas_pessoais/components/transaction_card_list.dart';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();
  bool _showChart = false;

  final List<Transaction> _transactions = <Transaction>[];

  Widget _getIconButton(IconData icon, Function func) {
    return Platform.isIOS
        ? GestureDetector(onTap: () => func(), child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: () => func());
  }

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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(_showChart ? iconList : iconChart, () {
          setState(() {
            _showChart = !_showChart;
          });
        }),
      _getIconButton(Platform.isIOS ? CupertinoIcons.add : Icons.add, () {
        _openTransactionFormModal(context);
      })
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Despesas pessoais'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ), //parse da classe
          )
        : AppBar(
            title: Text(
              'Despesas pessoais',
              style: TextStyle(
                fontSize: 20 * mediaQuery.textScaleFactor,
              ),
            ),
            actions: actions,
          ) as PreferredSizeWidget;

    final availbaleHeiht = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !isLandscape)
              SizedBox(
                height: availbaleHeiht * (isLandscape ? 0.50 : 0.25),
                child:
                    ChartTransactions(recentTransaction: _recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availbaleHeiht * (isLandscape ? 1 : 0.75),
                child: TransactionCardList(
                  transactions: _transactions,
                  onRemove: _removeTransaction,
                ),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context),
            ),
          );
  }
}
