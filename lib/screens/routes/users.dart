
class User {
  final String name;
  final String firstName;
  final String imageUrl;

  User({
    required this.name,
    required this.firstName,
    required this.imageUrl,
  });
}

final List<User> users = [
  User(
    name: 'Oblé',
    firstName: 'Achile',
    imageUrl: "assets/images/avatar1.png",
  ),
  User(
    name: 'Coulibaly',
    firstName: 'Issouf',
    imageUrl: 'assets/images/avatar2.png',
  ),
  User(
    name: 'Konan',
    firstName: 'Raphael',
    imageUrl: 'assets/images/avatar3.png',
  ),
  User(
    name: 'Kounso',
    firstName: 'Patrice',
    imageUrl: 'assets/images/avatar4.png',
  ),
  User(
    name: 'Zokou',
    firstName: 'John',
    imageUrl: 'assets/images/avatar5.png',
  ),
  User(
    name: 'Tiéné',
    firstName: 'Aboubacar',
    imageUrl: 'assets/images/avatar6.png',
  ),
  User(
    name: 'Gnahoré',
    firstName: 'Arnaud',
    imageUrl: 'assets/images/avatar7.png',
  ),
  // Ajoutez d'autres utilisateurs ici
];

class TransferMethod {
  final String name;
  final String sendingImageUrl;
  final String receivingImageUrl;
  final String sendingImageUrlWhite;
  final String receivingImageUrlWhite;
  final String feesText;

  TransferMethod({
    required this.name,
    required this.sendingImageUrl,
    required this.receivingImageUrl,
    required this.sendingImageUrlWhite,
    required this.receivingImageUrlWhite,
    required this.feesText,
  });
}

final List<TransferMethod> transferMethods = [
  TransferMethod(
    name: 'Dassi vers Orange',
    sendingImageUrl: 'assets/images/dassi_wallet.png',
    receivingImageUrl: 'assets/images/orange_money.png',
    sendingImageUrlWhite: 'assets/images/dassi_wallet_white.png',
    receivingImageUrlWhite: 'assets/images/orange_money_white.png',
    feesText: "Des frais de 1% s'appliquent",
  ),
  TransferMethod(
    name: 'Orange vers MTN',
    sendingImageUrl: 'assets/images/orange_money.png',
    receivingImageUrl: 'assets/images/mtn_money.png',
    sendingImageUrlWhite: 'assets/images/orange_money_white.png',
    receivingImageUrlWhite: 'assets/images/mtn_money_white.png',
    feesText: "Des frais de 2% s'appliquent",
  ),
  TransferMethod(
    name: 'Orange vers Moov',
    sendingImageUrl: 'assets/images/orange_money.png',
    receivingImageUrl: 'assets/images/moov_money.png',
    sendingImageUrlWhite: 'assets/images/orange_money_white.png',
    receivingImageUrlWhite: 'assets/images/moov_money_white.png',
    feesText: "Des frais de 2% s'appliquent",
  ),
  TransferMethod(
    name: 'Orange vers Wave',
    sendingImageUrl: 'assets/images/orange_money.png',
    receivingImageUrl: 'assets/images/wave.png',
    sendingImageUrlWhite: 'assets/images/orange_money_white.png',
    receivingImageUrlWhite: 'assets/images/wave_white.png',
    feesText: "Des frais de 2% s'appliquent",
  ),
];