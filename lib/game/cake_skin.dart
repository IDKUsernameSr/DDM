// lib/game/cake_skin.dart
class CakeSkin {
  String name;
  String imagePath;
  int cost;
  double cpsBoost;
  bool purchased;

  CakeSkin({
    required this.name,
    required this.imagePath,
    required this.cost,
    this.cpsBoost = 0.0,
    this.purchased = false,
  });
}
