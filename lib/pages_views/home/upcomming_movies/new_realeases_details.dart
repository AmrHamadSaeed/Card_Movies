import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:card_movies/pages_views/movies_details.dart';
import 'package:flutter/material.dart';

class NewRealeasesDetails extends StatelessWidget {
  Movie movie;

  NewRealeasesDetails(this.movie);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, MovieDetails.routeName,
                arguments: movie);
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 5,
            child: CachedNetworkImage(
              imageUrl: "${ApiConstant.imageBaseUrl}${movie.posterPath}",
              imageBuilder: (context, imageProvider) => Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Center(
                  child: Icon(
                Icons.error,
                color: Colors.red,
                size: 42,
              )),
            ),
          ),
        ),
      ],
    );
  }
}
