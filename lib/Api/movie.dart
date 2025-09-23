class StaticMovies {
  /// 🔥 Trending Movies (General)
  static const List<String> trendingMovies = [
    "Oppenheimer",
    "Dune: Part Two",
    "The Batman",
    "Top Gun: Maverick",
    "Avatar: The Way of Water",
  ];

  /// 📺 Trending TV Shows
  static const List<String> trendingShows = [
    "Breaking Bad",
    "Game of Thrones",
    "The Boys",
    "Stranger Things",
    "House of the Dragon",
  ];

  /// 🎭 Genre-based Movie Lists
  static const Map<String, List<String>> moviesByGenre = {
    "Action": [
      "John Wick",
      "Mad Max: Fury Road",
      "Gladiator",
      "The Dark Knight",
      "Avengers: Endgame",
    ],
    "Comedy": [
      "Superbad",
      "The Hangover",
      "Step Brothers",
      "21 Jump Street",
      "Dumb and Dumber",
    ],
    "Drama": [
      "The Shawshank Redemption",
      "Fight Club",
      "Forrest Gump",
      "The Godfather",
      "A Beautiful Mind",
    ],
    "Sci-Fi": [
      "Interstellar",
      "Inception",
      "Blade Runner 2049",
      "Ex Machina",
      "The Matrix",
    ],
    "Romance": [
      "La La Land",
      "Titanic",
      "Pride & Prejudice",
      "The Notebook",
      "Crazy Rich Asians",
    ],
    "Horror": ["The Conjuring", "It", "Hereditary", "A Quiet Place", "Get Out"],
  };
}
