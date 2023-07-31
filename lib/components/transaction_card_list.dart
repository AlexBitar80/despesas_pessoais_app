import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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

    return SizedBox(
      height: MediaQuery.of(context).size.height -
          appBarHeight -
          MediaQuery.of(context).padding.top,
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
                      width: MediaQuery.of(context).size.width - 30,
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
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                              'R\$${transaction.amount.toStringAsFixed(2)}',
                            ),
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            DateFormat('d MMM y').format(transaction.date),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () => onRemove(transaction.id),
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.errorContainer,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
