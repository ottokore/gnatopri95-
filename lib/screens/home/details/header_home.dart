import 'package:flutter/material.dart';

class HeaderHome extends StatefulWidget {
  const HeaderHome({super.key, required this.onMenuTap});

  final VoidCallback onMenuTap;

  @override
  _HeaderHomeState createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
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
                  onTap: widget.onMenuTap, // Appeler la fonction onMenuTap
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(Icons.menu, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/logo.png', height: 23),
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