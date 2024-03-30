import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:flutter/material.dart';

class WatchListItemsDetails extends StatelessWidget {
  Movie movie;

  WatchListItemsDetails(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/icon_iconmaterial.png'),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: '${ApiConstant.imageBaseUrl}${movie.posterPath}',
                imageBuilder: (context, imageProvider) => Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width * 0.40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
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
            ],
          )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${movie.title}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${movie.releaseDate!.substring(0, 4)} ',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${movie.overview} ',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 6,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
