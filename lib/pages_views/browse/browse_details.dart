import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/general_list_response.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BrowseDetails extends StatelessWidget {
  Genres itemView;

  BrowseDetails({required this.itemView});

  List<Movie> movies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 19, 18, 1.0),
      appBar: AppBar(
        title: Text(
          itemView.name!,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movies.isEmpty
                ? Center(
                    child: Text(
                      'No movies available',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                : CarouselSlider.builder(
                    itemCount: movies.length,
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.30,
                      // Adjust height as needed
                      autoPlay: true,
                      viewportFraction: 0.55,
                      enlargeCenterPage: true,
                      pageSnapping: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      final movie = movies[index];
                      return Container(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${ApiConstant.imageBaseUrl}${movie.backdropPath ?? ""}',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(Icons.error,
                                      color: Colors.red, size: 42),
                                ),
                              ),
                            ),
                            Center(
                              child: Image.asset('assets/playbutton.png'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            SizedBox(height: 20),

            // Add the Text widget here
            Container(
              color: Theme.of(context).colorScheme.background,
              child: Text(
                'Your additional text goes here',
                // Add your desired text content
                style: TextStyle(
                  fontSize: 20, // Adjust the font size
                  fontWeight: FontWeight.bold, // Customize the style
                  color: Colors.white, // Customize the text color
                ),
              ),
            ),

            // Rest of your code remains the same
            Card(
              clipBehavior: Clip.antiAlias,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              elevation: 5,
              color: Theme.of(context).colorScheme.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CarouselSlider.builder(
                    itemCount: movies.length,
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      disableCenter: false,
                      height: MediaQuery.of(context).size.height *
                          0.4, // Adjust the height as needed
                      viewportFraction:
                          0.6, // Adjust the fraction to fit the content
                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      final movie = movies[index];
                      return Container(
                        color: Theme.of(context).colorScheme.background,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Stack(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "${ApiConstant.imageBaseUrl}${movie.backdropPath ?? ""}",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          // Adjust the height as needed
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                                child: Icon(Icons.error,
                                                    color: Colors.red,
                                                    size: 42)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${movie.title ?? ""}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
