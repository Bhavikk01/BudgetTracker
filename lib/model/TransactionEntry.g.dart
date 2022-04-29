// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TransactionEntry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionEntryAdapter extends TypeAdapter<TransactionEntry> {
  @override
  final int typeId = 1;

  @override
  TransactionEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionEntry(
      transactionName: fields[0] as String,
      amount: fields[1] as double,
      isExpense: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.transactionName)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.isExpense);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
