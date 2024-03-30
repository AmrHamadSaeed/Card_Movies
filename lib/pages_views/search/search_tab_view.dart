import 'package:card_movies/MyThemeData.dart';
import 'package:card_movies/api_manager.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:card_movies/pages_views/search/search_details.dart';
import 'package:flutter/material.dart';

class SearchTabView extends StatefulWidget {
  @override
  State<SearchTabView> createState() => _SearchTabViewState();
}

class _SearchTabViewState extends State<SearchTabView> {
  String query = '';
  List<Movie> movies = []; // Change 'movies' to a list
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: MyThemeData.primaryLightColor,
        title: TextFormField(
          cursorColor: Colors.white,
          style: TextStyle(
            color: MyThemeData.whiteColor,
            fontSize: 21,
          ),
          controller: search,
          onChanged: (String value) {
            setState(() {
              query = value;
            });
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            filled: true,
            fillColor: MyThemeData.greyColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: MyThemeData.whiteColor),
            ),
            prefixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 32,
              ),
              color: MyThemeData.whiteColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  query = '';
                  search.clear();
                });
              },
              icon: Icon(
                Icons.close,
                size: 32,
              ),
              color: MyThemeData.whiteColor,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<MoviesModel?>(
              future: ApiManager.getSearchMovies(query),
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
                            ApiManager.getSearchMovies(query);
                            setState(() {});
                          },
                          child: Text('user error'))
                    ],
                  );
                }

                if (snapshot.data?.success == false &&
                    snapshot.data?.status_code == 34) {
                  return Column(
                    children: [
                      Text(snapshot.data?.status_message ?? ''),
                      ElevatedButton(
                          onPressed: () {
                            ApiManager.getSearchMovies(query);
                            setState(() {});
                          },
                          child: Text('success == false'))
                    ],
                  );
                } else if (snapshot.hasData) {
                  movies = snapshot.data?.results ?? [];

                  return SearchDetails(
                    movies: movies,
                    query: query,
                  );
                } else {
                  return Text('No results found.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
