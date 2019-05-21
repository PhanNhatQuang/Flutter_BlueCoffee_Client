import 'package:bluecoffee_client/Model/DrinkModel.dart';
import 'package:bluecoffee_client/Model/OrderModel.dart';
import 'package:bluecoffee_client/Model/TableModel.dart';
import 'package:flutter/material.dart';


@immutable
abstract class MenuEvent {}

class IncrementDrinkEvent extends MenuEvent {
  final DrinkModel m_Drink;
  IncrementDrinkEvent(this.m_Drink);
}

class DecrementDrinkEvent extends MenuEvent {
  final DrinkModel m_Drink;
  DecrementDrinkEvent(this.m_Drink);
}

class SetOrdersEvent extends MenuEvent {
  List<OrderModel> m_Orders;
  SetOrdersEvent(this.m_Orders);
}
