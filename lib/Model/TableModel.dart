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
  bool isNew;
  TableModel(int id)
  {
    this.tableID = id;
    orders = List<OrderModel>();
    isPaid = false;
    isDone = false;
    totalMoney = 0;
    drinkCount = 0;
    isNew = true;
  }
}