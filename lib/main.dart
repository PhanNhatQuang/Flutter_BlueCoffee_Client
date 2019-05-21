import 'package:bluecoffee_client/Bloc/Tables/TablesBloc.dart';
import 'package:flutter/material.dart';

import 'Model/TableModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Views/TablesView.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<TableModel> _tables = new List<TableModel>();
  final _bloc = TablesBloc(_tables);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TablesBloc>(
      bloc: _bloc,
      child: new TablesView(),
    );
    //return MyBlocProvider(child: new ListTable(), bloc: _bloc,);
  }

  @override
  void dispose() {
    this._bloc.dispose();
    super.dispose();
  }
}
