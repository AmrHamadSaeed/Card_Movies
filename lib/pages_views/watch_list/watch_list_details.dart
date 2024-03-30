import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/fire_base_utils.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:card_movies/pages_views/movies_details.dart';
import 'package:flutter/material.dart';

class WatchListItemsDetails extends StatefulWidget {
  Movie movie;

  WatchListItemsDetails(this.movie);

  @override
  State<WatchListItemsDetails> createState() => _WatchListItemsDetailsState();
}

class _WatchListItemsDetailsState extends State<WatchListItemsDetails> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieDetails.routeName,
            arguments: widget.movie);
      },
      child: Container(
        margin: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
                child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      '${ApiConstant.imageBaseUrl}${widget.movie.posterPath}',
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
                InkWell(
                    onTap: () {
                      if (isSelected == false) {
                        FireBaseUtils.deleteTask('${widget.movie.DataBaseId}');
                      }
                      setState(() {});
                    },
                    child: Image.asset('assets/bookmarkSelected.png')),
              ],
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.movie.title}',
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
                      '${widget.movie.releaseDate!.substring(0, 4)} ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${widget.movie.overview} ',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
