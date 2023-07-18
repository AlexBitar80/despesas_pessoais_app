import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionForm({
    super.key,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
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
                    onPressed: () {
                      final title = titleController.text;
                      final value =
                          double.tryParse(valueController.text) ?? 0.0;

                      onSubmit(title, value);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
