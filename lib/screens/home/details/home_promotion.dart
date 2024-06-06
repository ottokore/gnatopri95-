import 'package:flutter/material.dart';

class HomePromotion extends StatelessWidget {
const HomePromotion({ super.key });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(
        top: 12, bottom: 90, left: 16, right: 16,
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset('assets/images/ads.jpg',),
            ),
          ),
          const Positioned(
            left: 25,
            top: 35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Carte virtuelle à",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "1000",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold
                          ),
                        ),      
                      ],
                    ),
                    SizedBox(width: 8,),
                    Column(
                      children: [
                        Text(
                          "Fcfa",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 15
                          ),
                        )
                      ],
                    )
                  ],
                ),
                
                Text(
                  "Pratique et sécurisée",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}