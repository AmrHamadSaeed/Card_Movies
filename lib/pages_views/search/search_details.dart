import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:flutter/material.dart';

class SearchDetails extends StatefulWidget {
  final List<Movie>? movies;
  final String query;

  SearchDetails({required this.movies, required this.query});

  @override
  State<SearchDetails> createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
  @override
  Widget build(BuildContext context) {
    return widget.movies?.isEmpty == true
        ? Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset('assets/icon_iconmaterial.png')),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'No Movies Found',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6745098233222961),
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Expanded(
            child: SizedBox(
              height: MediaQuery.of(context)
                  .size
                  .height, // Specify the desired height
              child: ListView.builder(
                itemCount: widget.movies?.length,
                itemBuilder: (context, index) {
                  final movie = widget.movies![index]; // Get the current movie
                  return Card(
                    margin: EdgeInsets.only(bottom: 10, left: 10),
                    color: Color.fromRGBO(52, 53, 52, 1.0),
                    clipBehavior: Clip.antiAlias,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    elevation: 5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: CachedNetworkImage(
                            imageUrl:
                                "${ApiConstant.imageBaseUrl}${movie.posterPath}",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 120, // Adjust the desired height
                              width: double.infinity,
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
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        // Add some spacing between the image and other information
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title ?? 'Title Not Available',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      16, // Adjust the font size as needed
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                movie.releaseDate ?? 'Title Not Available',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      12, // Adjust the font size as needed
                                ),
                              ),

                              // Add other movie information here...
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}
