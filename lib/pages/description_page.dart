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
      initialVideoId: videoId ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
        controlsVisibleAtStart: false,
        hideControls: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // ✅ release controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AnimatedContainer(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Stack(
                          children: [
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 400),
                              opacity: isPlaying ? 0 : 1,
                              child: CachedNetworkImage(
                                imageUrl: widget.backdropimage,
                                fadeInCurve: Curves.easeInOut,
                                fadeInDuration: const Duration(
                                  milliseconds: 200,
                                ),
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

                            // YouTube Player
                            isPlaying
                                ? YoutubePlayer(
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
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    AppBar(
                      leading: IconButton(
                        enableFeedback: false,
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      titleSpacing: 50,
                      elevation: 0,
                      actions: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastEaseInToSlowEaseOut,
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: IconButton(
                              onPressed: () {},
                              icon: const SizedBox(
                                height: 20,
                                width: 20,
                                child: Image(
                                  image: AssetImage("Assets/heart.png"),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 175,
                  child: Row(
                    children: [
                      Container(
                        height: 175,
                        width: 114,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              widget.posterimage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20, left: 20),
                              child: Text(
                                "${widget.title} (${widget.year})",
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      splashFactory: NoSplash.splashFactory,
                                      backgroundColor:
                                          const WidgetStatePropertyAll(
                                            Color(0xffFF8700),
                                          ),
                                    ),
                                    onPressed: () {},
                                    child: const Row(
                                      children: [
                                        Icon(
                                          size: 25,
                                          Icons.play_arrow_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Play",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        const Color(
                                          0xff131A22,
                                        ).withValues(alpha: 0.9),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (!mounted) return;
                                      setState(() {
                                        isPlaying = !isPlaying;
                                      });
                                      if (mounted) {
                                        isPlaying
                                            ? _controller.play()
                                            : _controller.pause();
                                      }
                                      log(isPlaying.toString());
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          size: 25,
                                          Icons.play_arrow_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Watch Trailer",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 260,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      width: 50,
                                      height: 34,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xff252836,
                                        ).withValues(alpha: 0.72),
                                        borderRadius: BorderRadius.circular(12),
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
                                  ),
                                  SizedBox(
                                    width: 128,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: const Color(
                                              0xff131A22,
                                            ).withValues(alpha: 0.9),
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: SizedBox(
                                              child: Image.asset(
                                                "Assets/download.png",
                                                height: 15,
                                                width: 15,
                                                color: const Color(0xffFF8700),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: const Color(
                                              0xff131A22,
                                            ).withValues(alpha: 0.9),
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                          child: IconButton(
                                            iconSize: 18,
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.share_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.releaseDate,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color:
                              Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.grey.shade600,
                        height: 18,
                        width: .5,
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.timer_outlined,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${widget.time} min",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color:
                              Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.grey.shade600,
                        height: 18,
                        width: .5,
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.movie,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.genre,
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.overview,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
