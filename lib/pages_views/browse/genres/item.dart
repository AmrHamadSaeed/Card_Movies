import 'package:card_movies/models/general_list_response.dart';
import 'package:flutter/material.dart';

class GenresItem extends StatelessWidget {
  Genres? itemView;
  final String categoryMovies;

  GenresItem(this.itemView, this.categoryMovies);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      borderOnForeground: true,
      margin: EdgeInsets.only(bottom: 10, left: 10),
      color: Color(0xFF343534),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              child: Image.asset(
                'assets/${categoryMovies}',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                itemView?.name ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
