import 'package:card_movies/MyThemeData.dart';
import 'package:card_movies/home_tabs_widget.dart';
import 'package:card_movies/pages_views/movies_details.dart';
import 'package:flutter/material.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeTabsWidget.routeName: (_) => HomeTabsWidget(),
        MovieDetails.routeName: (_) => MovieDetails(),
      },
      initialRoute: HomeTabsWidget.routeName,
      title: 'Movies',
      theme: MyThemeData.Themes,
    );
  }
}
