import 'package:card_movies/MyThemeData.dart';
import 'package:card_movies/api_manager.dart';
import 'package:card_movies/models/general_list_response.dart';
import 'package:card_movies/pages_views/browse/genres/list.dart';
import 'package:flutter/material.dart';

class TabBrows extends StatefulWidget {
  @override
  State<TabBrows> createState() => _TabBrowsState();
}

class _TabBrowsState extends State<TabBrows> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Browse Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: FutureBuilder<GeneralCategoryList?>(
            future: ApiManager.getGeneralCategoryList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: MyThemeData.primaryLightColor,
                  ),
                );

                /// handel user network disable => catch Api getSources (throw e)
              } else if (snapshot.hasError) {
                return Column(
                  children: [
                    Text('Something went wrong '),
                    ElevatedButton(
                        onPressed: () {
                          ApiManager.getGeneralCategoryList();
                          setState(() {});
                        },
                        child: Text('user error'))
                  ],
                );
              }

              if (snapshot.data?.success == false) {
                return Column(
                  children: [
                    Text(snapshot.data?.status_message ?? ''),
                    ElevatedButton(
                        onPressed: () {
                          ApiManager.getGeneralCategoryList();
                          setState(() {});
                        },
                        child: Text('success == false'))
                  ],
                );
              }
              var genresList = snapshot.data?.genres ?? [];

              return GenresList(genresList: genresList);
            }));
  }
}
