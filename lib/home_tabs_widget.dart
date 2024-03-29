import 'package:card_movies/MyThemeData.dart';
import 'package:card_movies/pages_views/browse/tab_broswe.dart';
import 'package:card_movies/pages_views/home/home_tab_view.dart';
import 'package:card_movies/pages_views/search/search_tab_view.dart';
import 'package:card_movies/pages_views/watch_list/watch_list_tab.dart';
import 'package:flutter/material.dart';


class HomeTabsWidget extends StatefulWidget {
  static const String routeName = 'home_tabs_widget';

  @override
  State<HomeTabsWidget> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeTabsWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: MyThemeData.primaryLightColor,
        ),
        child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.movie), label: 'Browser'),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/icon_bookmarks.png')), label: 'Watch List'),
            ]),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    HomeTabView(),
    SearchTabView(),
    TabBrows(),
    WatchListTab(),
  ];
}
