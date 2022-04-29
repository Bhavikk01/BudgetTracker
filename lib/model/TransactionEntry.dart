import 'package:hive/hive.dart';

part 'TransactionEntry.g.dart';

@HiveType(typeId: 1)
class TransactionEntry{
  @HiveField(0)
  final String transactionName;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final bool isExpense;

  TransactionEntry({required this.transactionName,required this.amount,this.isExpense = true});

}