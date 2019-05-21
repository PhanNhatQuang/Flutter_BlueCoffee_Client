import 'package:bluecoffee_client/Model/DrinkModel.dart';
import 'package:bluecoffee_client/Model/OrderModel.dart';
import 'package:bluecoffee_client/Model/TableModel.dart';
import 'package:flutter/material.dart';


@immutable
abstract class TableEvent {}

class AddOrders extends TableEvent{
  final DrinkModel m_Drink;
  AddOrders(this.m_Drink);
}
class RemoveOrders extends TableEvent{
  final DrinkModel m_Drink;
  RemoveOrders(this.m_Drink);
}

class Paid extends TableEvent{
  final bool m_IsPaid;
  Paid(this.m_IsPaid);
}

class Done extends TableEvent{
  final bool m_IsDone;
  Done(this.m_IsDone);
}

class SetOrdersEvent extends TableEvent {
  final List<OrderModel> m_Orders;
  SetOrdersEvent(this.m_Orders);
}

class SetTableEvent extends TableEvent {
  final TableModel m_Table;
  SetTableEvent(this.m_Table);
}
