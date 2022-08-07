class FoodData {
  List<Food> foods;
  FoodData({this.foods});

  factory FoodData.fromJson(Map<String, dynamic> json) => FoodData(
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
      );
}

class Food {
  String name;
  double quantity;
  int multiplier;
  String unit;
  // rice 2 x 100 g

  Food({
    this.multiplier,
    this.name,
    this.quantity,
    this.unit,
  });
  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json['name'],
        quantity: json['quantity'],
        unit: json['unit'],
        multiplier: json['multiplier'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'unit': unit,
        'multiplier': multiplier,
      };
}

class RefillFood {
  String foodName;
  DateTime date;
  int packSize;
  int daysLeft;
  int quantity;
  int multiplier;

  RefillFood({
    this.date,
    this.daysLeft,
    this.foodName,
    this.packSize,
    this.multiplier,
    this.quantity,
  });

  factory RefillFood.fromJson(Map<String, dynamic> json) => RefillFood(
        foodName: json['foodName'],
        date: json['date'],
        daysLeft: json['daysLeft'],
        packSize: json['packSize'],
        quantity: json['quantity'],
        multiplier: json['multiplier'],
      );

  Map<String, dynamic> toJson() => {
        'foodName': foodName,
        'date': date,
        'daysLeft': daysLeft,
        'packSize': packSize,
        'quantity':quantity,
        'multiplier': multiplier,
      };
}
