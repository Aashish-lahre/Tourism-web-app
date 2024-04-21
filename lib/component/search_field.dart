import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final double width;
  const SearchField({super.key, required this.width});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  Color _color = Colors.purple;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: widget.width * 0.4,
      decoration: BoxDecoration(
        // color: Colors.grey[200],
        color: Theme.of(context).inputDecorationTheme.fillColor,

        borderRadius: BorderRadius.circular(10),
      ),

      // Search field, Remove text
      child: Row(
        children: [
          // search field
          Container(
            width: widget.width * .35,
            // margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          ),

          //Remove text
          Expanded(
            child: MouseRegion(
              onEnter: (event) {
                setState(() {
                  _color = Colors.deepPurple.withOpacity(
                      0.5); // Change color to a more transparent version when mouse enters
                });
              },
              onExit: (event) {
                setState(() {
                  _color =
                      Colors.deepPurple; // Change color back when mouse exits
                });
              },
              // onHover: (event) => print(
              //     'Mouse is hovering over the widget at ${event.position}'),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 30,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
