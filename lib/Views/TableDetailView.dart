import 'package:bluecoffee_client/Bloc/Menu/MenuBloc.dart';
import 'package:bluecoffee_client/Bloc/Table/TableState.dart';
import 'package:bluecoffee_client/Model/OrderModel.dart';
import 'package:bluecoffee_client/Model/TableModel.dart';
import 'package:bluecoffee_client/ServerListener/ServerListener.dart';
import 'package:bluecoffee_client/Theme.dart' as Theme;
import 'package:bluecoffee_client/Bloc/Table/TableBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'MenuView_NewUI.dart';

class TableDetailView extends StatefulWidget {
  TableBloc m_TableBloc;
  TableDetailView(this.m_TableBloc);
  @override
  State<StatefulWidget> createState() {
    return new TableDetailViewState(this.m_TableBloc);
  }
}

class TableDetailViewState extends State<TableDetailView> implements StateListener {
  TableBloc m_TableBloc;
  TableDetailViewState(this.m_TableBloc);

  @override
  void dispose() {
    this.m_TableBloc.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final double bottomNavigationBarHeight =
        MediaQuery.of(context).padding.bottom;
    final double barHeight = 60.0;

    return new BlocBuilder(
      bloc: m_TableBloc,
      builder: (BuildContext context, TableState tableState) {
        int _drinkCount = 0, _totalMonney = 0;
        String _bottomBarAction = 'Tính tiền';

        tableState.m_Table.orders.forEach((order) {
          _drinkCount += order.amount;
          _totalMonney += order.drink.drinkPrice * order.amount;
        });
        return new Scaffold(
            key: _scaffoldKey,
            floatingActionButton: new IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push<TableModel>(new MaterialPageRoute(builder: (context) {
                  return new MenuView_NewUI(new MenuBloc(new TableBloc(tableState.m_Table)));
                })).then<TableModel>((onValue) {
                  if (onValue?.orders != null) {
                    this.m_TableBloc.setTable(onValue);
                    Navigator.of(context).pop(tableState.m_Table);
                  }                  
                });
              },
              icon: new Icon(Icons.add_circle),
              iconSize: 70.0,
              color: Colors.white,
            ),
            bottomNavigationBar: new Container(
              padding: new EdgeInsets.only(top: bottomNavigationBarHeight),
              height: bottomNavigationBarHeight + barHeight,
              child: new Container(
                padding: EdgeInsets.only(left: 20.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Row(
                        children: <Widget>[
                          new Icon(Icons.attach_money,
                              size: 30.0, color: Colors.white),
                          new Text(
                            '${NumberFormat("#,###.##").format(_totalMonney)}',
                            style: Theme.TextStyles.appBarTitle,
                          ),
                        ],
                      ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: new FlatButton(
                          onPressed: () {
                            tableState.m_Table.isPaid = true;
                            print(tableState.m_Table.toJson());
                            Navigator.of(context).pop(tableState.m_Table);
                          },
                          child: new Row(
                            children: <Widget>[
                              new Text(
                                '${_bottomBarAction}',
                                style: Theme.TextStyles.appBarTitle,
                              ),
                              new Icon(Icons.arrow_forward_ios,
                                  size: 30.0, color: Colors.white),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.Colors.bottmappBarGradientStart,
                      Theme.Colors.bottomappBarGradientEnd,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.8, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            backgroundColor: Theme.Colors.planetPageBackground,
            body: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                this._tableCard(_drinkCount, _totalMonney, tableState),
                new Flexible(
                  child: new ListView.builder(
                    itemExtent: 100.0,
                    itemCount: tableState.m_Table.orders.length,
                    itemBuilder: (context, int index) {
                      return _createListItem(context, index,
                          tableState.m_Table.orders.elementAt(index));
                    },
                  ),
                ),
              ],
            ));
      },
    );
  }

///////////////////////////////////////////////////////////////////////////////////

  Widget _tableCard(int drinkCount, int totalMonney, TableState tableState) {
    final tableIcon = new Container(
      alignment: new FractionalOffset(0.5, 0.2),
      child: new Hero(
        tag: 'table-card-${this.m_TableBloc.getTable.tableID}',
        child: new CircleAvatar(
          child: new Text(
            '${this.m_TableBloc.getTable.tableID}',
            style: new TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
          ),
          maxRadius: 50.0,
          backgroundColor: Colors.white,
        ),
      ),
    );
    final tableCard = new Container(
      height: 200.0,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
      decoration: new BoxDecoration(
        color: Theme.Colors.tableCard,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0))
        ],
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 50.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(
                DateFormat('kk:mm  dd-MM-yyyy')
                    .format(tableState.m_Table.startDate),
                style: Theme.TextStyles.tableDetailDate),
            new Container(
                color: Colors.white,
                width: 300.0,
                height: 5.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.local_bar, size: 30.0, color: Colors.white),
                new Text(' $drinkCount',
                    style: Theme.TextStyles.tableDetailDistance),
                new Container(width: 50.0),
                new Icon(Icons.attach_money, size: 30.0, color: Colors.white),
                new Text('${NumberFormat("#,###.##").format(totalMonney)}',
                    style: Theme.TextStyles.tableDetailDistance),
              ],
            )
          ],
        ),
      ),
    );
    return new Container(
      height: 300.0,
      child: new Stack(
        alignment: new Alignment(1.0, 1.0),
        children: <Widget>[
          tableCard,
          tableIcon,
        ],
      ),
    );
  }

//////////////////////////////////////////////////////////////////////////////
  Widget _createListItem(BuildContext context, int index, OrderModel _iOrder) {
    //print(_iOrder.toJson());
    final drinkImage = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      child: new Hero(
        tag: 'order-item-$index',
        child: new CircleAvatar(
          child: new Text(
            'IMG',
            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          maxRadius: 30.0,
          backgroundColor: Colors.white,
        ),
      ),
    );
    final drinkCard = new Container(
        margin: const EdgeInsets.only(left: 35.0, right: 24.0),
        decoration: new BoxDecoration(
          color: Theme.Colors.appBarGradientEnd,
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
          margin: const EdgeInsets.only(top: 5.0, left: 40.0),
          constraints: new BoxConstraints.expand(),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('${_iOrder.drink.drinkName}',
                        style: Theme.TextStyles.tableDetailDrinkTitle),
                    new Container(
                        color: Colors.white,
                        width: 150.0,
                        height: 1.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0)),
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.local_bar,
                            size: 16.0, color: Colors.white),
                        new Text(' ${_iOrder.amount}',
                            style: Theme.TextStyles.tableDistance),
                        new Container(width: 20.0),
                        new Icon(Icons.attach_money,
                            size: 16.0, color: Colors.white),
                        new Text(
                            ' ${NumberFormat("#,###.##").format(_iOrder.drink.drinkPrice)}',
                            style: Theme.TextStyles.tableDistance),
                      ],
                    ),
                  ],
                ),
              ),
              new Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: new IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      this.m_TableBloc.removeOrder(_iOrder.drink);
                    },
                    iconSize: 25.0,
                    color: Colors.white,
                  )),
            ],
          ),
        ));

    return new Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0),
      child: new FlatButton(
        onPressed: () {},
        child: new Stack(
          children: <Widget>[
            drinkCard,
            drinkImage,
          ],
        ),
      ),
    );
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
