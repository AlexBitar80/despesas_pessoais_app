import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final void Function(String) onRemove;

  const TransactionItem({
    super.key,
    required this.transaction,
    required this.mediaQuery,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
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
          trailing: mediaQuery.size.width > 480
              ? TextButton.icon(
                  onPressed: () => onRemove(transaction.id),
                  icon: const Icon(Icons.delete),
                  label: const Text('Excluir'),
                  style: TextButton.styleFrom(
                    foregroundColor:
                        Theme.of(context).colorScheme.errorContainer,
                  ),
                )
              : IconButton(
                  onPressed: () => onRemove(transaction.id),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.errorContainer,
                ),
        ),
      ),
    );
  }
}
