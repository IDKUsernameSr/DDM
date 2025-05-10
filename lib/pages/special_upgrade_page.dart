import 'package:flutter/material.dart';
import '../game/upgrades.dart';

class SpecialUpgradePage extends StatelessWidget {
  final List<SpecialUpgrade> upgrades;
  final double cakes;
  final Function(SpecialUpgrade) onBuy;

  const SpecialUpgradePage({
    super.key,
    required this.upgrades,
    required this.cakes,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Special Upgrades')),
      body: ListView.builder(
        itemCount: upgrades.length,
        itemBuilder: (context, index) {
          final upgrade = upgrades[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👾 Icon (make sure you added iconPath to SpecialUpgrade)
                Image.asset(
                  upgrade.iconPath,
                  width: 40,
                  height: 40,
                ),

                SizedBox(width: 8),

                // 🧾 Info box
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8D9D6),
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          upgrade.name,
                          style: TextStyle(fontFamily: 'PressStart2P', fontSize: 10),
                        ),

                        Text(
                          'Cost: ${upgrade.cost} cakes',
                          style: TextStyle(fontSize: 10),
                        ),

                        if (upgrade.percentBoost > 0)
                          Text(
                            'Boost: +${(upgrade.percentBoost * 100).toStringAsFixed(0)}% CPS',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          ),

                        if (upgrade.clickBoost > 0)
                          Text(
                            'Click Boost: +${(upgrade.clickBoost * 100).toStringAsFixed(0)}%',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          ),

                        if (upgrade.purchased)
                          Text(
                            'Purchased',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 8),

                // 🛒 Buy Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF8D9D6),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.black, width: 1.5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                  onPressed: upgrade.purchased
                      ? null
                      : () {
                          if (cakes >= upgrade.cost) {
                            onBuy(upgrade);
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Not enough cakes!')),
                            );
                          }
                        },
                  child: Text(
                    upgrade.purchased ? '✔' : 'Buy',
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'PressStart2P',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}