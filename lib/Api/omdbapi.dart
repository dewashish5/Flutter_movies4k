// import 'dart:developer';
// import 'package:flutter/widgets.dart';
// import 'package:movies/Api/apikeys.dart';

// import 'package:movies/Api/traktapi.dart';
// import 'package:t_omdb/t_omdb.dart';
// import 'dart:convert';

// class Omdbapi {
//   final String apiKey = ApiKeys.omdbApiKey;
//   late final TraktApi traktapi = TraktApi();
//   final traktimdbcode = [];
//   // Separate lists for storing results
//   final trendingMoviesDataOmdb = [];
//   // final _trendingShowsData = StaticMovies.trendingShows;
//   // final _genreMoviesData = StaticMovies.moviesByGenre;

//   Future<void> fetchMovies() async {
//     await traktapi.fetchTrendingMoviesFromTrakt();
//     traktimdbcode.addAll(traktapi.trendingMoviesDataTrakt);
//     // log("Fetched Trakt data: $traktimdbcode ");
//     final omdb = OmdbApi(apiKey);
//     for (String title in traktimdbcode) {
//       // log('Title to pass $title');
//       final showData = await omdb.searchByTitle(title);
//       // log('showData $showData');

//       trendingMoviesDataOmdb.add(jsonDecode(showData!));
//     }

//     log("trendingMoviesData $trendingMoviesDataOmdb");

//     // // Fetch trending movies
//     // for (String title in StaticMovies.trendingMovies) {
//     //   // print('Title to pass $title');
//     //   try {

//     //     final String? movieData = await omdb.searchByTitle(title);
//     //     if (movieData != null) {
//     //       // print('movieData $movieData');

//     //       trendingMoviesData.add(jsonDecode(movieData));
//     //     }
//     //     print('$title');
//     //   } catch (e) {
//     //     print('Error fetching trending movie "$title": $e');
//     //   }
//     // }
//     // print('trendingMoviesData outer  $trendingMoviesData');

//     //   // Fetch trending shows
//     //   for (String title in StaticMovies.trendingShows) {
//     //     try {
//     //       final String? showData = await omdb.searchByTitle(title);
//     //       if (showData != null) {
//     //         _trendingShowsData.add(jsonDecode(showData));
//     //       }
//     //     } catch (e) {
//     //       print('Error fetching trending show "$title": $e');
//     //     }
//     //   }

//     //   //   // Fetch movies by genre
//     //   for (var genre in StaticMovies.moviesByGenre.keys) {
//     //     _genreMoviesData[genre] = []; // initialize list
//     //     for (var title in StaticMovies.moviesByGenre[genre]!) {
//     //       try {
//     //         final String? movieData = await omdb.searchByTitle(title);
//     //         if (movieData != null) {
//     //           _genreMoviesData[genre]!.add(jsonDecode(movieData));
//     //         }
//     //       } catch (e) {
//     //         print('Error fetching "$title" in genre "$genre": $e');
//     //       }
//     //     }
//     //   }
//   }
// }
