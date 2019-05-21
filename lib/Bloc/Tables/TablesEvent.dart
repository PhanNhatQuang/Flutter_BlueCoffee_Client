import 'package:bluecoffee_client/Model/DrinkModel.dart';
import 'package:bluecoffee_client/Model/TableModel.dart';
import 'package:flutter/material.dart';


@immutable
abstract class TablesEvent {}

class AddTableEvent extends TablesEvent {
  final TableModel table;
  AddTableEvent(this.table);
}

class RemoveTableEvent extends TablesEvent {
  final TableModel table;
  RemoveTableEvent(this.table);
}

class UpdateTableEvent extends TablesEvent {
  final TableModel table;
  UpdateTableEvent(this.table);
}
