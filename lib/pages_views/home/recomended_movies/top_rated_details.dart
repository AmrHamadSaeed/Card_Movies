import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:flutter/material.dart';

class TopRatedDetails extends StatelessWidget {
  Movie movie;

  TopRatedDetails(this.movie);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10, left: 10),
      color: Color.fromRGBO(52, 53, 52, 1.0),
      clipBehavior: Clip.antiAlias,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 5,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
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
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/star.png', width: 32),
                Text(
                  '${movie.voteAverage}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '  ${movie.title}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${movie.releaseDate!.substring(0, 4)} ',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}