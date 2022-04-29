import 'package:budget_tracker/model/TransactionEntry.dart';
import 'package:budget_tracker/services/LocalStorage.dart';
import 'package:flutter/cupertino.dart';

class BudgetViewModel extends ChangeNotifier{
  double _budget = 2000;
  double _balance=0;
  List<TransactionEntry> _items=[];

  double getBudget() => LocalStorageService().getBudget();
  double getBalance() => LocalStorageService().getBalance();
  List<TransactionEntry> get items => LocalStorageService().getAllTransactionEntry();

  void addData(TransactionEntry item){
    LocalStorageService().saveTransactionData(item);
    notifyListeners();
  }

  void deleteItem(TransactionEntry item) {
    final localStorage = LocalStorageService();
    localStorage.deleteTransactionEntry(item);
    notifyListeners();
  }

  set budget(double value) {
    LocalStorageService().saveBudget(value);
    notifyListeners();
  }
}