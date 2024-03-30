import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:flutter/material.dart';

class NewRealeasesDetails extends StatelessWidget {
  Movie mov;

  NewRealeasesDetails(this.mov);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
          elevation: 5,
          child: CachedNetworkImage(
            imageUrl: "${ApiConstant.imageBaseUrl}${mov.posterPath}",
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
      ],
    );
  }
}
