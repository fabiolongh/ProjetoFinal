import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  // A classe TransactionList, recebe uma lista de Transactions(criada a classe anteriormente) chamada transaction
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return Card(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Theme.of(context).secondaryHeaderColor,
                    width: 2,
                  )),
                  padding: const EdgeInsets.all(10),
                  //children: const Icon(Icons.price_check),
                  child: Text(
                      'R\$ ${tr.value.toStringAsFixed(2)}', // ou 'R\$' + tr.value.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.redAccent)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(tr.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black)),
                    Text(
                        DateFormat('dd MMM y')
                            .format(tr.date), //Package do INTL
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey[550])),
                    //Adicionar novo elemento aqui
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
