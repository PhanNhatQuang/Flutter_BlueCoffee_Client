import 'package:bluecoffee_client/Model/DrinkModel.dart';

class MenuModel{
  List<DrinkModel> m_ListDrink = new List<DrinkModel>();
  MenuModel({
    this.m_ListDrink,
  });

  factory MenuModel.fromJson(List<dynamic> parsedJson) {

    List<DrinkModel> drinks = new List<DrinkModel>();
    drinks = parsedJson.map((i)=>DrinkModel.fromJson(i)).toList();
    return new MenuModel(
       m_ListDrink: drinks,
    );
  }


  Map<String, dynamic> toJson() =>
    {
      'm_ListDrink': m_ListDrink.map((i)=>i.toJson()),
    };
}