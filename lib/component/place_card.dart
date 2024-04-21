import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tourism_web_app/Provider/dailog.dart';
import 'package:tourism_web_app/Screen/place_details.dart';
import 'package:tourism_web_app/Screen/place_expand.dart';

import '../model/place_model.dart';

class PlaceCard extends StatefulWidget {
  final double width;
  final double height;
  final Place place;
  const PlaceCard(
      {super.key,
      required this.width,
      required this.height,
      required this.place});

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  void showCustomDialog(BuildContext context, double screenwidth,
      double screenheight, Place place) {
    showDialog(
      context: context,
      builder: (BuildContext firstDialogContext) {
        return Dialog(
            // insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ), //this right here
            child: MouseRegion(
              onExit: (event) {
                print('reached here');
                // Navigator.pop(firstDialogContext);

                if (!Provider.of<DialogProvider>(context, listen: false)
                    .isImageCarouselDialogShowing) {
                  Navigator.of(context).pop();
                }
              },
              child: PlaceExpand(
                  first_context: context,
                  width: screenwidth * .5,
                  height: screenheight * .75,
                  place: widget.place),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    Timer? _timer;

    // Card
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => PlaceDetails(place: widget.place))),
      child: Container(
        // padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // color: Colors.teal.shade100,

          // Image
          image: DecorationImage(
              // opacity: 1,

              image: CachedNetworkImageProvider(widget.place.headImage[0],
                  maxWidth: widget.width.toInt()),
              fit: BoxFit.cover),
        ),
        width: widget.width,
        height: widget.height,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black45])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Card uper Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: widget.width * .3,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MouseRegion(
                            // cursor: ,
                            onEnter: (event) {
                              _timer = Timer(const Duration(seconds: 1), () {
                                showCustomDialog(context, screenwidth,
                                    screenheight, widget.place);
                              });
                            },
                            onExit: (event) {
                              if (_timer != null) {
                                _timer!.cancel();
                              }
                            },

                            // FullScreen Icon
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.fullscreen_outlined)),
                          ),

                          SizedBox(
                            width: 15,
                          ),

                          // Bookmark Icon
                          IconButton(
                              onPressed: () {}, // ignore this function
                              icon: const Icon(Icons.bookmark_add_outlined))
                        ]),
                  ),

                  // Favorite Icon
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline)),
                  )
                ],
              ),

              // Card lower details
              Container(
                height: widget.height * .2,
                // color: Colors.green,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Place Name
                      Text(
                        widget.place.name,
                        // ignore: prefer_const_constructors
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // State Icon and State
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.place.stateName ?? "Unknown",
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          ),

                          // Rating Icon and Rating
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_purple500_sharp,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.place.rating.toStringAsFixed(1),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
