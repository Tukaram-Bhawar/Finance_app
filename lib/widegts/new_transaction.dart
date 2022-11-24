import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtxt;

  NewTransaction(this.addtxt);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroler = TextEditingController();
  final amountcontroler = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    final edittitle = titlecontroler.text;
    final editamount = double.parse(amountcontroler.text);
    if (edittitle.isEmpty || editamount < 0 || _selectedDate == null) {
      return;
    }
    widget.addtxt(edittitle, editamount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickDate) {
      if (pickDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titlecontroler,
              onSubmitted: (_) => submitData(),
              // onChanged: (value) => titleinput = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountcontroler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: ((value) => amountinput = value),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date choosen '
                          : DateFormat.yMd().format(_selectedDate!),
                    ),
                  ),
                  TextButton(
                    onPressed: _datePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text('Add Transaction'),
                onPressed: submitData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
