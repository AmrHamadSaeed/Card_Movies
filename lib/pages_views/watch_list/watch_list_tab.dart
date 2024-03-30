import 'package:card_movies/MyThemeData.dart';
import 'package:card_movies/fire_base_utils.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:card_movies/pages_views/watch_list/watch_list_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WatchListTab extends StatelessWidget {
  const WatchListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyThemeData.primaryLightColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Watchlist',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot<Movie>>(
              stream: FireBaseUtils.readMoviesFromFirebaseAfterAdding(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: MyThemeData.yellowColor,
                  ));
                }
                List<Movie> movies =
                    snapshot.data?.docs.map((task) => task.data()).toList() ??
                        [];
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return WatchListItemsDetails(movies[index]);
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
