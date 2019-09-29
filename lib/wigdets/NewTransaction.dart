import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function f;
  NewTransaction(this.f);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _dareTime;

  void suubmit() {
    if (titleController==null) {
       return;
    }
    final contTitl = titleController.text;
    final conAmount = double.parse(amountController.text);
    if (contTitl.isEmpty || conAmount <= 0||_dareTime==null ) {
      return;
    }
    widget.f(contTitl, conAmount
    ,_dareTime
    );
    Navigator.of(context).pop();
  }


  void poitDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickdate) {
      if (pickdate == null) {
        return;
      }

      setState(() {
        _dareTime = pickdate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom:MediaQuery.of(context).viewInsets.bottom+10 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (_) {
                  suubmit();
                },
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) {
                  suubmit();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: <Widget>[
                   Expanded(
                      child: Text(_dareTime == null
                          ? 'Nodate choose'
                          : DateFormat.yMd().format(_dareTime)),
                    ),
                    FlatButton(
                      child: Text(
                        'Choose',
                      ),
                      onPressed: poitDate,
                      textColor: Colors.pink,
                    )
                  ],
                ),
              ),
              FlatButton(
                  onPressed: suubmit,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(color: Colors.deepPurple),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
