import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/fire_base_utils.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:card_movies/pages_views/movies_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewRealeasesDetails extends StatefulWidget {
  Movie movie;

  NewRealeasesDetails(this.movie);

  @override
  State<NewRealeasesDetails> createState() => _NewRealeasesDetailsState();
}

class _NewRealeasesDetailsState extends State<NewRealeasesDetails> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    // checkMovieInFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, MovieDetails.routeName,
                arguments: widget.movie);
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 5,
            child: CachedNetworkImage(
              imageUrl: "${ApiConstant.imageBaseUrl}${widget.movie.posterPath}",
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
        Positioned(
          top: MediaQuery.of(context).size.height * 0.005,
          left: MediaQuery.of(context).size.width * 0.01,
          child: InkWell(
              onTap: () {
                if (!isSelected) {
                  isSelected == true;
                  FireBaseUtils.AddMoviesToFirebase(widget.movie);
                } else {
                  isSelected == false;
                  FireBaseUtils.deleteTask('${widget.movie.DataBaseId}');
                }
                setState(() {});
              },
              child: isSelected == false
                  ? Image.asset('assets/bookmark.png')
                  : Image.asset('assets/bookmarkSelected.png')),
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
    }
    setState(() {});
  }
}
