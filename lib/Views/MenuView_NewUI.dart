import 'package:bluecoffee_client/Bloc/Menu/MenuBloc.dart';
import 'package:bluecoffee_client/Bloc/Menu/MenuState.dart';
import 'package:bluecoffee_client/Bloc/Table/TableBloc.dart';
import 'package:bluecoffee_client/Model/DrinkModel.dart';
import 'package:bluecoffee_client/Model/TableModel.dart';
import 'package:bluecoffee_client/Views/TableDetailView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bluecoffee_client/Theme.dart' as theme;

class MenuView_NewUI extends StatefulWidget {
  MenuBloc menuBloc;
  MenuView_NewUI(this.menuBloc);
  @override
  State<StatefulWidget> createState() {
    return new MenuViewNewUIState(menuBloc);
  }
}

class MenuViewNewUIState extends State<MenuView_NewUI> {
  MenuViewNewUIState(this.menuBloc);
  MenuBloc menuBloc;

  @override
  void dispose() {
    this.menuBloc.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.width / 2 + 50.0;
    final double itemWidth = size.width / 2;
    /////////////////////////////////////////
    final double bottomNavigationBarHeight =
        MediaQuery.of(context).padding.bottom;
    final double barHeight = 60.0;
    ///////////////////////////////////
    
    //////////////////////////////////////////
    return new BlocBuilder(
        bloc: menuBloc,
        builder: (BuildContext context, MenuState menuState) {
          /////////////////////////////////////////////////////
        String _bottomBarActionString;
        menuState.m_TableBloc.getTable.isNew ? _bottomBarActionString = 'Chi tiết' : _bottomBarActionString = 'Xong';
        ////////////////////////////////////////////////
          return new Scaffold(
            key: _scaffoldKey,
            appBar: new AppBar(
              title: new Text('Menu'),
              actions: <Widget>[
                IconButton(
                  tooltip: 'Search',
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    final int selected = await showSearch<int>(
                      context: context,
                      //delegate: _delegate,
                    );
                  },
                ),
              ],
            ),
            backgroundColor: Color(0xFF4C98CF),
            body: new Column(
              children: <Widget>[
                Container(
                  // height: 500.0,
                  child: Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (itemWidth / itemHeight),
                      controller: new ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(4.0),
                      children: menuState.m_Menu.map((DrinkModel drinkmodel) {
                        return CreateTravelDestinationItem(drinkmodel);
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: menuState.m_TableBloc.getTable.orders.length !=
                    0
                ? new Container(
                    padding:
                        new EdgeInsets.only(top: bottomNavigationBarHeight),
                    height: bottomNavigationBarHeight + barHeight,
                    child: new Container(
                      padding: EdgeInsets.only(left: 15.0),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            width: 50.0,
                                child: Stack(
                                  children: <Widget>[
                                    new Icon(
                                          Icons.local_bar,
                                          color: Colors.white,
                                          size: 35.0,
                                        ),
                                    new Positioned(
                                      left: 20.0,
                                      bottom: 17.0,
                                        child: new Stack(
                                      children: <Widget>[
                                        new Icon(Icons.brightness_1,
                                            size: 20.0,
                                            color: Colors.orange.shade500),
                                        new Positioned(
                                            top: 4.0,
                                            right: 5.0,
                                            child: new Center(
                                              child: new Text(
                                                menuState.m_TableBloc.getTable
                                                    .drinkCount
                                                    .toString(),
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )),
                                      ],
                                    )),
                                  ],
                                ),
                            ),
                          // new Expanded(
                          //   child: new Row(
                          //     children: <Widget>[
                          //       new Icon(Icons.local_bar,
                          //           size: 30.0, color: Colors.white),
                          //       new Text(
                          //         '${menuState.m_TableBloc.getTable.drinkCount}',
                          //         style: theme.TextStyles.appBarTitle,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          new Expanded(
                            child: new Row(
                              children: <Widget>[
                                new Icon(Icons.attach_money, size: 30.0, color: Colors.white),
                                new Text('${NumberFormat("#,###.##").format(menuState.m_TableBloc.getTable.totalMoney)}',
                                    style: theme.TextStyles.tableDetailDistance),
                              ],
                            ),
                          ),
                          new Container(
                              margin: EdgeInsets.only(right: 10.0),
                              child: new FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push<TableModel>(
                                      new MaterialPageRoute(builder: (context) {
                                    menuState.m_TableBloc.getTable.startDate =
                                        new DateTime.now();
                                    return new TableDetailView(
                                        menuState.m_TableBloc);
                                  }))
                                    ..then<TableModel>((onValue) {
                                      Navigator.of(context)
                                          .pop(menuState.m_TableBloc.getTable);
                                    });
                                },
                                child: new Row(
                                  children: <Widget>[
                                    new Text(
                                      '${_bottomBarActionString}',
                                      style: theme.TextStyles.appBarTitle,
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
                            theme.Colors.bottmappBarGradientStart,
                            theme.Colors.bottomappBarGradientEnd,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.8, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                  )
                : new Container(height: 0.0),
          );
        });
  }

  Widget CreateTravelDestinationItem(DrinkModel _iDrink) {
    ShapeBorder shape;
    final ThemeData theme = Theme.of(context);

    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return SafeArea(
        top: false,
        bottom: false,
        child: Container(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                //Navigator.push(context,
                //MaterialPageRoute(builder: (context) => Item_Details()));
              },
              child: Card(
                shape: shape,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // photo and title
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 2 - 40.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              _iDrink.drinkImage,
                              // package: _iDrink.assetPackage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // description and share/explore buttons
                    //Divider(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                      child: Column(
                        children: <Widget>[
                          //Name
                          Row(
                            children: <Widget>[
                              Text(
                                _iDrink.drinkName,
                                style: new TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                          // Price
                          Row(
                            children: <Widget>[
                              new Icon(Icons.attach_money,
                                  size: 18.0, color: Colors.green),
                              new Expanded(
                                child: new Text(
                                  ' ${NumberFormat("#,###.##").format(_iDrink.drinkPrice)}',
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ),
                              new Container(
                                  child: new IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: () {
                                  menuBloc.incrementDrink(_iDrink);
                                },
                                iconSize: 28.0,
                                color: Colors.blue,
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // share, explore buttons
                  ],
                ),
              ),
            )));
  }
}
