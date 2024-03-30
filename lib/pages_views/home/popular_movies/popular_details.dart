import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/fire_base_utils.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:card_movies/pages_views/movies_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PopularDetails extends StatefulWidget {
  Movie movie;

  PopularDetails(this.movie);

  @override
  State<PopularDetails> createState() => _PopularDetailsState();
}

class _PopularDetailsState extends State<PopularDetails> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    checkMovieInFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: "${ApiConstant.imageBaseUrl}${widget.movie.backdropPath}",
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
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, MovieDetails.routeName,
                  arguments: widget.movie);
            },
            child: Image.asset('assets/playbutton.png'),
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.30,
          top: MediaQuery.of(context).size.height * 0.13,
          left: MediaQuery.of(context).size.height * 0.010,
          child: CachedNetworkImage(
            imageUrl: "${ApiConstant.imageBaseUrl}${widget.movie.posterPath}",
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
          top: MediaQuery.of(context).size.height * 0.13,
          left: MediaQuery.of(context).size.width * 0.02,
          child: InkWell(
              onTap: () {
                if (!isSelected) {
                  isSelected = true;
                  FireBaseUtils.AddMoviesToFirebase(widget.movie);
                } else {
                  isSelected = false;

                  FireBaseUtils.DeletTask('${widget.movie.DataBaseId}');
                }
                setState(() {});
              },
              child: isSelected == false
                  ? Image.asset('assets/bookmark.png')
                  : Image.asset('assets/bookmarkSelected.png')),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.31,
          left: MediaQuery.of(context).size.height * 0.20,
          child: Text(
            '${widget.movie.title}',
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
            '${widget.movie.releaseDate!.substring(0, 4)}  PG-13  ${widget.movie.originalLanguage}',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      ],
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
