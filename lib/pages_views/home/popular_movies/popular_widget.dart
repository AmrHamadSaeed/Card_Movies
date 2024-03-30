import 'package:card_movies/models/movies_response.dart';
import 'package:card_movies/pages_views/home/popular_movies/popular_details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PopularWidget extends StatelessWidget {
  List<Movie> movies;

  PopularWidget(this.movies);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(seconds: 3),
        autoPlayInterval: Duration(seconds: 10),
        pauseAutoPlayOnTouch: true,
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        height: MediaQuery.of(context).size.height * 0.4,
        viewportFraction: 1.0,
      ),
      items: movies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return PopularDetails(movie);
          },
        );
      }).toList(),
    );
  }
}
