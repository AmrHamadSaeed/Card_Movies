import 'package:card_movies/models/general_list_response.dart';
import 'package:card_movies/pages_views/browse/genres/item.dart';
import 'package:card_movies/pages_views/browse/genres/path_image.dart';
import 'package:flutter/material.dart';

class GenresList extends StatelessWidget {
  final categories = PathImageGenres.imagePathList();
  List<Genres> genresList;

  GenresList({required this.genresList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 16,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
      ),
      itemCount: genresList.length, // Use the length of the categories list
      itemBuilder: (context, index) =>
          GenresItem(genresList[index], categories[index]),
    );
  }
}
