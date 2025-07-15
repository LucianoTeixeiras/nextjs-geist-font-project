class Expense {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String? description;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'description': description,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      title: json['title'],
      amount: json['amount'].toDouble(),
      category: json['category'],
      date: DateTime.parse(json['date']),
      description: json['description'],
    );
  }

  @override
  String toString() {
    return 'Expense{id: $id, title: $title, amount: $amount, category: $category, date: $date}';
  }
}

class ExpenseCategory {
  static const String food = 'Alimentação';
  static const String transport = 'Transporte';
  static const String entertainment = 'Entretenimento';
  static const String health = 'Saúde';
  static const String education = 'Educação';
  static const String shopping = 'Compras';
  static const String bills = 'Contas';
  static const String others = 'Outros';

  static List<String> get all => [
    food,
    transport,
    entertainment,
    health,
    education,
    shopping,
    bills,
    others,
  ];
}
