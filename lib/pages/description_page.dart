import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DescriptionPage extends StatefulWidget {
  final String backdropimage,
      posterimage,
      title,
      overview,
      releaseDate,
      rating,
      year,
      time,
      genre,
      casttitle,
      castimage,
      trailer,
      castexpertise;

  const DescriptionPage({
    super.key,
    this.trailer = "",
    this.time = "",
    this.year = "",
    this.genre = "",
    this.title = "",
    this.posterimage = "",
    this.releaseDate = "",
    this.backdropimage = "",
    this.overview = "",
    this.rating = "",
    this.casttitle = "",
    this.castimage = "",
    this.castexpertise = "",
  });

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  late YoutubePlayerController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.trailer);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
        controlsVisibleAtStart: false,
        hideControls: false,
      ),
    );
  }

  void toggleTrailer() {
    if (!mounted) return;

    setState(() {
      isPlaying = !isPlaying;
    });

    if (mounted) {
      if (isPlaying) {
        _controller.play();
      } else {
        _controller.pause();
      }
    }
    log("Trailer playing: $isPlaying");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // Backdrop + YouTube player + AppBar
            Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      children: [
                        // Backdrop image
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          opacity: isPlaying ? 0 : 1,
                          child: CachedNetworkImage(
                            imageUrl: widget.backdropimage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),

                        // Gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.35),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),

                        // YouTube player
                        if (isPlaying)
                          YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            bottomActions: const [
                              CurrentPosition(),
                              ProgressBar(
                                isExpanded: true,
                                colors: ProgressBarColors(
                                  playedColor: Colors.white,
                                  handleColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),

                // AppBar
                AppBar(
                  leading: IconButton(
                    enableFeedback: false,
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "Assets/heart.png",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Poster + Movie Info
            MovieInfoSection(
              widget: widget,
              isPlaying: isPlaying,
              onWatchTrailer: toggleTrailer,
            ),

            // Description Section
            DescriptionSection(widget: widget),
          ],
        ),
      ),
    );
  }
}

/// Poster + buttons + rating + genre
class MovieInfoSection extends StatelessWidget {
  final DescriptionPage widget;
  final bool isPlaying;
  final VoidCallback onWatchTrailer;

  const MovieInfoSection({
    super.key,
    required this.widget,
    required this.isPlaying,
    required this.onWatchTrailer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 175,
      child: Row(
        children: [
          // Poster
          Container(
            height: 175,
            width: 114,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: CachedNetworkImageProvider(widget.posterimage),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Info Column
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.title} (${widget.year})",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                // Buttons
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF8700),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Play",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xff131A22,
                        ).withValues(alpha: 0.9),
                      ),
                      onPressed: onWatchTrailer,
                      icon: const Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Watch Trailer",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),

                // Rating + Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rating
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff252836).withValues(alpha: 0.72),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "Assets/star.png",
                            height: 14,
                            width: 14,
                            color: const Color(0xFFFF6E40),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            double.tryParse(
                                  widget.rating,
                                )?.toStringAsFixed(1) ??
                                "0.0",
                            style: const TextStyle(
                              color: Color(0xFFFF6E40),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Download & Share
                    Row(
                      children: [
                        CircleIconButton(
                          iconPath: "Assets/download.png",
                          backgroundColor: const Color(
                            0xff131A22,
                          ).withValues(alpha: 0.9),
                          iconColor: const Color(0xffFF8700),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                        CircleIconButton(
                          iconWidget: const Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                          ),
                          backgroundColor: const Color(
                            0xff131A22,
                          ).withValues(alpha: 0.9),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Description text
class DescriptionSection extends StatelessWidget {
  final DescriptionPage widget;
  const DescriptionSection({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            widget.overview,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Circular IconButton used for download/share
class CircleIconButton extends StatelessWidget {
  final String? iconPath;
  final Widget? iconWidget;
  final Color backgroundColor;
  final Color? iconColor;
  final VoidCallback onPressed;

  const CircleIconButton({
    super.key,
    this.iconPath,
    this.iconWidget,
    required this.backgroundColor,
    this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        icon:
            iconWidget ??
            (iconPath != null
                ? Image.asset(
                    iconPath!,
                    color: iconColor,
                    height: 15,
                    width: 15,
                  )
                : const SizedBox()),
        onPressed: onPressed,
      ),
    );
  }
}
