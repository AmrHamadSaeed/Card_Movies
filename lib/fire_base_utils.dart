import 'package:card_movies/models/movies_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseUtils {
  static CollectionReference<Movie> getMoviesCollection() {
    return FirebaseFirestore.instance.collection("Movies").withConverter<Movie>(
        fromFirestore: (snapshot, option) => Movie.fromJson(snapshot.data()!),
        toFirestore: (value, option) => value.toJson());
  }

  static Future<void> AddMoviesToFirebase(Movie movie) {
    var collection = getMoviesCollection();
    var docref = collection.doc();
    movie.DataBaseId = docref.id;
    return docref.set(movie);
  }

  static Future<QuerySnapshot<Movie>> readMovieFormFirebase(num id) async {
    var mov = await getMoviesCollection().where('id', isEqualTo: id).get();
    return mov;
  }

  static Future<void> DeletTask(String id) {
    return getMoviesCollection().doc(id).delete();
  }
}
