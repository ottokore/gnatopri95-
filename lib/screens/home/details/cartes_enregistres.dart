import 'package:dassi/screens/home/details/saved_cards_model.dart';
import 'package:flutter/material.dart';

class CartesEnregistres extends StatefulWidget {
  const CartesEnregistres({super.key});

  @override
  State<CartesEnregistres> createState() => _CartesEnregistresState();
}

class _CartesEnregistresState extends State<CartesEnregistres> {
  final List<SavedCards> cartes = SavedCards.cartes; // Correction ici

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 220,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) => GestureDetector(
                onTap: () {
                  // mettre l'action ici
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(cartes[index].bgCard),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                                children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(cartes[index].bank, style: 
                                          const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset(cartes[index].cardChip, height: 30,),
                                      ],
                                    ),
                                    Text(cartes[index].cardNumber, style: 
                                      const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "cardFont",
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Expiry", style: 
                                              TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(cartes[index].expiryDate, style: 
                                              const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "cardFont",
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 90.0,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("CVV", style: 
                                              TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(cartes[index].cvv, style: 
                                              const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "cardFont",
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(cartes[index].cardType, height: 26,),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )               
                ),
              )),
          separatorBuilder: ((context, index) => const SizedBox(width: 8)),
          itemCount: cartes.length,
        ),
      ),
    );
  }
}