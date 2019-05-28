import 'OrderModel.dart';

class TableModel{
  int tableID;
  List<OrderModel> orders;
  DateTime startDate;
  bool isPaid;
  bool isDone;
  DateTime endDate;
  int totalMoney;
  int drinkCount;
  
  TableModel(
  {
    this.tableID,
    this.orders,
    this.isPaid = false,
    this.isDone = false,
    this.totalMoney = 0,
    this.drinkCount = 0,
  });

  factory TableModel.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['orders'] as List;
    print(list.runtimeType); //returns List<dynamic>
    List<OrderModel> orderList = list.map((i) => OrderModel.fromJson(i)).toList();
    return TableModel(
    tableID:parsedJson['tableID'],
    orders:orderList,
    isPaid:parsedJson['isPaid'],
    isDone:parsedJson['isDone'],
    totalMoney:parsedJson['totalMoney'],
    drinkCount:parsedJson['drinkCount'],
  );}

Map<String, dynamic> toJson() =>
    {
      'tableID': tableID,
      'orders': orders.map((i) => i.toJson()),
      'isPaid': isPaid,
      'isDone': isDone,
      'totalMoney': totalMoney,
      'drinkCount': drinkCount,
    };
}

