import 'package:flutter/material.dart';
import 'package:flutter_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
  Color textColor = Colors.amber[200];

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          450, // define the list view height is equal to 300, otherwise the height of the list view would be infinite!
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'Henüz işlem eklenmedi!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '${transactions[index].amount.toStringAsFixed(2)}₺',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy').format(transactions[index].date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.brown[50],
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transactions[index]
                          .id), //fonksiyon referans gösterdiği için isimsiz fonksiyon atadık
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
