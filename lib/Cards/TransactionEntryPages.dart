import 'package:budget_tracker/model/TransactionEntry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/BudgetViewModel.dart';

class TransactionDetails extends StatelessWidget {

  TransactionEntry entry;

  TransactionDetails({required this.entry,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (()=> showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Padding(
                  padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    const Text("Delete item"),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          final budgetViewModel = Provider.of<BudgetViewModel>(
                              context,
                              listen: false);
                          budgetViewModel.deleteItem(entry);
                          Navigator.pop(context);
                        },
                        child: const Text("Yes")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"))
                  ],
                ),
              ),
            );
          }
        )
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 5,left: 5,top: 8,bottom: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15),
          boxShadow:  [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, 25),
              blurRadius: 50,
            )
          ]
        ),

        child: Row(
          children: [
            Text(
              entry.transactionName,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Text((entry.isExpense? "+":"-")+ entry.amount.toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
            )
          ]
        ),
      ),
    );
  }
}
