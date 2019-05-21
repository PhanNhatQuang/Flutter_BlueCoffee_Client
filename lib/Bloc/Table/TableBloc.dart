import 'package:bluecoffee_client/Model/DrinkModel.dart';
import 'package:bluecoffee_client/Model/OrderModel.dart';
import 'package:bluecoffee_client/Model/TableModel.dart';

import 'TableEvent.dart';
import 'TableState.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

class TableBloc extends Bloc<TableEvent, TableState> {
  TableModel m_Table;
  @override
  TableState get initialState => TableState(this.m_Table);
  TableBloc(this.m_Table);
  @override
  Stream<TableState> mapEventToState(
      TableState currentState, TableEvent event) async* {
    TableState _newState;
    if (event is AddOrders) {
      if(m_Table.orders.length > 0)
      {
        var _order = m_Table.orders.firstWhere((order) => order.drink.drinkID == event.m_Drink.drinkID,orElse: () => null);
        if(_order != null)
        {
          m_Table.orders.elementAt(m_Table.orders.indexOf(_order)).amount++;        
        }
        else
        {
          m_Table.orders.add(new OrderModel(event.m_Drink, 1));
        }
      }
      else
      {
        m_Table.orders.add(new OrderModel(event.m_Drink, 1));
      }
      m_Table.totalMoney+=event.m_Drink.drinkPrice;
    } else if (event is RemoveOrders) {
      if (m_Table.orders != null) {
        var _order = m_Table.orders.firstWhere((order) => order.drink.drinkID == event.m_Drink.drinkID);
        if(_order != null)
        {
          if(_order.amount > 1)
            m_Table.orders.elementAt(m_Table.orders.indexOf(_order)).amount--;
          else
            m_Table.orders.removeAt(m_Table.orders.indexOf(_order));
          m_Table.totalMoney-=_order.drink.drinkPrice;
        }
      }
    } else if (event is Paid) {
      currentState.m_Table.isPaid = event.m_IsPaid;
    } else if (event is Done) {
      currentState.m_Table.isDone = event.m_IsDone;
    } else if (event is SetTableEvent) {
      currentState.m_Table = event.m_Table;
    } else if (event is SetOrdersEvent) {
      currentState.m_Table.orders = event.m_Orders;
    }

    _newState = new TableState(currentState.m_Table);
    yield _newState;
  }

  TableModel get getTable => this.m_Table;

  void addOrder(DrinkModel _iDrink) =>
      this.dispatch(AddOrders(_iDrink));
  void removeOrder(DrinkModel _iDrink) =>
      this.dispatch(RemoveOrders(_iDrink));
  void setTable(TableModel _iTable) =>
      this.dispatch(SetTableEvent(_iTable));
  void setOrders(List<OrderModel> _iOrders) =>
      this.dispatch(SetOrdersEvent(_iOrders));
  void setDone(bool _iIsDone) =>
      this.dispatch(Done(_iIsDone));
  void setPaid(bool _iIsPaid) =>
      this.dispatch(Done(_iIsPaid));
}
