import 'dart:math';

import 'package:flutter/material.dart';
import 'transactio_list.dart';
import 'transaction_form.dart';
import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transaction = [
    //A lista é final porque o Homepage é Stateless (Lista estatica, homepagetb)
    Transaction(
      id: 't1',
      title: 'Novo Tenis de corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
        id: 't2', title: 'Conta de Luz', value: 211.76, date: DateTime.now()),
  ];

  _addTransaction(String title, double value, int opcao) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());
    if (opcao == 1) {
      setState(() {
        _transaction.add(newTransaction);
      });
    } else {
      if (_transaction.length > 0)
        setState(() {
          _transaction.removeLast();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionList(
            _transaction), //comunicação direta, passo os dados diretamente para a classe
        TransactionForm(_addTransaction),
        //Comunicação indireta, passo uma função para a classe
        /*
        TextButton(
            onPressed: () {
              setState(() {
                _transaction.removeLast();
              });
            },
            child: const Text('Excluir Ultima transação')), */
      ],
    );
  }
}
