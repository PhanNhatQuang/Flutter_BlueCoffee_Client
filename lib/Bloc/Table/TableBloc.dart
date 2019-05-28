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
      if( m_Table?.orders == null)
      {
        currentState.m_Table.orders = new List<OrderModel>();
      }
      if(m_Table?.orders?.length == 0 )
      {
        currentState.m_Table.orders.add(new OrderModel(drink: event.m_Drink,amount: 1));
      }
      else
      {
        var _order = currentState.m_Table.orders.firstWhere((order) => order.drink.drinkID == event.m_Drink.drinkID,orElse: () => null);
        if(_order != null)
        {
          currentState.m_Table.orders.elementAt(currentState.m_Table.orders.indexOf(_order)).amount++;        
        }
        else
        {
          currentState.m_Table.orders.add(new OrderModel(drink:event.m_Drink,amount: 1));
        }
      }
      currentState.m_Table.totalMoney+=event.m_Drink.drinkPrice;
      currentState.m_Table.drinkCount++;
    } else if (event is RemoveOrders) {
      if (currentState.m_Table.orders != null) {
        var _order = currentState.m_Table.orders.firstWhere((order) => order.drink.drinkID == event.m_Drink.drinkID);
        if(_order != null)
        {
          if(_order.amount > 1)
            currentState.m_Table.orders.elementAt(currentState.m_Table.orders.indexOf(_order)).amount--;
          else
            currentState.m_Table.orders.removeAt(currentState.m_Table.orders.indexOf(_order));
          currentState.m_Table.totalMoney-=_order.drink.drinkPrice;
          currentState.m_Table.drinkCount--;
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
