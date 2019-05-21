import 'DrinkModel.dart';
import 'OrderModel.dart';

class TableModel{
  int tableID;
  List<OrderModel> orders;
  DateTime startDate;
  bool isPaid;
  bool isDone;
  DateTime endDate;
  int totalMoney;
  TableModel(int id)
  {
    this.tableID = id;
    orders = List<OrderModel>();
    isPaid = false;
    isDone = false;
    totalMoney = 0;
  }
}