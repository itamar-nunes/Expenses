import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _myTextScaleFactor = WidgetsBinding.instance.window.textScaleFactor;

    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20 * _myTextScaleFactor,
                    fontWeight: FontWeight.bold,
                  )))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  // final List<Transaction> _transactions = [];
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Tenis novo de corrida',
      value: 999.99,
      date: DateTime.now().subtract(Duration(days: 100)),
    ),
    Transaction(
      id: 't2',
      title: 'Chinelo velho de andar',
      value: 100.00,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't3',
      title: 'Alicate de unha',
      value: 10.00,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't4',
      title: 'Torquesa de dente',
      value: 10.66,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't5',
      title: 'Caixa preta',
      value: 2.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't6',
      title: 'Velho chinelo de andar',
      value: 99.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Andar manso',
      value: 100.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Velho carro',
      value: 1.0,
      date: DateTime.now(),
    )
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
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
    final appBar = AppBar(
      title: Text('Despesas Pessoais'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        )
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Exibir Gráfico'),
                Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
            if (_showChart)
              Container(
                height: availableHeight * 0.3,
                child: Chart(_recentTransactions),
              ),
            if (!_showChart)
              Container(
                  height: availableHeight * 0.7,
                  child: TransactionList(
                    _transactions,
                    _removeTransaction,
                  )),
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
