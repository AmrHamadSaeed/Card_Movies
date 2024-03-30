import 'package:card_movies/MyThemeData.dart';
import 'package:card_movies/api_manager.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:card_movies/pages_views/home/popular_movies/popular_widget.dart';
import 'package:card_movies/pages_views/home/upcomming_movies/new_realeases_widget.dart';
import 'package:flutter/material.dart';

class HomeTabView extends StatefulWidget {
  static const String routeName = "HomeTabView";

  const HomeTabView({super.key});

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<MoviesModel?>(
                  future: ApiManager.getPopularMovies(),
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
                                ApiManager.getPopularMovies();
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
                                ApiManager.getPopularMovies();
                                setState(() {});
                              },
                              child: Text('success == false'))
                        ],
                      );
                    }
                    var sourcesList = snapshot.data?.results ?? [];
                    print("Amr0 $sourcesList");
                    return PopularWidget(sourcesList);
                  }),
              FutureBuilder<MoviesModel?>(
                  future: ApiManager.getNewReleasesMovies(),
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
                                ApiManager.getNewReleasesMovies();
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
                                ApiManager.getPopularMovies();
                                setState(() {});
                              },
                              child: Text('success == false'))
                        ],
                      );
                    }
                    var sourcesList = snapshot.data?.results ?? [];
                    print("Amr0 $sourcesList");
                    return NewRealeasesWidget(snapshot.data!.results!);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
