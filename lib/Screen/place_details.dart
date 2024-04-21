import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tourism_web_app/component/tools.dart';
import 'package:tourism_web_app/model/place_model.dart';

class PlaceDetails extends StatefulWidget {
  final Place place;
  const PlaceDetails({super.key, required this.place});

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bigImageUrl = widget.place.media['gallery']![0];
  }

  late String bigImageUrl;
  int customIndex = 0;

  final carouselController = CarouselController();
  bool endOfCarousel = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bodyHeight = screenHeight - (screenHeight * .2);
    final bodyWidth = screenWidth - (screenWidth * .13);

    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF263238)
          : Theme.of(context).primaryColor,
      appBar: AppBar(
        // backgroundColor: Colors.cyan,
        leading: IconButton(
            hoverColor: Colors.transparent,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back)),
        toolbarHeight: screenHeight * .2,
        title: Row(
          children: [
            Container(
              width: screenWidth * .2,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: (screenHeight * .2) * .8,
              // color: Colors.blueGrey,
              child: const Row(children: [
                Icon(
                  Icons.water_drop_rounded,
                  size: 40,
                ),
                Text('Travello',
                    style: TextStyle(fontFamily: 'LobsterTwo', fontSize: 60)),
              ]),
            ),
            // Text('Explore ${widget.place.name}',
            //     style: TextStyle(fontFamily: 'LobsterTwo', fontSize: 30))
          ],
        ),
      ),
      body: Row(
        children: [
          // Left - Container

          Container(
            width: screenWidth * .13,
            height: bodyHeight,
            decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(color: Colors.blueGrey, width: 1)),
            ),
            // color: const Color.fromARGB(255, 203, 157, 172),
            child: MyExpandableContainer(),
          ),

          // Right - Container
          Container(
            width: screenWidth * .87,
            height: bodyHeight,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Container
                  Container(
                    width: (screenWidth * .87) * .9,
                    height: bodyHeight * .8,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      // color: const Color.fromARGB(255, 179, 154, 246),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        // Big Image
                        Flexible(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.blueAccent,
                                image: DecorationImage(
                                    image: NetworkImage(bigImageUrl),
                                    fit: BoxFit.contain)),
                          ),
                        ),

                        // Carousel
                        Flexible(
                          flex: 2,
                          child: Container(
                              height: bodyHeight * .8,
                              // alignment: Alignment.bottomCenter,
                              // color: Colors.lightGreen,
                              child: Stack(
                                children: [
                                  CarouselSlider.builder(
                                    carouselController: carouselController,
                                    itemCount:
                                        widget.place.media['gallery']!.length,
                                    itemBuilder: (ctx, index, _) {
                                      // customIndex += 1;
                                      return GestureDetector(
                                        onTap: () => setState(() {
                                          bigImageUrl = widget
                                              .place.media['gallery']![index];
                                        }),
                                        child: Container(
                                          height: (bodyHeight * .8) * .45,
                                          decoration: BoxDecoration(
                                              // color: Colors.tealAccent,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFF8870C8),
                                                  width: 3),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      widget.place.media[
                                                          'gallery']![index]))),
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: bodyHeight * .8,
                                      initialPage: 1,
                                      enableInfiniteScroll: false,
                                      scrollDirection: Axis.vertical,
                                      viewportFraction: 0.5,
                                      onPageChanged: (index, reason) {
                                        if (index ==
                                            widget.place.media['gallery']!
                                                    .length -
                                                1) {
                                          endOfCarousel = true;
                                        } else {
                                          endOfCarousel = false;
                                        }
                                      },
                                    ),
                                  ),

                                  //  Button to scroll Carousel down
                                  Positioned(
                                      bottom: 30,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: IconButton.filled(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            if (endOfCarousel) {
                                              // customIndex = 0;
                                              carouselController.animateToPage(
                                                0,
                                                duration: const Duration(
                                                    milliseconds: 800),
                                                curve: Curves.easeInOut,
                                              );
                                            } else {
                                              carouselController.nextPage();
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.arrow_downward,
                                            color: Colors.white,
                                          ),
                                          color: Colors.black,
                                        ),
                                      )),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    ' Welcome to ${widget.place.name}',
                    style: const TextStyle(
                        fontFamily: 'LobsterTwo',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),

                  LayoutBuilder(builder: (context, constraint) {
                    if (constraint.maxWidth > 600) {
                      return Row(
                        children: [
                          Flexible(
                            flex: 5,
                            child: Container(
                                // width: bodyWidth * .5,
                                // color: Colors.amber,
                                child: Column(
                                    children: widget.place.facts.values
                                        .map((fact) => Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Text(
                                                fact,
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ))
                                        .toList())),
                          ),
                          Flexible(
                            flex: 2,
                            child: SizedBox(
                              // width: bodyWidth * .3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton.filled(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.pink,
                                      )),
                                  IconButton.filled(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.bookmark_add,
                                        color: Colors.green,
                                      )),
                                  const SizedBox(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 20,
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('4.5')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            width: bodyWidth * .5,
                            child: const Text('''

The step well is a well having steps on all sides and fetch water.  It is usually found in the courtyard of houses or palaces. 
The step well is a well having steps on all sides and fetch water.  It is usually found in the courtyard of houses or palaces. 
The step well is a well having steps on all sides and fetch water.  It is usually found in the courtyard of houses or palaces. 
The step well is a well having steps on all sides and fetch water.  It is usually found in the courtyard of houses or palaces. 
The step well is a well having steps on all sides and fetch water.  It is usually found in the courtyard of houses or palaces. 
The step well is a well having steps on all sides and fetch water.  It is usually found in the courtyard of houses or palaces. 
The step well is a well having steps on all sides and fetch water.  It is usually found in the courtyard of houses or palaces. 
The step well is a well having steps on all sides and fetch water.  It is usually found in the courtyard of houses or palaces. 
The step well is a well having steps on all sides and fetch water.  It is usually found in the courtyard of houses or palaces. 
The step well is a well having steps on all sides and fetch water.  It is usually found in the courtyard of houses or palaces. 
The step well is a well having steps on all sides and fetch water.  It is usually found in the courtyard of houses or palaces. 

'''),
                          ),
                          SizedBox(
                            width: bodyWidth * .3,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.favorite)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.favorite)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.favorite)),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
