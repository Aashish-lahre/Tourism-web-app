import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
// import 'package:flutter/rendering.dart';

class MyExpandableContainer extends StatefulWidget {
  @override
  _MyExpandableContainerState createState() => _MyExpandableContainerState();
}

class _MyExpandableContainerState extends State<MyExpandableContainer> {
  // List<Item> _data = generateItems(4);

  final List<Item> _data = [
    Item(
        icon: Icons.location_on_rounded,
        expandedValue: ['Location', 'Create Trip'],
        expandedIcon: [Icons.location_on_rounded, Icons.travel_explore_rounded],
        headerValue: 'Tools'),
    Item(
        icon: Icons.maps_home_work_rounded,
        expandedValue: [
          'Chhattisgarh',
          'Popular Destination',
          'Featured Destionation'
        ],
        expandedIcon: [
          Icons.location_city_rounded,
          Icons.location_searching_rounded,
          Icons.location_searching_rounded,
        ],
        headerValue: 'Views'),
    Item(
        icon: Icons.workspace_premium,
        expandedValue: ['Chat Bot', 'Created by - Ashish lahre'],
        expandedIcon: [Icons.chat, Icons.person],
        headerValue: 'Premium'),
  ];

  @override
  Widget build(BuildContext context) {
    // Listview is to allow Scroll behaviour
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (BuildContext context, int index) {
        Item item = _data[index];
        return Column(
          children: <Widget>[
            // Header
            Container(
              decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.blueGrey, width: 1)),
              ),
              child: ListTile(
                title: Text(item.headerValue),
                leading: Icon(
                  item.icon,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xFF8870c8)
                      : Colors.black,
                ),
                // trailing: IconButton(
                //   icon: Icon(
                //       item.isExpanded ? Icons.expand_less : Icons.expand_more),
                //   onPressed: () {
                //     setState(() {
                //       item.isExpanded = !item.isExpanded;
                //     });
                //   },
                // ),
              ),
            ),

            AnimatedContainer(
              margin: EdgeInsets.symmetric(vertical: 20),
              duration: Duration(milliseconds: 200),
              height: item.isExpanded
                  ? item.expandedValue.length * 56.0
                  : item.expandedValue.length > 2
                      ? 3 * 56.0
                      : 2 * 56.0, // 56.0 is the default height of ListTile
              child: ListView.builder(
                itemCount: item.expandedValue.length > 3
                    ? item.isExpanded
                        ? item.expandedValue.length
                        : 3
                    : item.expandedValue.length,
                itemBuilder: (context, i) => HoverContainer(
                  // decoration: BoxDecoration(
                  //   color: Colors.amber.shade100,
                  // ),
                  hoverDecoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color(0xFF8870c8)
                                  : Colors.black,
                              width: 5),
                          right: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color(0xFF8870c8)
                                  : Colors.black,
                              width: 5))),
                  child: ListTile(
                    // contentPadding: EdgeInsets.symmetric(vertical: 10),
                    leading: Icon(item.expandedIcon[i]),
                    title: Text(item.expandedValue[i]),
                  ),
                ),
                physics:
                    NeverScrollableScrollPhysics(), // to disable scrolling in the ListView
              ),
            ),
          ],
        );
      },
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.expandedIcon,
    required this.headerValue,
    required this.icon,
    this.isExpanded = false,
  });

  List<String> expandedValue;
  List<IconData> expandedIcon;
  IconData icon;
  String headerValue;
  bool isExpanded;
}

// List<Item> generateItems(int numberOfItems) {
//   List<String> headers = ['Tools', 'Views', 'Premium'];

//   return List<Item>.generate(numberOfItems, (int index) {
//     return Item(
//       icon: Icons.location_on_rounded,
//       headerValue: headers[index],
//       expandedValue: [
//         'Item 0',
//         'Item 1',
//         'Item 2',
//         'Item 3',
//         'Item 4',
//         'Item 5'
//       ],
//       // isExpanded: index < 3,
//     );
//   });
// }



// class PanelBody extends StatelessWidget {
//   final Item item;

//   const PanelBody({Key? key, required this.item}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final itemsToShow = item.isExpanded
//         ? item.expandedValue
//         : item.expandedValue.take(3).toList();

//     print(itemsToShow.length);

//     return Column(
//       children:
//           itemsToShow.map((value) => ListTile(title: Text(value))).toList(),
//     );
//   }
// }
