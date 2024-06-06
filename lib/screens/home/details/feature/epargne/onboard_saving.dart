import 'package:dassi/screens/home/details/feature/epargne/epargne.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardSaving extends StatefulWidget {
  const OnboardSaving({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardSavingState createState() => _OnboardSavingState();
}

class _OnboardSavingState extends State<OnboardSaving> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/images/img1.png',
      'title': "Simplifiez Votre Avenir Financier",
      'description': "Épargnez facilement avec des outils intuitifs et des conseils personnalisés.",
    },
    {
      'image': 'assets/images/img2.png',
      'title': "Atteignez Vos Rêves Financiers",
      'description': "Planifiez et réalisez vos objectifs grâce à une épargne intelligente.",
    },
    {
      'image': 'assets/images/img3.png',
      'title': "Votre Épargne au Quotidien",
      'description': "Transformez de petites actions en grandes économies avec des astuces pratiques.",
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return _buildPage(_pages[index]);
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: _pages.length,
            effect: const ExpandingDotsEffect(
              activeDotColor: secondaryColor,
              dotColor: Colors.grey,
              dotHeight: 10,
              dotWidth: 10,
              spacing: 10,
            ),
          ),
          const SizedBox(height: 16),
          _currentPage < _pages.length - 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const Epargne(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child){
                            var begin = const Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var tween = Tween(begin: begin, end: end);
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                              );
                          }
                          )               
                        );
                      },
                      child: const Text('Sauter', style: TextStyle(
                        color: Colors.black
                      ),),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor, // Utilisation de la couleur secondaryColor
                        foregroundColor: Colors.white, // Police en blanc
                      ),
                      child: const Text('Suivant', style: TextStyle(fontSize: 16.0),),
                    ),
                  ],
                )
              : Center(
                  child: ElevatedButton(
                    onPressed: () {
                        Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const Epargne(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child){
                            var begin = const Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var tween = Tween(begin: begin, end: end);
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                              );
                          }
                          )               
                        );
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor, // Utilisation de la couleur secondaryColor
                      foregroundColor: Colors.white, // Police en blanc
                    ),
                    child: const Text('Ok je me lance', style: TextStyle(fontSize: 16.0),),
                  ),
                ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPage(Map<String, String> page) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(page['image']!),
          const SizedBox(height: 16),
          Text(
            page['title']!,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              page['description']!,
              style: const TextStyle(fontSize: 17, color: descColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class EpargneScreen extends StatelessWidget {
  const EpargneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Écran d\'épargne'),
      ),
      body: const Center(
        child: Text('Bienvenue sur l\'écran d\'épargne'),
      ),
    );
  }
}