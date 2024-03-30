import 'package:card_movies/models/movies_response.dart';
import 'package:card_movies/pages_views/home/upcomming_movies/new_realeases_details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NewRealeasesWidget extends StatelessWidget {
  List<Movie> movies;

  NewRealeasesWidget(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      color: Color.fromARGB(255, 40, 42, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'New Releases',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: true,
              disableCenter: false,
              height: MediaQuery.of(context).size.height * 0.35,
              viewportFraction: 0.4,
            ),
            items: movies.map((mov) {
              return Builder(
                builder: (BuildContext context) {
                  return NewReleasesDetails(mov);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
