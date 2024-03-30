import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/fire_base_utils.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:card_movies/pages_views/movies_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopRatedDetails extends StatefulWidget {
  Movie movie;

  TopRatedDetails(this.movie);

  @override
  State<TopRatedDetails> createState() => _TopRatedDetailsState();
}

class _TopRatedDetailsState extends State<TopRatedDetails> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    checkMovieInFireStore();
  }

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
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, MovieDetails.routeName,
                        arguments: widget.movie);
                  },
                  child: CachedNetworkImage(
                    imageUrl:
                    "${ApiConstant.imageBaseUrl}${widget.movie.posterPath}",
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
                Positioned(
                  top: 0,
                  child: InkWell(
                      onTap: () {
                        if (!isSelected) {
                          isSelected = true;
                          FireBaseUtils.AddMoviesToFirebase(widget.movie);
                        } else {
                          isSelected = false;
                          FireBaseUtils.deleteTask(
                              '${widget.movie.DataBaseId}');
                        }
                        setState(() {});
                      },
                      child: isSelected == false
                          ? Image.asset('assets/bookmark.png')
                          : Image.asset('assets/bookmarkSelected.png')),
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
                  '${widget.movie.voteAverage}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '  ${widget.movie.title}',
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
                '${widget.movie.releaseDate!.substring(0, 4)} ',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkMovieInFireStore() async {
    QuerySnapshot<Movie> temp =
        await FireBaseUtils.readMovieFormFirebase(widget.movie.id!);
    if (temp.docs.isEmpty) {
      isSelected = false;
    } else {
      widget.movie.DataBaseId = temp.docs[0].data().DataBaseId;
      isSelected = true;
      setState(() {});
    }
  }
}
