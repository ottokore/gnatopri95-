class SavedCards {
  final String bgCard;
  final String bank;
  final String cardType;
  final String cardChip;
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  SavedCards({
    required this.bgCard,
    required this.bank,
    required this.cardType,
    required this.cardChip,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
  });

  static List<SavedCards> cartes = [
    SavedCards(
      bgCard: 'assets/images/frontCard.png',
      bank: 'Dassi',
      cardType: 'assets/images/visa_white.png',
      cardChip: 'assets/images/chip.png',
      cardNumber: '****  ****  ****  5473',
      expiryDate: '03/28',
      cvv: '473',
    ),
    SavedCards(
      bgCard: 'assets/images/frontCard.png',
      bank: 'BNI',
      cardType: 'assets/images/mastercard.png',
      cardChip: 'assets/images/chip.png',
      cardNumber: '****  ****  ****  0691',
      expiryDate: '11/27',
      cvv: '178',
    ),
    SavedCards(
      bgCard: 'assets/images/frontCard.png',
      bank: 'ECOBANK',
      cardType: 'assets/images/mastercard.png',
      cardChip: 'assets/images/chip.png',
      cardNumber: '****  ****  ****  4607',
      expiryDate: '07/25',
      cvv: '908',
    ),
  ];
}