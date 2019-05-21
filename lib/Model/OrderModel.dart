import 'DrinkModel.dart';

class OrderModel{
  DrinkModel drink;
  int amount;
  OrderModel(DrinkModel _iDrink, int _iAmount)
  {
    this.drink = _iDrink;
    this.amount = _iAmount;
  }
}