import 'package:bluecoffee_client/Bloc/Menu/MenuBloc.dart';
import 'package:bluecoffee_client/Bloc/Table/TableBloc.dart';
import 'package:bluecoffee_client/Bloc/Tables/TablesBloc.dart';
import 'package:bluecoffee_client/Bloc/Tables/TablesState.dart';
import 'package:bluecoffee_client/Model/TableModel.dart';
import 'package:bluecoffee_client/ServerListener/ServerListener.dart';
import 'package:bluecoffee_client/Views/MenuView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:bluecoffee_client/Theme.dart' as Theme;

import '../GradientAppBar.dart';
import 'MenuView_NewUI.dart';
import 'TableDetailView.dart';

class TablesView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TablesViewState();
  }
}

class TablesViewState extends State<TablesView> implements StateListener {
  Widget _createListItem(BuildContext context, int index, TableModel table) {
    final int _tableNumber = table.tableID;
    int _drinkCount = 0;
    int _totalMonney = 0;
    table.orders.forEach((order) {
      _totalMonney += order.drink.drinkPrice * order.amount;
      _drinkCount += order.amount;
    });

    final tableIcon = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      child: new Hero(
        tag: 'table-item-$index',
        child: new CircleAvatar(
          child: new Text(
            '$_tableNumber',
            style: new TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          ),
          maxRadius: 45.0,
          backgroundColor: Colors.white,
        ),
      ),
    );

    final tableCard = new Container(
      margin: const EdgeInsets.only(left: 45.0, right: 24.0),
      decoration: new BoxDecoration(
        color: Theme.Colors.tableCard,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black,
              blurRadius: 5.0,
              offset: new Offset(0.0, 5.0))
        ],
      ),
      child: new Container(
          margin: const EdgeInsets.only(top: 16.0, left: 72.0),
          constraints: new BoxConstraints.expand(),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('Bàn số: $_tableNumber',
                        style: Theme.TextStyles.tableTitle),
                    new Text(
                        DateFormat('kk:mm  dd-MM-yyyy').format(table.startDate),
                        style: Theme.TextStyles.planetLocation),
                    new Container(
                        color: Colors.white,
                        width: 120.0,
                        height: 1.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0)),
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.local_bar,
                            size: 16.0, color: Colors.white),
                        new Text(' $_drinkCount',
                            style: Theme.TextStyles.tableDistance),
                        new Container(width: 24.0),
                        new Icon(Icons.attach_money,
                            size: 16.0, color: Colors.white),
                        new Text(
                            ' ${NumberFormat("#,###.##").format(_totalMonney)}',
                            style: Theme.TextStyles.tableDistance),
                      ],
                    )
                  ],
                ),
              ),
              new Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: new IconButton(
                    icon: table.isDone? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
                    onPressed: () {
                      table.isDone = !table.isDone;
                      BlocProvider.of<TablesBloc>(context).UpdateTable(table);
                    },
                    iconSize: 25.0,
                    color: Colors.white,
                  )),
            ],
          )),
    );

    return new Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new FlatButton(
        onPressed: () {
          Navigator.of(context)
              .push<TableModel>(new MaterialPageRoute(builder: (context) {
            return new TableDetailView(new TableBloc(table));
          }))
                ..then<TableModel>((onValue) {
                  if (onValue != null && onValue.isPaid) {
                    BlocProvider.of<TablesBloc>(context).RemoveTable(onValue);
                  }
                });
        },
        child: new Stack(
          children: <Widget>[
            tableCard,
            tableIcon,
          ],
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<TablesBloc>(context);
    return new BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, TablesState tablesState) {
          return new Scaffold(
            key: _scaffoldKey,
            floatingActionButton: new IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push<TableModel>(new MaterialPageRoute(builder: (context) {
                  var _table = new TableModel(tableID:Random().nextInt(99));
                  var _tableBloc = new TableBloc(_table);
                  //return new MenuView(new MenuBloc(_tableBloc));
                  return new MenuView_NewUI(new MenuBloc(_tableBloc));
                }))
                      ..then<TableModel>((onValue) {
                        if (onValue?.orders != null) {
                          int _drinkCount = 0;
                          onValue.orders.forEach((order) {
                            _drinkCount += order.amount;
                          });
                          if (_drinkCount > 0) {
                            _bloc.AddTable(onValue);
                          }
                        }
                      });
              },
              icon: new Icon(Icons.add_circle),
              iconSize: 70.0,
              color: Theme.Colors.white,
            ),
            body: new Column(
              children: <Widget>[
                new GradientAppBar("Blue Coffee"),
                new Flexible(
                  child: new ListView.builder(
                    itemExtent: 150.0,
                    itemCount: tablesState.tables.length,
                    itemBuilder: (context, int index) {
                      return _createListItem(
                          context, index, tablesState.tables[index]);
                    },
                  ),
                ),
              ],
            ),
            backgroundColor: Theme.Colors.planetPageBackground,
          );
        });
  }

  @override
  initState(){  
    super.initState();   
    var stateProvider = new StateProvider();
    stateProvider.subscribe(this);
  }
  
  @override
  void onStateChanged(ServerState state) {
    // TODO: implement onStateChanged
  }
}
