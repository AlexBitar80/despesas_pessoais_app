import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:despesas_pessoais/components/adaptative_button.dart';
import 'package:despesas_pessoais/components/adaptative_date_picker.dart';
import 'package:despesas_pessoais/components/adaptative_texfield.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  double toDouble(String string) {
    final RegExp regExp = RegExp(r'\d+.\d{2}');
    final String text = regExp.stringMatch(string)!;
    return double.parse(text.replaceAll(',', '.'));
  }

  _onSubmitForm() {
    final title = _titleController.text;
    final value = toDouble(_valueController.text);

    if (title.isEmpty || value <= 0.0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(
      title,
      value,
      _selectedDate!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: Platform.isIOS ? 370 : 320,
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
                  AdaptativeTextfield(
                    onSubmitted: (_) => _onSubmitForm(),
                    controller: _titleController,
                    titleLabel: 'Título',
                  ),
                  AdaptativeTextfield(
                    onSubmitted: (_) => _onSubmitForm(),
                    controller: _valueController,
                    titleLabel: 'Valor (R\$)',
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(
                        moeda: Platform.isIOS ? true : false,
                      ),
                    ],
                    prefix: Platform.isIOS ? '' : 'R\$ ',
                  ),
                  AdaptativeDatePicker(
                    selectedDate: _selectedDate ?? DateTime.now(),
                    onDateChanged: (newDate) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SafeArea(
                    child: AdaptativeButton(
                      label: "Nova transação",
                      onPressed: _onSubmitForm,
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
