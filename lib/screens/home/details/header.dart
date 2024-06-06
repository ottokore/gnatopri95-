import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class HeaderScreen extends StatefulWidget {
  final GlobalKey<SliderDrawerState> drawerKey;
  const HeaderScreen({super.key, required this.drawerKey});

  @override
  // ignore: library_private_types_in_public_api
  _HeaderScreenState createState() => _HeaderScreenState();
}

class _HeaderScreenState extends State<HeaderScreen> {
  final GlobalKey<SliderDrawerState> _drawerKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    _drawerKey.currentState?.toggle();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(Icons.menu, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/logo.png', height: 23,),
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              child: const Icon(
                Icons.support_agent,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}