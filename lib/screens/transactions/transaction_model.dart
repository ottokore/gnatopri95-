class TransactionModel {
  final String title;
  final String date;
  final String recipient;
  final double amount;

  TransactionModel({
    required this.title,
    required this.date,
    required this.recipient,
    required this.amount,
  });
}