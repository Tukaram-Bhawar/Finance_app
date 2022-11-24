import 'package:finance/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class chart extends StatelessWidget {
  final List<Transaction> recenttransaction;
  chart(this.recenttransaction);

  List<Map<String, Object>> get groupTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (int i = 0; i < recenttransaction.length; i++) {
        if (recenttransaction[i].date.day == weekDay.day &&
            recenttransaction[i].date.month == weekDay.month &&
            recenttransaction[i].date.year == weekDay.year) {
          totalSum += recenttransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalsum {
    return groupTransactionValue.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'] as String,
                data['amount'] as double,
                totalsum == 0.0 ? 0.0 : (data['amount'] as double) / totalsum,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
