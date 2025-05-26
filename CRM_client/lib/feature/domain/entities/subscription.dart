class Subscription{
  final String id;
  final String title;
  final String? description;
  final double price;
  final DateTime expirationDate;
  final DateTime startDate;

  Subscription({required this.id, required this.title, required this.price, required this.description, required this.expirationDate, required this.startDate});

}