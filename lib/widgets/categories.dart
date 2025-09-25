import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/Api/traktapi.dart';
import 'package:movies/pages/description_page.dart';
import 'package:movies/widgets/allcategories.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late final TraktApi _traktapi = TraktApi();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _traktapi.fetchTrendingMoviesFromTrakt();
    if (!mounted) return;
    setState(() {});

    await _traktapi.fetchMoviesaspergenreFromTrakt(genres[_selectedIndex]);
    if (!mounted) return;
    setState(() {});
  }

  final List<String> genres = [
    "All",
    "Action",
    "Adventure",
    "Comedy",
    "Drama",
    "Fantasy",
    "Horror",
    "Mystery",
    "Romance",
    "Thriller",
    "Western",
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 23),
          child: Text(
            'Categories',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15),
          margin: const EdgeInsets.only(left: 23),
          child: Container(
            height: 39,
            decoration: BoxDecoration(
              color: const Color(0xff131A22).withValues(alpha: 0.5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedIndex;
                return GestureDetector(
                  onTap: () async {
                    if (_selectedIndex != index) {
                      setState(() => _selectedIndex = index);

                      if (genres[index] == "All") {
                        await _traktapi.fetchTrendingMoviesFromTrakt();
                      } else {
                        await _traktapi.fetchMoviesaspergenreFromTrakt(
                          genres[index].toLowerCase(),
                        );
                      }

                      if (!mounted) return;
                      setState(() {});
                    }
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 3.5,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (Theme.of(context).brightness == Brightness.light
                                ? const Color(
                                    0xff07213D,
                                  ).withValues(alpha: 0.61)
                                : const Color(0xff131A22))
                          : const Color(0x00000000),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      genres[index],
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: isSelected
                            ? const Color(0xff12CDD9)
                            : const Color(0xffEBEBEF),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 25, top: 5),
                  child: Text(
                    genres[_selectedIndex] == "All"
                        ? "Popular Movies"
                        : genres[_selectedIndex],
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontSize: 14),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(right: 25, top: 5),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Allcategories(),
                        ),
                      ),
                    },
                    child: Text(
                      "See All",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF12CDD9),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),

            Stack(
              children: [
                SizedBox(
                  height: 285,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DescriptionPage(
                              overview: genres[_selectedIndex] == "All"
                                  ? _traktapi
                                        .allmoviesDataTrakt[index]['overview']
                                  : _traktapi.moviesforgenre[index]['overview'],
                              backdropimage: genres[_selectedIndex] == "All"
                                  ? "https://${_traktapi.allmoviesDataTrakt[index]['images']['fanart'][0]}"
                                  : "https://${_traktapi.moviesforgenre[index]['images']['fanart'][0]}",
                              title: genres[_selectedIndex] == "All"
                                  ? _traktapi.allmoviesDataTrakt[index]['title']
                                  : _traktapi.moviesforgenre[index]['title'],
                              year: genres[_selectedIndex] == "All"
                                  ? _traktapi.allmoviesDataTrakt[index]['year']
                                        .toString()
                                  : _traktapi.moviesforgenre[index]['year']
                                        .toString(),
                              rating: genres[_selectedIndex] == "All"
                                  ? _traktapi
                                        .allmoviesDataTrakt[index]['rating']
                                        .toString()
                                  : _traktapi.moviesforgenre[index]['rating']
                                        .toString(),
                              genre: genres[_selectedIndex] == "All"
                                  ? (_traktapi.allmoviesDataTrakt[index]['genres']
                                            as List)
                                        .join(", ")
                                  : (_traktapi.moviesforgenre[index]['genres']
                                            as List)
                                        .join(", "),
                              releaseDate: genres[_selectedIndex] == "All"
                                  ? _traktapi
                                        .allmoviesDataTrakt[index]['released']
                                        .toString()
                                  : _traktapi.moviesforgenre[index]['released']
                                        .toString(),
                              time: genres[_selectedIndex] == "All"
                                  ? _traktapi
                                        .allmoviesDataTrakt[index]['runtime']
                                        .toString()
                                  : _traktapi.moviesforgenre[index]['runtime']
                                        .toString(),
                              posterimage: genres[_selectedIndex] == "All"
                                  ? "https://${_traktapi.allmoviesDataTrakt[index]['images']['poster'][0]}"
                                  : "https://${_traktapi.moviesforgenre[index]['images']['poster'][0]}",
                              trailer: genres[_selectedIndex] == "All"
                                  ? _traktapi
                                        .allmoviesDataTrakt[index]['trailer']
                                  : _traktapi.moviesforgenre[index]['trailer'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 135,
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xff131A22).withValues(alpha: 0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: genres[_selectedIndex] == "All"
                                          ? "https://${_traktapi.allmoviesDataTrakt[index]['images']['poster'][0]}"
                                          : "https://${_traktapi.moviesforgenre[index]['images']['poster'][0]}",

                                      // placeholder: (context, url) => Center(
                                      //   child: CircularProgressIndicator(
                                      //     color: const Color(
                                      //       0xff12CDD9,
                                      //     ).withValues(alpha: 0.5),
                                      //   ),
                                      // ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    color: const Color(
                                      0xFF000000,
                                    ).withValues(alpha: 0.15),
                                  ),
                                ),

                                Positioned(
                                  left: 80,
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    width: 40,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xff252836,
                                      ).withValues(alpha: 0.72),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          "Assets/star.png",
                                          height: 14,
                                          width: 14,
                                          color: const Color(0xFFFF6E40),
                                        ),
                                        Text(
                                          genres[_selectedIndex] == "All"
                                              ? (_traktapi.allmoviesDataTrakt[index]['rating']
                                                        as double)
                                                    .toStringAsFixed(1)
                                              : (_traktapi.moviesforgenre[index]['rating']
                                                        as double)
                                                    .toStringAsFixed(1),
                                          style: const TextStyle(
                                            color: Color(0xFFFF6E40),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 5,
                                    top: 5,
                                  ),
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    genres[_selectedIndex] == "All"
                                        ? "${_traktapi.allmoviesDataTrakt[index]['title']}"
                                        : "${_traktapi.moviesforgenre[index]['title']}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "monserrat",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 6,
                                    top: 3,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        genres[_selectedIndex] == "All"
                                            ? "${_traktapi.allmoviesDataTrakt[index]['year']} "
                                            : "${_traktapi.moviesforgenre[index]['year']}",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontFamily: "monserrat",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        genres[_selectedIndex] == "All"
                                            ? (_traktapi.allmoviesDataTrakt[index]['genres']
                                                      as List)
                                                  .firstWhere(
                                                    (g) =>
                                                        g
                                                            .toString()
                                                            .toLowerCase() ==
                                                        genres[_selectedIndex]
                                                            .toLowerCase(),
                                                    orElse: () =>
                                                        (_traktapi
                                                                .allmoviesDataTrakt[index]['genres']
                                                            as List)[0],
                                                  )
                                            : (_traktapi.moviesforgenre[index]['genres']
                                                      as List)
                                                  .firstWhere(
                                                    (g) =>
                                                        g
                                                            .toString()
                                                            .toLowerCase() ==
                                                        genres[_selectedIndex]
                                                            .toLowerCase(),
                                                    orElse: () =>
                                                        (_traktapi
                                                                .moviesforgenre[index]['genres']
                                                            as List)[0],
                                                  ),

                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontFamily: "monserrat",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: genres[_selectedIndex] == "All"
                        ? _traktapi.allmoviesDataTrakt.length
                        : _traktapi.moviesforgenre.length,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
