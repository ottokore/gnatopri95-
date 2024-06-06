import 'package:dassi/screens/welcome.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dassi/utils/utils.dart';
import 'package:dassi/onboard/onboard_model.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnBordInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    
    Color textColor = currentIndex % 2 == 0 ? kwhiteColor : primaryColor;
    Color backgroundColor = currentIndex % 2 == 0 ? primaryColor : kwhiteColor;

    return Scaffold(
      backgroundColor: textColor,
      appBar: AppBar(
        backgroundColor: textColor,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              await _storeOnBordInfo();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
            },
            child: Text(
              "Ignorer",
              style: TextStyle(
                color: currentIndex % 2 == 0 ? primaryColor : kwhiteColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
          itemCount: screens.length,
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(screens[index].img),
                SizedBox(
                  height: 10.0,
                  child: ListView.builder(
                    itemCount: screens.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3.0),
                            width: currentIndex == index ? 25.0 : 8.0,
                            height: 8,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  screens[index].text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: currentIndex % 2 == 0 ? primaryColor : kwhiteColor,
                  ),
                ),
                Text(
                  screens[index].desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: currentIndex % 2 == 0 ? descColor : kwhiteColor,
                  ),
                ),
                if (index == screens.length - 1)
                  InkWell(
                    onTap: () async {
                      await _storeOnBordInfo();
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0,),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(" C'est parti !", style: TextStyle(fontSize: 16.0, color: textColor, fontWeight: FontWeight.w500)),
                          const SizedBox(width: 15.0,),
                          Icon(Icons.arrow_forward_sharp, color: currentIndex % 2 == 0 ? kwhiteColor : primaryColor,),
                        ],
                      ),
                    ),
                  ),
                if (index != screens.length - 1)
                  InkWell(
                    onTap: () async {
                      _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0,),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Suivant", style: TextStyle(fontSize: 16.0, color: textColor, fontWeight: FontWeight.w500)),
                          const SizedBox(width: 15.0,),
                          Icon(Icons.arrow_forward_sharp, color: currentIndex % 2 == 0 ? kwhiteColor : primaryColor,),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

}
