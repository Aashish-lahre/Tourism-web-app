import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_web_app/Provider/dailog.dart';
import 'package:tourism_web_app/model/place_model.dart';

class PlaceExpand extends StatefulWidget {
  final BuildContext first_context;
  final double width;
  final double height;
  final Place place;
  const PlaceExpand(
      {super.key,
      required this.first_context,
      required this.width,
      required this.height,
      required this.place});

  @override
  State<PlaceExpand> createState() => _PlaceExpandState();
}

class _PlaceExpandState extends State<PlaceExpand> {
  bool descriptionExpand = false;
  bool whyTravelExpand = false;
  final carouselController = CarouselController();
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mainImage = widget.place.headImage[0];
  }

  late String mainImage;

  void showImageCarousel(
    ctx,
    Place place,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          Provider.of<DialogProvider>(ctx, listen: false)
              .updateImageCarouselDialogShowingStatus();
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: Colors.black45,
            child: Container(
              // alignment: Alignment.center,
              color: Colors.black45,
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.height * .8,
              child: Stack(
                children: [
                  CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: place.media['gallery']!.length,
                      itemBuilder: (ctx, index, _) {
                        return Container(
                          child: Image.network(place.media['gallery']![index]),
                        );
                      },
                      options: CarouselOptions()),
                  Positioned(
                    left: 30,
                    top: MediaQuery.of(context).size.height * .4,
                    child: IconButton.filled(
                        // color: Colors.black,
                        onPressed: () => carouselController.previousPage(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                  Positioned(
                    right: 30,
                    top: MediaQuery.of(context).size.height * .4,
                    child: IconButton.filled(
                        // color: Colors.black,
                        onPressed: () => carouselController.nextPage(),
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          );
        }).then((value) => Provider.of<DialogProvider>(ctx,
            listen: false)
        .updateImageCarouselDialogShowingStatus());
  }

  @override
  Widget build(BuildContext buildContext) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 8),
      child: Row(
        children: [
          // Left Container - Images
          Container(
            width: widget.width * .55,
            height: widget.height,
            color: Colors.grey.shade200,
            child: Column(children: [
              // MAIN Big Image
              Container(
                alignment: Alignment.bottomRight,
                height: widget.height * .6,
                decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(mainImage,
                            errorListener: (p0) =>
                                print('errror --> ${p0.toString()}'),
                            maxWidth: widget.width.toInt()),
                        fit: BoxFit.cover)),
                child: FloatingActionButton(
                  backgroundColor: Colors.black38,
                  onPressed: () {
                    showImageCarousel(widget.first_context, widget.place);
                    // print('reached');
                  },
                  child: const Icon(
                    Icons.expand_circle_down,
                    color: Colors.white,
                  ),
                ),
              ),

              // Gallery Grid
              Container(
                height: widget.height * .4,
                color: Theme.of(context).primaryColor,
                child: GridView.builder(
                    itemCount: widget.place.media['gallery']!.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / 1.7),
                    itemBuilder: (_, index) {
                      return MouseRegion(
                        onEnter: (_) {
                          _timer = Timer(const Duration(milliseconds: 700), () {
                            setState(() {
                              mainImage = widget.place.media['gallery']![index];
                            });
                          });
                        },
                        onExit: (_) {
                          if (_timer != null) {
                            _timer!.cancel();
                          }
                        },

                        // Small Image
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          // width: ((widget.width * .6) / 2),
                          decoration: BoxDecoration(
                              color: Colors.blue, // Set color as needed
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                // BoxShadow(
                                //     color: Colors.white,
                                //     offset: Offset(-2, -6),
                                //     blurRadius: 10,
                                //     spreadRadius: 2),
                                BoxShadow(
                                    color: Colors.blueGrey.shade200,
                                    offset: Offset(2, 3),
                                    blurRadius: 2,
                                    spreadRadius: 2),
                              ],
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      widget.place.media['gallery']![index],
                                      errorListener: (p0) =>
                                          print('errror --> ${p0.toString()}'),
                                      maxWidth: widget.width.toInt()),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    }),
              ),
            ]),
          ),

          // Right Container -
          Container(
            padding: const EdgeInsets.all(8),
            width: widget.width * .45,
            height: widget.height,
            color: Theme.of(context).brightness == Brightness.dark
                ? Color(0xFF181828)
                : Colors.white,
            child: ListView(
              children: [
                // Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.place.name,
                      style: const TextStyle(
                          fontSize: 50, fontWeight: FontWeight.w700),
                    )
                  ],
                ),

                // State
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(Icons.location_on_rounded),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(widget.place.stateName ?? widget.place.country!),
                  ],
                ),

                // Description
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final style = Theme.of(context).textTheme;
                    final textSpan = TextSpan(
                      text: widget.place.facts.values.toList()[0],
                      style: style.bodyMedium,
                    );
                    final textPainter = TextPainter(
                      text: textSpan,
                      textDirection: TextDirection.ltr,
                      maxLines: (descriptionExpand) ? 7 : 4,
                    );
                    textPainter.layout(maxWidth: constraints.maxWidth);

                    final exceeded = textPainter.didExceedMaxLines;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      // color: Colors.teal.shade200,
                      height: descriptionExpand
                          ? widget.height * .3
                          : widget.height * .21,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.place.facts.values.toList()[0],
                              maxLines: (descriptionExpand) ? 7 : 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (exceeded || descriptionExpand)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    descriptionExpand = !descriptionExpand;
                                  });
                                },
                                child: Text(descriptionExpand
                                    ? 'View less'
                                    : 'View all'),
                              ),
                          ],
                        ),
                      ),
                      // RichText(text: ))
                    );
                  },
                ),

                // Why Travel

                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final style = Theme.of(context).textTheme;
                    final textSpan = TextSpan(
                      text: widget.place.facts.values.toList()[0],
                      style: style.bodyMedium,
                    );
                    final textPainter = TextPainter(
                      text: textSpan,
                      textDirection: TextDirection.ltr,
                      maxLines: (whyTravelExpand) ? 7 : 4,
                    );
                    textPainter.layout(maxWidth: constraints.maxWidth);

                    final exceeded = textPainter.didExceedMaxLines;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      // color: Colors.teal.shade200,
                      height: whyTravelExpand
                          ? widget.height * .3
                          : widget.height * .21,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.place.facts.values.toList()[0],
                              maxLines: (whyTravelExpand) ? 7 : 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (exceeded || whyTravelExpand)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    whyTravelExpand = !whyTravelExpand;
                                  });
                                },
                                child: Text(
                                    whyTravelExpand ? 'View less' : 'View all'),
                              ),
                          ],
                        ),
                      ),
                      // RichText(text: ))
                    );
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_outlined,
                          color: Colors.pink,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.bookmark_add,
                          color: Colors.green,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.star_purple500_sharp,
                          color: Colors.amber,
                        )),
                    const Text('4.5'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
