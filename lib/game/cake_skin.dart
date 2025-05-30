// lib/game/cake_skin.dart
class CakeSkin {
  final String name;
  final String imagePath;
  final int cost;
  final double cpsBoost;
  bool purchased;

  CakeSkin({
    required this.name,
    required this.imagePath,
    required this.cost,
    this.cpsBoost = 0.0,
    this.purchased = false,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'purchased': purchased,
  };

  static CakeSkin fromName(String name, List<CakeSkin> availableSkins) {
    return availableSkins.firstWhere((skin) => skin.name == name,
      orElse: () => availableSkins[0]);
  }
}

List<CakeSkin> defaultCakeSkins = [
  CakeSkin(
    name: "Classic Cookie",
    imagePath: "assets/images.jpg",
    cost: 0,
    purchased: true,
  ),
  CakeSkin(
    name: "Chocolate Cookie",
    imagePath: "assets/bolo.jpg",
    cost: 100,
    cpsBoost: 0.2,
  ),
];

