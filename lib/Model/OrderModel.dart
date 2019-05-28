import 'DrinkModel.dart';

class OrderModel{
  DrinkModel drink;
  int amount;
  OrderModel(
  {
    this.drink,
    this.amount,
  });

  factory OrderModel.fromJson(Map<String, dynamic> parsedJson){
    return OrderModel(
    drink:DrinkModel.fromJson(parsedJson['drink']),
    amount:parsedJson['amount'],
  );}

  Map<String, dynamic> toJson() =>
    {
      'drink': drink.toJson(),
      'amount': amount,
    };
}