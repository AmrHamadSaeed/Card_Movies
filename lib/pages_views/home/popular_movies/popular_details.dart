import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:flutter/material.dart';

class PopularDetails extends StatelessWidget {
  Movie movie;

  PopularDetails(this.movie);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: "${ApiConstant.imageBaseUrl}${movie.backdropPath}",
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
        Positioned(
          height: MediaQuery.of(context).size.height * 0.26,
          left: MediaQuery.of(context).size.height * 0.15,
          child: Image.asset('assets/playbutton.png'),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.30,
          top: MediaQuery.of(context).size.height * 0.13,
          left: MediaQuery.of(context).size.height * 0.010,
          child: CachedNetworkImage(
            imageUrl: "${ApiConstant.imageBaseUrl}${movie.posterPath}",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Center(
                child: Icon(
              Icons.error,
              color: Colors.red,
              size: 42,
            )),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.31,
          left: MediaQuery.of(context).size.height * 0.20,
          child: Text(
            '${movie.title}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.36,
          left: MediaQuery.of(context).size.height * 0.20,
          child: Text(
            '${movie.releaseDate!.substring(0, 4)}  PG-13  ${movie.originalLanguage}',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
