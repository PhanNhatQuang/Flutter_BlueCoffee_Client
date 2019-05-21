import 'package:flutter/material.dart';
import 'package:bluecoffee_client/Theme.dart' as Theme;

class GradientAppBar extends StatelessWidget {

  final String title;
  final double barHeight = 70.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: new Center(
        child: new Text(
          title,
          style: Theme.TextStyles.appBarTitle,
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Theme.Colors.appBarGradientEnd, Theme.Colors.appBarGradientStart],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp
        ),
      ),
    );
  }
}