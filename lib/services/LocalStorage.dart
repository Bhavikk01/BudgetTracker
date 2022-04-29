import 'package:budget_tracker/model/TransactionEntry.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String transactionsBoxKey = "transactionsBox";
  static const String balanceBoxKey = "balanceBox";
  static const String budgetBoxKey = "budgetBoxKey";

  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }
   LocalStorageService._internal() {
     initializeHive();
   }

  Future<void> initializeHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TransactionEntryAdapter());
    }

    await Hive.openBox<double>(budgetBoxKey);
    await Hive.openBox<TransactionEntry>(transactionsBoxKey);
    await Hive.openBox<double>(balanceBoxKey);
  }

  void saveTransactionData(TransactionEntry transaction) {
    Hive.box<TransactionEntry>(transactionsBoxKey).add(transaction);
    saveBalance(transaction);
  }

  List<TransactionEntry> getAllTransactionEntry() {
    return Hive.box<TransactionEntry>(transactionsBoxKey).values.toList();
  }

  void deleteTransactionEntry(TransactionEntry transaction) {
    final transactions = Hive.box<TransactionEntry>(transactionsBoxKey);
    final Map<dynamic, TransactionEntry> map = transactions.toMap();
    dynamic desiredKey;
    map.forEach((key, value) {
      if (value.transactionName == transaction.transactionName) desiredKey = key;
    });
    transactions.delete(desiredKey);
    saveBalanceOnDelete(transaction);
  }

  double getBudget() {
    return Hive.box<double>(budgetBoxKey).get("budget") ?? 2000.0;
  }

  Future<void> saveBudget(double budget) {
    return Hive.box<double>(budgetBoxKey).put("budget", budget);
  }

  double getBalance() {
    return Hive.box<double>(balanceBoxKey).get("balance") ?? 0.0;
  }

  Future<void> saveBalance(TransactionEntry item) async {
    final balanceBox = Hive.box<double>(balanceBoxKey);
    final currentBalance = balanceBox.get("balance") ?? 0.0;
    if (item.isExpense) {
      balanceBox.put("balance", currentBalance + item.amount);
    } else {
      balanceBox.put("balance", currentBalance - item.amount);
    }
  }

  void saveBalanceOnDelete(TransactionEntry transaction) {
    final balanceBox = Hive.box<double>(balanceBoxKey);
    final currentBalance = balanceBox.get("balance")??0.0;
    if (transaction.isExpense)
    {
      balanceBox.put("balance", currentBalance - transaction.amount);
    }
    else
    {
      balanceBox.put("balance", currentBalance + transaction.amount);
    }
  }
}

