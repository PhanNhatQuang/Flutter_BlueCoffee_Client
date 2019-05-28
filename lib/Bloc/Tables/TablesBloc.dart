import 'package:bluecoffee_client/Model/TableModel.dart';

import 'TablesEvent.dart';
import 'TablesState.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

class TablesBloc extends Bloc<TablesEvent, TablesState> {
  List<TableModel> tables;
  @override
  TablesState get initialState => TablesState(this.tables);
  TablesBloc(this.tables);
  @override
  Stream<TablesState> mapEventToState(
      TablesState currentState, TablesEvent event) async* {
    TablesState _newState;
    if (event is AddTableEvent) {
      currentState.tables.add(event.table);
    } else if (event is RemoveTableEvent) {
      if(currentState.tables.contains(event.table))
      {
        currentState.tables.removeWhere((e) => e.tableID == event.table.tableID);
      }
    } else if (event is UpdateTableEvent) {
      int _tableindex = currentState.tables.indexWhere((e)=>e.tableID == event.table.tableID); 
      currentState.tables[_tableindex] = event.table;
    }

    _newState = new TablesState(currentState.tables);
    yield _newState;
  }

  List<TableModel> get getTables => this.tables;

  void AddTable(TableModel _iTable) =>
      this.dispatch(AddTableEvent(_iTable));
  void RemoveTable(TableModel _iTable) =>
      this.dispatch(RemoveTableEvent(_iTable));
  void UpdateTable(TableModel _iTable) =>
      this.dispatch(UpdateTableEvent(_iTable));
}
