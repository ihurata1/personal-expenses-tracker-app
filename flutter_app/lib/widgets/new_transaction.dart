import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop(); // Closes the top most screen
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then(
      (date) {
        if (date == null) return;
        setState(() {
          _selectedDate = date;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Başlık',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
              ),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              //onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Miktar',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
              ),
              controller: _amountController,
              keyboardType: TextInputType
                  .number, //.numberWithOptions(decimal: true) for IOS,
              onSubmitted: (_) => _submitData(),
              //onChanged: (value) => amountInput = value,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Tarih Seçilmedi!'
                          : 'Tarih: ${DateFormat('d/M/yyyy').format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).accentColor,
                    child: Text(
                      'Tarih Seç',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            FlatButton(
              color: Theme.of(context).accentColor,
              child: Text(
                'İşlem Ekle',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
