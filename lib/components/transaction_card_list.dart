import 'package:despesas_pessoais/components/transaction_item.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionCardList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  final String waintingImage = 'assets/images/waiting.svg';

  const TransactionCardList({
    super.key,
    required this.transactions,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      height: mediaQuery.size.height - appBarHeight - mediaQuery.padding.top,
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Nenhuma transação cadastrada!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      width: mediaQuery.size.width - 30,
                      child: SvgPicture.asset(waintingImage),
                    ),
                    const Spacer(),
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return TransactionItem(
                  transaction: transaction,
                  mediaQuery: mediaQuery,
                  onRemove: onRemove,
                );
              },
            ),
    );
  }
}
