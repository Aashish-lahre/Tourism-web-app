import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tourism_web_app/Provider/dailog.dart';
import 'package:tourism_web_app/Provider/state_provider.dart';
import 'package:tourism_web_app/Provider/theme.dart';
import 'package:tourism_web_app/component/place_card.dart';
// import 'package:tourism_web_app/component/search_field.dart';
import 'package:tourism_web_app/component/tools.dart';
// import 'package:tourism_web_app/component/tools.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// web       1:922344240132:web:9853d636344f18a9077151
// android   1:922344240132:android:c987c3d3404ecf68077151
class _HomeScreenState extends State<HomeScreen> {
  // bool _isDark = false;
  // String animatedValue = 'Light';
  // bool _data = false;
  var state = StateProvider().getdata();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final toggleTheme = Provider.of<ThemeProvider>(context).toggleTheme;
    bool isDark = Provider.of<ThemeProvider>(context).isDark();
    final viewList =
        Provider.of<StateProvider>(context).fetchPlaceByHighRating();
    // final viewList = Provider.of<StateProvider>(context).viewList;

    // print(viewList);

    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        toolbarHeight: height * .17,
        backgroundColor: Theme.of(context).primaryColor,
        title: Container(
          // color: Colors.brown,
          height: height * .17,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Section 1 - placeholder, theme toggle
              Container(
                width: width * .3,
                // color: Colors.teal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    // Placeholder..
                    Container(
                      width: width * .2,
                      // color: Colors.pink,
                      child: Row(children: [
                        Icon(
                          Icons.water_drop_rounded,
                          size: 40,
                        ),
                        Text('Travello',
                            style: TextStyle(
                                fontFamily: 'LobsterTwo', fontSize: 60)),
                      ]),
                    ),
                    // SizedBox(
                    //   width: width * .1,
                    //   child: Switch(
                    //       value: _isDark,
                    //       onChanged: (value) {
                    //         // setState(() {
                    //         //   _isDark = value;
                    //         // });
                    //       }),
                    // ),

                    // Toggle....
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        // color: Colors.blue,
                        width: 60,
                        // height: height * .17,
                        child: AnimatedToggleSwitch.dual(
                          current: isDark,
                          first: false,
                          second: true,
                          spacing: 0.0,
                          style: const ToggleStyle(
                            borderColor: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1.5),
                              ),
                            ],
                            // borderRadius:
                            //     BorderRadius.all(Radius.elliptical(10, 10))
                          ),
                          borderWidth: 5.0,
                          height: 35,
                          // false to true || true to false --> newbool
                          onChanged: (newbool) => setState(() {
                            // _isDark = value;
                            toggleTheme(newbool);
                          }),
                          styleBuilder: (b) => ToggleStyle(
                            backgroundColor: b
                                ? const Color.fromARGB(255, 69, 69, 69)
                                : const Color.fromARGB(255, 69, 68, 68),
                            indicatorColor: b
                                ? const Color.fromARGB(255, 39, 39, 74)
                                : Colors.white,
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(50.0),
                                right: Radius.circular(50.0)),
                            indicatorBorderRadius: BorderRadius.circular(50.0),
                          ),
                          iconBuilder: (value) => value
                              ? const Icon(
                                  Icons.dark_mode,
                                  color: Colors.blueGrey,
                                )
                              : const Icon(
                                  Icons.light_mode,
                                  color: Colors.yellow,
                                ),

                          // textBuilder: (value) => value
                          //     ? Center(child: Text('Dark'))
                          //     : Center(child: Text('Light')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Section 2 - Search, notification

              // Container(
              //   width: width * .5,
              //   padding: EdgeInsets.only(top: (height * .17) * 0.3),
              //   // color: Colors.lightBlue,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       SearchField(width: width),
              //       const SizedBox(
              //         width: 0.3,
              //       ),

              //       // Notification
              //       // IconButton(
              //       //     onPressed: () {}, icon: const Icon(Icons.notifications))
              //     ],
              //   ),
              // ),

              // Section 3 - Profile
              // const Padding(
              //   padding: EdgeInsets.only(right: 30),
              //   child: CircleAvatar(
              //     radius: 28,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          // Left side of the screen
          Container(
            width: width * .13,
            height: height - (height * .17),
            // color: const Color.fromARGB(255, 203, 157, 172),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border(
                  right: BorderSide(color: Colors.blueGrey.shade200, width: 1)),
            ),

            child: MyExpandableContainer(),
          ),

          // Right side of the screen
          Container(
            height: height - (height * .17),
            width: width - (width * .13),
            child: FutureBuilder(
              future: viewList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Center(child: Text(snapshot.data.toString()));
                }
                if (snapshot.hasError) {
                  // print(snapshot.data!);
                  return Center(
                      child: Text(
                    snapshot.error.toString(),
                  ));
                }

                if (snapshot.hasData) {
                  List<DestinationModel> destination = snapshot.data!;

                  // Animated Container
                  return ListView.builder(
                      itemCount: destination.length,
                      itemBuilder: (BuildContext context, index) {
                        return Align(
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            margin: const EdgeInsets.symmetric(vertical: 30),
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                            duration: const Duration(milliseconds: 300),
                            width: (width - (width * .13)) * .98,
                            height: destination[index].isExpanded
                                ? (height - (height * .17)) * .9
                                : (height - (height * .17)) * .7,
                            decoration: BoxDecoration(
                              // color: Colors.amber.shade100,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color(0xFF8870c8).withOpacity(1)
                                  : Theme.of(context).primaryColor,
                              // border: Border.all(
                              //     // color: Theme.of(context).primaryColorDark,
                              //     width: 2),

                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                //  Destination Title and Medium view and Expand/Collapse Button
                                Row(
                                  children: [
                                    // Destination Title
                                    Text(
                                      destination[index].name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),

                                    // Expand BUTTON

                                    // IgnorePointer(
                                    //   ignoring:
                                    //       destination[index].expandDisabled,
                                    //   child: IconButton(
                                    //     onPressed: () =>
                                    //         Provider.of<StateProvider>(context,
                                    //                 listen: false)
                                    //             .changeExpandState(
                                    //                 destination[index]),
                                    //     icon: destination[index].isExpanded
                                    //         ? const Icon(
                                    //             Icons.expand_less_outlined,
                                    //             size: 25,
                                    //           )
                                    //         : const Icon(
                                    //             Icons.expand_more_outlined,
                                    //             size: 25,
                                    //           ),
                                    //     style: const ButtonStyle(),
                                    //   ),
                                    // )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                // Near me, Budget, Filter Button
                                Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        // width: 100,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Near Me',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Budget',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      SizedBox(width: 20),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Filter',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ]),
                                const SizedBox(
                                  height: 10,
                                ),

                                // Place Cards

                                Container(
                                  height:
                                      ((height - (height * .17)) * .7) * .69,
                                  width: (width - (width * .13)) * .98,
                                  child: ListView.builder(
                                      itemCount:
                                          destination[index].places.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, placeIndex) {
                                        return ChangeNotifierProvider(
                                          create: (context) => DialogProvider(),
                                          child: PlaceCard(
                                            width: (((width - (width * .13)) *
                                                        .98) /
                                                    3) -
                                                30,
                                            height: ((height - (height * .17)) *
                                                    .7) *
                                                .76,
                                            place: destination[index]
                                                .places[placeIndex],
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }

                return const Center(child: Text('Something\'s Wrong 2'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
