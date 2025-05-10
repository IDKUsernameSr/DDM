import 'package:cookie_clicker/game/cake_skin.dart';
import 'package:flutter/material.dart';

class SkinShopPage extends StatelessWidget {
  final List<CakeSkin> skins;
  final double cakes;
  final CakeSkin selectedSkin; // ✅ Make sure this is declared
  final Function(CakeSkin) onBuyOrSelect;

  const SkinShopPage({
    super.key,
    required this.skins,
    required this.cakes,
    required this.selectedSkin, // ✅ Make sure this is here
    required this.onBuyOrSelect,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cookie Skins')),
      body: ListView.builder(
        itemCount: skins.length,
        itemBuilder: (context, index) {
          final skin = skins[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🎨 Skin Icon
                  Image.asset(
                    skin.imagePath,
                    width: 40,
                    height: 40,
                  ),

                  SizedBox(width: 8),

                  // 🧾 Skin Info Box
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
                          skin.name,
                          style: TextStyle(
                            fontFamily: 'PressStart2P',
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          skin.purchased
                              ? (skin == selectedSkin ? 'Currently Selected' : 'Purchased')
                              : 'Cost: ${skin.cost} cakes',
                          style: TextStyle(fontSize: 10),
                        ),
                        if (skin.cpsBoost > 0)
                          Text(
                            'Boost: +${(skin.cpsBoost * 100).toStringAsFixed(0)}% CPS',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: skin.purchased ? Colors.black : Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 8),

                  // 🛍 Buy/Select Button
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
                    onPressed: () {
                      if (skin.purchased || cakes >= skin.cost) {
                        onBuyOrSelect(skin);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Not enough cakes!')),
                        );
                      }
                    },
                    child: Text(
                      skin.purchased
                          ? (skin == selectedSkin ? '✓' : 'Select')
                          : 'Buy',
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