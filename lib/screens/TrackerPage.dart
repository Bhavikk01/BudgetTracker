import 'package:budget_tracker/Cards/BalanceDialog.dart';
import 'package:budget_tracker/Cards/TransactionDialog.dart';
import 'package:budget_tracker/Cards/TransactionEntryPages.dart';
import 'package:budget_tracker/model/TransactionEntry.dart';
import 'package:budget_tracker/services/BudgetViewModel.dart';
import 'package:budget_tracker/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({Key? key}) : super(key: key);
  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {

  List<TransactionEntry> items = [];
  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeServices>(context);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        title: const Text("Budget Tracker"),
        actions: [
          IconButton(onPressed: () {
            showDialog(
                context: context,
                builder: (context){
                  return BalanceDialog(
                      balanceToAdd: (budget){
                        final budgetProvider = Provider.of<BudgetViewModel>(context,listen: false);
                        budgetProvider.budget=budget;
                      }
                  );
                });
          }, icon: const Icon(Icons.attach_money))
        ],
        leading: IconButton(
          icon: Icon(themeService.darkTheme? Icons.sunny: Icons.dark_mode),
          onPressed: () {
            themeService.darkTheme = !themeService.darkTheme;
          },

        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                  return TransactionDialog(
                      itemToAdd: (TransactionEntry){
                        final budgetProvider = Provider.of<BudgetViewModel>(context,listen:false);
                        budgetProvider.addData(TransactionEntry);
                      }
                  );
                },
            );
          },

      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(15),

          child: SizedBox(
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Consumer<BudgetViewModel>(builder: (context,value,child) {
                    return CircularPercentIndicator(
                      radius: screenSize.width / 2,
                      lineWidth: 10,
                      percent: value.getBalance()/value.getBudget(),
                      backgroundColor: Colors.white,
                      progressColor: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                      center: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("\$"+value.getBalance().toString().split(".")[0],
                            style: const TextStyle(
                              fontSize: 45,
                            ),
                          ),
                          const Text("Balance",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          Text(
                            "Budget: \$" + value.getBudget().toString(),
                            // <- here
                            style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  "Items",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<BudgetViewModel>(builder: (context,value,child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: value.items.length,
                      itemBuilder: (context, index) {
                        return TransactionDetails(entry: value.items[index]);
                      });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
