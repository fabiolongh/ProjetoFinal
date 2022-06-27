import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, int) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return showDialog(
          context: context,
          builder: (_) {
            return errorAlert;
          });
    }
    widget.onSubmit(title, value, 1);
    //FocusScope.of(context).requestFocus(FocusNode()); já faz isso sozinho, fecha o teclado
    Navigator.pop(context);
  }

  AlertDialog errorAlert = AlertDialog(
      title: const Text('Erro!'),
      content: const Text(
          'Sua operação não foi executada por falta de informações!!'),
      actions: [
        TextButton(child: Text('Retornar'), onPressed: () {}),
      ]);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Ativo',
              ),
            ),
            TextField(
                controller: valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted:
                    null /*(value) =>
                    _submitForm()*/
                , //Quando aperta o simbolo de ok ele já submete o form
                decoration: InputDecoration(
                  labelText: 'Valor(R\$)',
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    onPressed:
                        _submitForm /*{
                      final title = titleController.text;
                      final value =
                          double.tryParse(valueController.text) ?? 0.0;
                      onSubmit(title, value, 1);
                    }*/
                    ,
                    child: const Text('Nova Transação')),
                TextButton(
                    onPressed: () {
                      widget.onSubmit('title', 0, 2);
                    },
                    child: const Text('Desfazer Ultima transação')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
