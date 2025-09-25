import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movies/Api/apikeys.dart';

class TraktApi {
  final String apiKey = ApiKeys.traktapikey;
  final String apiVersion = '2';
  final String contenttype = 'application/json';
  final String _urlfortrending =
      'https://api.trakt.tv/movies/trending?extended=full,images';
  final String _urlforallmovies =
      'https://api.trakt.tv/movies/popular?extended=full,images';
  final trendingMoviesDataTrakt = [];
  final allmoviesDataTrakt = [];
  final moviesforgenre = [];

  Future<void> fetchTrendingMoviesFromTrakt() async {
    final urlfortrending = Uri.parse(_urlfortrending);
    final urlforallmovies = Uri.parse(_urlforallmovies);

    final headers = {
      "Content-Type": contenttype,
      "trakt-api-key": apiKey,
      "trakt-api-version": apiVersion,
    };

    try {
      final response = await http.get(urlfortrending, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        trendingMoviesDataTrakt.addAll(data);
        log("✅ Trending Movies from Trakt: $trendingMoviesDataTrakt");
      } else {
        log("❌ Failed to fetch movies. Status Code: ${response.statusCode}");
        log("Response: ${response.body}");
      }
    } catch (e) {
      log("⚠️ Error fetching data from Trakt: $e");
    }
    try {
      final response = await http.get(urlforallmovies, headers: headers);

      if (response.statusCode == 200) {
        allmoviesDataTrakt.clear();
        final List<dynamic> data = jsonDecode(response.body);
        allmoviesDataTrakt.addAll(data);
        // log("✅ popular Movies from Trakt: $allmoviesDataTrakt");
      } else {
        log("❌ Failed to fetch movies. Status Code: ${response.statusCode}");
        log("Response: ${response.body}");
      }
    } catch (e) {
      log("⚠️ Error fetching data from Trakt: $e");
    }
  }

  Future<void> fetchMoviesaspergenreFromTrakt(String genre) async {
    final urlforgenre = Uri.parse(
      "https://api.trakt.tv/movies/popular?genres=$genre&extended=full,images",
    );

    final headers = {
      "Content-Type": contenttype,
      "trakt-api-key": apiKey,
      "trakt-api-version": apiVersion,
    };

    try {
      final response = await http.get(urlforgenre, headers: headers);

      if (response.statusCode == 200) {
        moviesforgenre.clear();
        final List<dynamic> data = jsonDecode(response.body);
        moviesforgenre.addAll(data);
        // log("✅genre by Movies from Trakt: $moviesforgenre");
      } else {
        log("❌ Failed to fetch movies. Status Code: ${response.statusCode}");
        log("Response: ${response.body}");
      }
    } catch (e) {
      log("⚠️ Error fetching data from Trakt: $e");
    }
  }
}
