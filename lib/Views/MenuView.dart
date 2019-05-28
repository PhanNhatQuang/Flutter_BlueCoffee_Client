import 'dart:math';

import 'package:bluecoffee_client/Bloc/Menu/MenuBloc.dart';
import 'package:bluecoffee_client/Bloc/Menu/MenuState.dart';
import 'package:bluecoffee_client/Bloc/Table/TableBloc.dart';
import 'package:bluecoffee_client/GradientAppBar.dart';
import 'package:bluecoffee_client/Model/DrinkModel.dart';
import 'package:bluecoffee_client/Model/OrderModel.dart';
import 'package:bluecoffee_client/ServerListener/ServerListener.dart';
import 'package:bluecoffee_client/Theme.dart' as Theme;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_words/english_words.dart';

class MenuView extends StatefulWidget {
  MenuBloc menuBloc;
  MenuView(this.menuBloc);
  @override
  State<StatefulWidget> createState() {
    return new MenuViewState(menuBloc);
  }
}

class MenuViewState extends State<MenuView> implements StateListener {
  List<DrinkModel> _menu;
  MenuViewState(this.menuBloc);
  MenuBloc menuBloc;

  @override
  void dispose() {
    this.menuBloc.dispose();
    super.dispose();
  }

  ///////////////////////////////////////////////////
  Widget _createMenuItem1(BuildContext context, int index, OrderModel _iOrder) {
    print(_iOrder.toJson());
    final drinkImage = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      child: new Hero(
        tag: 'menu-item-$index',
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
          margin: const EdgeInsets.only(top: 10.0, left: 40.0),
          constraints: new BoxConstraints.expand(),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new FlatButton(
                    onPressed: () {
                      menuBloc.incrementDrink(_iOrder.drink);
                    },
                    child: new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text('${_iOrder.drink.drinkName}',
                              style: Theme.TextStyles.tableDetailDrinkTitle),
                          new Container(
                              color: Colors.white,
                              width: 150.0,
                              height: 1.0,
                              margin:
                                  const EdgeInsets.symmetric(vertical: 8.0)),
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
                    )),
              ),
              new Container(
                  margin: EdgeInsets.only(right: 5.0, left: 30.0),
                  padding: EdgeInsets.only(top: 0.0, bottom: 6.0),
                  child: new IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      menuBloc.decrementDrink(_iOrder.drink);
                    },
                    iconSize: 25.0,
                    color: Colors.white,
                  )),
            ],
          ),
        ));

    return new Container(
      height: 100.0,
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


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    /////////////////////////////////
    

    ////////////////////////////////mock data
    final double bottomNavigationBarHeight =
        MediaQuery.of(context).padding.bottom;
    final double barHeight = 60.0;

    return new BlocBuilder(
        bloc: menuBloc,
        builder: (BuildContext context, MenuState menuState) {
          return new Scaffold(
            key: _scaffoldKey,
            //appBar: new AppBar(title: new Text('Menu')),
            backgroundColor: Theme.Colors.planetPageBackground,
            body: new Column(
              children: <Widget>[
                new GradientAppBar("menu"),
                new Flexible(
                  child: new ListView.builder(
                    itemExtent: 100.0,
                    itemCount: _menu.length,
                    itemBuilder: (context, int index) {
                      int drinkCount = 0;
                      if (menuState.m_TableBloc.getTable?.orders !=
                          null) {
                        menuState.m_TableBloc
                            .getTable
                            .orders
                            .forEach((order) {
                          if (_menu[index].drinkID == order.drink.drinkID) {
                            drinkCount = order.amount;
                          }
                        });
                      }
                      return _createMenuItem1(context, index,
                          new OrderModel(drink:_menu[index],amount: drinkCount));
                    },
                  ),
                ),
              ],
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
                          new Text(
                            '  ',
                            style: Theme.TextStyles.appBarTitle,
                          ),
                        ],
                      ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: new FlatButton(
                          onPressed: () {
                            menuState.m_TableBloc.getTable.startDate = new DateTime.now();
                            Navigator.of(context).pop(menuState.m_TableBloc.getTable);
                          },
                          child: new Row(
                            children: <Widget>[
                              new Text(
                                'XONG',
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
                      Theme.Colors.bottomappBarGradientEnd
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
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
