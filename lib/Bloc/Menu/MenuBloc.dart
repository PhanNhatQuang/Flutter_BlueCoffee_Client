import 'package:bluecoffee_client/Bloc/Table/TableBloc.dart';
import 'package:bluecoffee_client/Model/DrinkModel.dart';
import 'package:bluecoffee_client/Model/OrderModel.dart';
import 'package:bluecoffee_client/Model/TableModel.dart';

import 'MenuEvent.dart';
import 'MenuState.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  TableBloc m_TableBloc;
  @override
  MenuState get initialState => MenuState(this.m_TableBloc);
  MenuBloc(this.m_TableBloc);
  @override
  Stream<MenuState> mapEventToState(
    MenuState currentState, MenuEvent event) async* {
    MenuState _newState;
    if (event is IncrementDrinkEvent) {
      m_TableBloc.addOrder(event.m_Drink);
      print(event.m_Drink.toJson());
     
    } else if (event is DecrementDrinkEvent) {
      m_TableBloc.removeOrder(event.m_Drink);
    } else if (event is SetOrdersEvent) {
      m_TableBloc.setOrders(event.m_Orders);
    }

    _newState = new MenuState(currentState.m_TableBloc);
    yield _newState;
  }

  List<OrderModel>  get getOrders => this.m_TableBloc.getTable.orders;

  TableBloc  get getTableBloc => this.m_TableBloc;
  TableModel  get getTable => this.m_TableBloc.getTable;

  void incrementDrink(DrinkModel _iDrink) =>
      this.dispatch(IncrementDrinkEvent(_iDrink));
  void decrementDrink(DrinkModel _iDrink) =>
      this.dispatch(DecrementDrinkEvent(_iDrink));
  void setOrders(List<OrderModel> _iOrders) =>
      this.dispatch(SetOrdersEvent(_iOrders));
}
