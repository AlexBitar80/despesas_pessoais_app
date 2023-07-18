import 'package:despesas_pessoais/components/transaction_card_list.dart';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
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
  ];

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionCardList(transactions: _transactions),
        TransactionForm(onSubmit: _addTransaction),
      ],
    );
  }
}
