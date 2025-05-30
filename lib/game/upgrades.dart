class Upgrade {
  final String name;
  int cost;
  int baseCost;
  final double cps;
  final String iconPath;
  int count;

  Upgrade({
    required this.name,
    required this.baseCost,
    required this.cost,
    required this.cps,
    required this.iconPath,
    this.count = 0,
  }); // optional helper
}

class SpecialUpgrade {
  final String name;
  final int cost;
  final double percentBoost;
  final double clickBoost;
  final String iconPath;
  bool purchased;

  SpecialUpgrade({
    required this.name,
    required this.cost,
    this.percentBoost = 0.0,
    this.clickBoost = 0.0,
    required this.iconPath,
    this.purchased = false,
  });
}

List<Upgrade> defaultUpgrades = [
  Upgrade(name: "Cursor", baseCost: 15, cost: 15, cps: 0.1, iconPath: "assets/icons/cursor.png"),
  Upgrade(name: "Grandma", baseCost: 100, cost: 100, cps: 1, iconPath: "assets/icons/cursor.png"),
  Upgrade(name: "Farm", baseCost: 1100, cost: 1100, cps: 8, iconPath: "assets/icons/cursor.png"),
  Upgrade(name: "Mine", baseCost: 12000, cost: 12000, cps: 47, iconPath: "assets/icons/cursor.png"),
];

List<SpecialUpgrade> defaultSpecialUpgrades = [
  SpecialUpgrade(name: "Golden Cookie", cost: 1, percentBoost: 0.2, iconPath: "assets/icons/cursor.png"),
  SpecialUpgrade(name: "Golden Finger", cost: 15, clickBoost: 0.5, iconPath: "assets/icons/cursor.png"),
  SpecialUpgrade(name: "Super Oven", cost: 5000, percentBoost: 0.5, iconPath: "assets/icons/cursor.png"),
];
