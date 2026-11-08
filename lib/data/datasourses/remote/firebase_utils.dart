//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../models/movie_model.dart';
// import '../models/my_user.dart';
//
// class FireBaseUtils {
//   static CollectionReference<MyUser> getUsersCollections() {
//     return FirebaseFirestore.instance
//         .collection(MyUser.collectionName)
//         .withConverter<MyUser>(
//       fromFirestore: ((snapshot, options) =>
//           MyUser.fromFireStore(snapshot.data()!)),
//       toFirestore: (user, options) => user.toFireStore(),
//     );
//   }
//
//   static Future<void> addUserInFireStore(MyUser myUser) {
//     CollectionReference<MyUser> collectionRef = getUsersCollections();
//
//     DocumentReference<MyUser> docRef = collectionRef.doc(myUser.id);
//
//     return docRef.set(myUser);
//   }
//
//   static Future<MyUser?> readUserFromFireStore(String uId) async {
//     DocumentSnapshot<MyUser> querySnapshot =
//     await getUsersCollections().doc(uId).get();
//
//     return querySnapshot.data();
//   }
//
//   // ============================================================
//   // HISTORY
//   // ============================================================
//
//   static Future<void> addMovieToHistory({
//     required String userId,
//     required Movies movie,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection(MyUser.collectionName)
//         .doc(userId)
//         .collection('history')
//         .doc(movie.id.toString())
//         .set({
//       'movieId': movie.id,
//       'title': movie.title,
//       'poster': movie.mediumCoverImage,
//       'rating': movie.rating,
//       'visitedAt': FieldValue.serverTimestamp(),
//     });
//   }
//
//   static Future<List<Movies>> getHistory(String userId) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection(MyUser.collectionName)
//         .doc(userId)
//         .collection('history')
//         .orderBy('visitedAt', descending: true)
//         .get();
//
//     return querySnapshot.docs.map((doc) {
//       final data = doc.data();
//
//       return Movies(
//         id: data['movieId'],
//         title: data['title'],
//         mediumCoverImage: data['poster'],
//         rating: (data['rating'] as num?)?.toDouble(),
//       );
//     }).toList();
//   }
//
//   // ============================================================
//   // WISH LIST
//   // Save = Wish List
//   // ============================================================
//
//   static Future<void> addMovieToSave({
//     required String userId,
//     required Movies movie,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection(MyUser.collectionName)
//         .doc(userId)
//         .collection('Save')
//         .doc(movie.id.toString())
//         .set({
//       'movieId': movie.id,
//       'title': movie.title,
//       'poster': movie.mediumCoverImage,
//       'rating': movie.rating,
//     });
//   }
//
//   static Future<void> removeMovieFromSave({
//     required String userId,
//     required Movies movie,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection(MyUser.collectionName)
//         .doc(userId)
//         .collection('Save')
//         .doc(movie.id.toString())
//         .delete();
//   }
//
//   static Future<List<Movies>> getSavedMovies(String userId) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection(MyUser.collectionName)
//         .doc(userId)
//         .collection('Save')
//         .get();
//
//     return querySnapshot.docs.map((doc) {
//       final data = doc.data();
//
//       return Movies(
//         id: data['movieId'],
//         title: data['title'],
//         mediumCoverImage: data['poster'],
//         rating: (data['rating'] as num?)?.toDouble(),
//       );
//     }).toList();
//   }
//
//   static Future<int> getSaveCount(String userId) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection(MyUser.collectionName)
//         .doc(userId)
//         .collection('Save')
//         .get();
//
//     return querySnapshot.docs.length;
//   }
//
//   // ============================================================
//   // WATCH LIST
//   // Watch Button = Watch List
//   // ============================================================
//
//   static Future<void> addMovieToWatchList({
//     required String userId,
//     required Movies movie,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection(MyUser.collectionName)
//         .doc(userId)
//         .collection('watchList')
//         .doc(movie.id.toString())
//         .set({
//       'movieId': movie.id,
//       'title': movie.title,
//       'poster': movie.mediumCoverImage,
//       'rating': movie.rating,
//     });
//   }
//
//   static Future<List<Movies>> getWatchList(String userId) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection(MyUser.collectionName)
//         .doc(userId)
//         .collection('watchList')
//         .get();
//
//     return querySnapshot.docs.map((doc) {
//       final data = doc.data();
//
//       return Movies(
//         id: data['movieId'],
//         title: data['title'],
//         mediumCoverImage: data['poster'],
//         rating: (data['rating'] as num?)?.toDouble(),
//       );
//     }).toList();
//   }
//
//   static Future<int> getWatchListCount(String userId) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection(MyUser.collectionName)
//         .doc(userId)
//         .collection('watchList')
//         .get();
//
//     return querySnapshot.docs.length;
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/movie_model.dart';
import '../../models/my_user.dart';

class FireBaseUtils {
  // =========================
  // USERS
  // =========================

  static CollectionReference<MyUser> getUsersCollections() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, options) {
        return MyUser.fromFireStore(snapshot.data()!);
      },
      toFirestore: (user, options) {
        return user.toFireStore();
      },
    );
  }

  static Future<void> addUserInFireStore(MyUser myUser) {
    final collectionRef = getUsersCollections();

    final docRef = collectionRef.doc(myUser.id);

    return docRef.set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    final documentSnapshot =
    await getUsersCollections().doc(uId).get();

    return documentSnapshot.data();
  }

  // =========================
  // HISTORY
  // =========================

  static Future<void> addMovieToHistory({
    required String userId,
    required Movies movie,
  }) async {
    await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('history')
        .doc(movie.id.toString())
        .set({
      'movieId': movie.id,
      'title': movie.title,
      'poster': movie.mediumCoverImage,
      'rating': movie.rating,
      'visitedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<List<Movies>> getHistory(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('history')
        .orderBy('visitedAt', descending: true)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();

      return Movies(
        id: data['movieId'],
        title: data['title'],
        mediumCoverImage: data['poster'],
        rating: (data['rating'] as num?)?.toDouble(),
      );
    }).toList();
  }

  // =========================
  // WISH LIST
  // Save Button ⭐
  // =========================

  static Future<void> addMovieToSave({
    required String userId,
    required Movies movie,
  }) async {
    await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('Save')
        .doc(movie.id.toString())
        .set({
      'movieId': movie.id,
      'title': movie.title,
      'poster': movie.mediumCoverImage,
      'rating': movie.rating,
    });
  }

  static Future<void> removeMovieFromSave({
    required String userId,
    required Movies movie,
  }) async {
    await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('Save')
        .doc(movie.id.toString())
        .delete();
  }

  static Future<List<Movies>> getSavedMovies(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('Save')
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();

      return Movies(
        id: data['movieId'],
        title: data['title'],
        mediumCoverImage: data['poster'],
        rating: (data['rating'] as num?)?.toDouble(),
      );
    }).toList();
  }

  static Future<int> getSaveCount(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('Save')
        .get();

    return querySnapshot.docs.length;
  }

  static Future<bool> isMovieSaved({
    required String userId,
    required int movieId,
  }) async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('Save')
        .doc(movieId.toString())
        .get();

    return documentSnapshot.exists;
  }

  // =========================
  // WATCH LIST
  // Watch Button ▶️
  // =========================

  static Future<void> addMovieToWatchList({
    required String userId,
    required Movies movie,
  }) async {
    await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('watchList')
        .doc(movie.id.toString())
        .set({
      'movieId': movie.id,
      'title': movie.title,
      'poster': movie.mediumCoverImage,
      'rating': movie.rating,
    });
  }

  static Future<List<Movies>> getWatchList(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('watchList')
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();

      return Movies(
        id: data['movieId'],
        title: data['title'],
        mediumCoverImage: data['poster'],
        rating: (data['rating'] as num?)?.toDouble(),
      );
    }).toList();
  }

  static Future<int> getWatchListCount(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(userId)
        .collection('watchList')
        .get();

    return querySnapshot.docs.length;
  }
}