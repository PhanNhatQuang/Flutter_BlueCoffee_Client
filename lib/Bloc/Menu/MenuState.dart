import 'package:bluecoffee_client/Bloc/Table/TableBloc.dart';
import 'package:bluecoffee_client/FileHelper.dart';
import 'package:bluecoffee_client/Model/MenuModel.dart';

class MenuState {
  TableBloc m_TableBloc;
  MenuModel m_Menu;
  MenuState(this.m_TableBloc){
   m_Menu = FileHelper.s_Menu; 
  }
}