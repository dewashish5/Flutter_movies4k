import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/Api/traktapi.dart';

class CustomCaraousal extends StatefulWidget {
  const CustomCaraousal({super.key});

  @override
  State<CustomCaraousal> createState() => _CustomCaraousalState();
}

class _CustomCaraousalState extends State<CustomCaraousal> {
  late final TraktApi _traktapi = TraktApi();
  int _currentindex = 0;

  @override
  void initState() {
    super.initState();
    _loadTrendingMovies();
  }

  Future<void> _loadTrendingMovies() async {
    await _traktapi.fetchTrendingMoviesFromTrakt();
    if (!mounted) return; // ✅ prevent setState after dispose
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 164,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.80,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
                pauseAutoPlayOnTouch: true,
                pauseAutoPlayOnManualNavigate: true,
                onPageChanged: (index, reason) {
                  if (!mounted) return; // ✅ safeguard
                  setState(() {
                    _currentindex = index;
                  });
                },
              ),
              items: _traktapi.trendingMoviesDataTrakt.map((e) {
                final String imageUrl =
                    "https://${e['movie']['images']['fanart'][0]}";

                return Stack(
                  children: [
                    Material(
                      elevation: 5,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shadowColor: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF101011).withValues(alpha: 0.2),
                              const Color(0xff101011),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueGrey,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0x00000000),
                            const Color(0xFF000000).withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      top: MediaQuery.of(context).size.height * 0.12,
                      left: MediaQuery.of(context).size.width * 0.03,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) {
                                String title = e['movie']['title'];
                                TextStyle style = Theme.of(
                                  context,
                                ).textTheme.titleMedium!;
                                double fontSize = style.fontSize!;

                                if (title.length > 25) fontSize -= 2;
                                if (title.length > 40) fontSize -= 2;

                                return Text(
                                  title,
                                  style: style.copyWith(fontSize: fontSize),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                );
                              },
                            ),
                            const SizedBox(height: 2),
                            Text(
                              e['movie']['year'].toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _traktapi.trendingMoviesDataTrakt.asMap().entries.map((
                e,
              ) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: 10,
                  width: _currentindex == e.key ? 28 : 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _currentindex == e.key
                        ? (Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xff4B8787)
                              : const Color.fromARGB(255, 230, 231, 233))
                        : (Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF9E9E9E).withValues(alpha: 0.3)
                              : const Color(0xFF9E9E9E).withValues(alpha: 0.4)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
