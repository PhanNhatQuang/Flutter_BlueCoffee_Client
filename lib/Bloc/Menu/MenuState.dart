import 'dart:math';

import 'package:bluecoffee_client/Bloc/Table/TableBloc.dart';
import 'package:bluecoffee_client/Model/DrinkModel.dart';
import 'package:english_words/english_words.dart';


class MenuState {
  TableBloc m_TableBloc;
  List<DrinkModel> m_Menu;
  MenuState(this.m_TableBloc){
    m_Menu = new List<DrinkModel>();
    var listName = generateWordPairs().take(10);
    listName.toList().asMap().forEach((index, Name) {
      var drink = new DrinkModel(index, Name.asPascalCase,
          Random().nextInt(20000), 'images/coffee.jpg');
      m_Menu.add(drink);
    });
  }
}