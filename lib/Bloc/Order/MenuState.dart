import 'package:bluecoffee_client/Bloc/Table/TableBloc.dart';
import 'package:bluecoffee_client/Model/DrinkModel.dart';
import 'package:bluecoffee_client/Model/OrderModel.dart';
import 'package:bluecoffee_client/Model/TableModel.dart';
import 'package:flutter/material.dart';


class MenuState {
  TableBloc m_TableBloc;
  MenuState(this.m_TableBloc);
}