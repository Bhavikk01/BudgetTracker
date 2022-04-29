import 'package:budget_tracker/model/TransactionEntry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionDialog extends StatefulWidget {

  final Function(TransactionEntry) itemToAdd;

  const TransactionDialog({Key? key,required this.itemToAdd}) : super(key: key);

  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {

  final TextEditingController itemTitleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  bool _isExpenseController = true;

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width/1.3,
        height: 330,
        child: Padding(
          padding: const EdgeInsets.all(15),

          child: Column(
            children: [

              const Text(
                "Add an expense",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: itemTitleController,

                decoration:  const InputDecoration(
                    hintText: "Name of expense"),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(hintText: "Amount in \$"),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("isExpense?"),
                  const SizedBox(
                    width: 100,
                  ),
                  Switch.adaptive(
                      value: _isExpenseController,
                      onChanged: (b) {
                        setState(() {
                          _isExpenseController=b;
                        });
                      }
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: (){
                  if(amountController.text.isNotEmpty && itemTitleController.text.isNotEmpty)
                  {
                    widget.itemToAdd(
                      TransactionEntry(
                          transactionName: itemTitleController.text,
                          amount: double.parse(amountController.text),
                          isExpense:_isExpenseController),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
