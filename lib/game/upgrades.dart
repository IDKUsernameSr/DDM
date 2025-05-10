// lib/game/upgrades.dart
class Upgrade {
  String name;
  int cost;
  final int baseCost;
  double cps;
  int count;
  String iconPath;

  Upgrade({
    required this.name,
    required this.cost,
    required this.cps,
    required this.iconPath,
    this.count = 0,
  }) : baseCost = cost;
}

class SpecialUpgrade {
  String name;
  int cost;
  double percentBoost;
  double clickBoost;
  bool purchased;
  String iconPath;

  SpecialUpgrade({
    required this.name,
    required this.cost,
    required this.iconPath,
    this.percentBoost = 0.0,
    this.clickBoost = 0.0,
    this.purchased = false,
  });
}
