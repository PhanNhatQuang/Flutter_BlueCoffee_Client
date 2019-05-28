class DrinkModel{
  int drinkID;
  String drinkName;
  int drinkPrice;
  String drinkImage;
  DrinkModel(
  {
    this.drinkID,
    this.drinkName,
    this.drinkPrice,
    this.drinkImage,
  });

  factory DrinkModel.fromJson(Map<String, dynamic> parsedJson){
  return DrinkModel(
   drinkID:parsedJson['drinkID'],
   drinkName:parsedJson['drinkName'],
   drinkImage:parsedJson['drinkImage'],
   drinkPrice:parsedJson['drinkPrice'],
  );}

  Map<String, dynamic> toJson() =>
    {
      'drinkID': drinkID,
      'drinkName': drinkName,
      'drinkPrice': drinkPrice,
      'drinkImage': drinkImage,
    };
}