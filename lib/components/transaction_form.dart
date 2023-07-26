import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _onSubmitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(
      title,
      value,
      _selectedDate!,
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: 320,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: SvgPicture.asset('assets/images/line_modal.svg'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10.0,
                right: 10.0,
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    onSubmitted: (_) => _onSubmitForm(),
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                    ),
                  ),
                  TextField(
                    onSubmitted: (_) => _onSubmitForm(),
                    controller: _valueController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Valor (R\$)',
                      prefixText: 'R\$ ',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedDate == null
                                ? 'Nenhuma data selecionada:'
                                : 'Data selecionada: ${DateFormat('dd/MM/y').format(
                                    _selectedDate ?? DateTime.now(),
                                  )}',
                          ),
                        ),
                        TextButton(
                          child: const Text('Selecionar data'),
                          onPressed: () => _showDialog(
                            CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              maximumDate: DateTime.now(),
                              minimumDate: DateTime(2020),
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              showDayOfWeek: true,
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() => _selectedDate = newDate);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SafeArea(
                    child: CupertinoButton.filled(
                      onPressed: _onSubmitForm,
                      child: const Text(
                        'Nova Transação',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
