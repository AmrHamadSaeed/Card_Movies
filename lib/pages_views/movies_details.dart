import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/MyThemeData.dart';
import 'package:card_movies/api_manager.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:card_movies/pages_views/home/recomended_movies/top_rated_widget.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  static const String routeName = 'MovieDetails';

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    Movie args = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 19, 18, 1.0),
      appBar: AppBar(
        title: Text(
          '${args.title}',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: "${ApiConstant.imageBaseUrl}${args.backdropPath}",
                    imageBuilder: (context, imageProvider) => Container(
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
                      top: MediaQuery.of(context).size.height * 0.1,
                      left: MediaQuery.of(context).size.width * 0.45,
                      child: Image.asset('assets/playbutton.png')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                '${args.title}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8),
              child: Text(
                '${args.releaseDate!.substring(0, 4)}  PG-13  ${args.originalLanguage}',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Stack(
                        children: [
                          Positioned(
                            width: MediaQuery.of(context).size.width * 0.32,
                            height: MediaQuery.of(context).size.height * 0.28,
                            top: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.height * 0.010,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${ApiConstant.imageBaseUrl}${args.posterPath}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${args.overview}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 5,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Image.asset('assets/star.png'),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '${args.voteAverage}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<MoviesModel?>(
                future: ApiManager.getSimilarMovies(args.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: MyThemeData.primaryLightColor,
                      ),
                    );

                    /// handel user network disable => catch Api getSources (throw e)
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        Text('Something went wrong '),
                        ElevatedButton(
                            onPressed: () {
                              ApiManager.getSimilarMovies(args.id);
                              setState(() {});
                            },
                            child: Text('user error'))
                      ],
                    );
                  }

                  if (snapshot.data?.success == false &&
                      snapshot.data?.status_code == 34) {
                    return Column(
                      children: [
                        Text(snapshot.data?.status_message ?? ''),
                        ElevatedButton(
                            onPressed: () {
                              ApiManager.getSimilarMovies(args.id);
                              setState(() {});
                            },
                            child: Text('success == false'))
                      ],
                    );
                  }

                  return TopRatedWidget(
                      snapshot.data!.results!, 'More Like This');
                }),
          ],
        ),
      ),
    );
  }
}
