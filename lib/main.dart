import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo tenis de corrida',
      value: 155.65,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Corrida',
      value: 888.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Tenis',
      value: 777.65,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Sapato',
      value: 66.66,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Sandalia',
      value: 66.66,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Velho chinelo de andar',
      value: 999.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Andar manso',
      value: 1000.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Velho carro',
      value: 1.0,
      date: DateTime.now(),
    )
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Card(
                color: Colors.blue,
                child: Text('Gráfico'),
                elevation: 5,
              ),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
