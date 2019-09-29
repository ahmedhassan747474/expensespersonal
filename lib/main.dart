import './wigdets/NewTransaction.dart';
import './wigdets/chart.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import 'wigdets/transaction_list.dart';

void main() => runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        // secondaryHeaderColor: Colors.blue
      ),
      home: MyHomePage(),
    ));

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Function function;

  List<Transaction> get _recentTransaction {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'new shoes', amount: 69.36, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'weekly shoes', amount: 69.36, date: DateTime.now()),
  ];

  void _addNewTransaction(String txtitle, double txAmount, DateTime s) {
    final txTranx = Transaction(
        title: txtitle,
        amount: txAmount,
        date: s,
        id: DateTime.now().toString());
    setState(() {
      transactions.add(txTranx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }
bool _showChart =false;
  @override
  Widget build(BuildContext context) {
    final isLandscape =  MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text("personal"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );
    final  txListWidget =  Container(
              height:(MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) * 0.50,
              child: TransactionList(transactions));
              final txChartWidget = Container(
            child: Chart(_recentTransaction),
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *  0.35,
              
          );
    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: <Widget>[
        if(isLandscape)  Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Show Chart'),
              Switch(
                value:  _showChart,
                onChanged:(value) {setState(() {
                   _showChart =value;
                });},
                
              ),
            ],
          ),
          if(!isLandscape) txChartWidget,
          if(!isLandscape)      txListWidget,
     if(isLandscape)   _showChart?   Container(
            child: Chart(_recentTransaction),
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *  0.7,
              
          )
          :
         txListWidget
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ), // This trailing comma ma kes auto-formatting nicer for build methods.
    );
  }
}
