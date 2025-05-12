import 'dart:math';

import 'package:bolo_mania/game/game_data.dart';
import 'package:flutter/material.dart';
import '../game/upgrades.dart';
import '../game/cake_skin.dart';
import '../pages/settings_page.dart';
import '../pages/special_upgrade_page.dart';
import '../pages/skin_shop_page.dart';

class CakeClickerGame extends StatefulWidget {
  const CakeClickerGame({super.key});

  @override
  CakeClickerGameState createState() => CakeClickerGameState();
}

class CakeClickerGameState extends State<CakeClickerGame> {
  double cakes = 0.0;
  int baseCakesPerClick = 1;
  double cakesPerClick = 1.0;
  double cakesPerSecond = 0.0;
  double cookieAccumulator = 0.0;
  double baseCakesPerSecond = 0.0;
  late CakeSkin selectedSkin;

  List<Upgrade> upgrades = [
    Upgrade(name: "Cursor", cost: 15, cps: 0.1, iconPath: "assets/icons/cursor.png"),
    Upgrade(name: "Grandma", cost: 100, cps: 1, iconPath: "assets/icons/cursor.png"),
    Upgrade(name: "Farm", cost: 1100, cps: 8, iconPath: "assets/icons/cursor.png"),
    Upgrade(name: "Mine", cost: 12000, cps: 47, iconPath: "assets/icons/cursor.png"),
  ];

  List<SpecialUpgrade> specialUpgrades = [
    SpecialUpgrade(name: "Golden Cookie", cost: 1, percentBoost: 0.2, iconPath: "assets/icons/cursor.png"),
    SpecialUpgrade(name: "Golden Finger", cost: 15, clickBoost: 0.5, iconPath: "assets/icons/cursor.png"), // +50% click
    SpecialUpgrade(name: "Super Oven", cost: 5000, percentBoost: 0.5, iconPath: "assets/icons/cursor.png"),
  ];

 List<CakeSkin> cakeSkins = [
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
    cpsBoost: 0.2, // +20% CPS
  ),
];

  void gameLoop() async {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        cakes += cakesPerSecond; // ✅ adds fractions too
      });
    }
  }

void updateCakesPerClick() {
  double totalBoost = 0.0;

  for (var upgrade in specialUpgrades) {
    if (upgrade.purchased) {
      totalBoost += upgrade.clickBoost;
    }
  }

  cakesPerClick = baseCakesPerClick * (1 + totalBoost);
}

void updateCakesPerSecond() {
  double totalBoost = 0.0;

  for (var upgrade in specialUpgrades) {
    if (upgrade.purchased) {
      totalBoost += upgrade.percentBoost;
    }
  }

  if (selectedSkin.purchased) {
    totalBoost += selectedSkin.cpsBoost;
  }

  cakesPerSecond = baseCakesPerSecond * (1 + totalBoost);
}


void buyUpgrade(Upgrade upgrade) {
  if (cakes >= upgrade.cost) {
    setState(() {
      cakes -= upgrade.cost;
      cakesPerSecond += upgrade.cps;
      upgrade.count++; // ✅ add 1 to the count
      upgrade.cost = (upgrade.cost * 1.15).toInt(); // increase cost

      baseCakesPerSecond += upgrade.cps;
      updateCakesPerSecond(); // ✅ recompute with bonuses
    });
  }
}

void buySpecialUpgrade(SpecialUpgrade upgrade) {
  if (!upgrade.purchased && cakes >= upgrade.cost) {
    setState(() {
      cakes -= upgrade.cost;
      cakesPerSecond *= (1 + upgrade.percentBoost);
      upgrade.purchased = true;
      updateCakesPerSecond();
      updateCakesPerClick(); // ✅ apply new boost
    });
  }
}

void buyOrSelectSkin(CakeSkin skin) {
  setState(() {
    if (!skin.purchased && cakes >= skin.cost) {
      cakes -= skin.cost;
      skin.purchased = true;
    }
    if (skin.purchased) {
      selectedSkin = skin;
      updateCakesPerSecond(); // ✅ correct, only applies all boosts once
    }
  });
}

void startAutoSave() async {
  while (true) {
    await Future.delayed(Duration(seconds: 10)); // change interval here
    saveGame(
      cakes: cakes,
      cakesPerClick: cakesPerClick,
      cakesPerSecond: cakesPerSecond,
      selectedSkinName: selectedSkin.name,
      upgrades: upgrades,
      specialUpgrades: specialUpgrades,
      cakeSkins: cakeSkins,
      );
  }
}

  @override
  void initState() {
    super.initState();
    final data = loadGame();
    setState(() {
    cakes = data['cakes'];
    cakesPerClick = data['cakesPerClick'];

    selectedSkin = cakeSkins.firstWhere(
      (s) => s.name == data['selectedSkin'],
      orElse: () => cakeSkins[0],
    );

    for (var saved in data['upgrades']) {
      final match = upgrades.firstWhere(
        (u) => u.name == saved['name'],
        orElse: () => Upgrade(name: '', cost: 0, cps: 0, iconPath: ''),
      );

      if (match.name.isNotEmpty) {
        match.count = saved['count'];

        match.cost = (match.cost * pow(1.15, match.count)).round();
      }

    baseCakesPerSecond = 0.0;
    for (var u in upgrades) {
      baseCakesPerSecond += u.count * u.cps;
    }

    for (var saved in data['specialUpgrades']) {
      final matches = specialUpgrades.where((u) => u.name == saved['name']);
      if (matches.isNotEmpty) {
        matches.first.purchased = saved['purchased'];
      }
    }

    for (var saved in data['skins']) {
      final matches = cakeSkins.where((s) => s.name == saved['name']);
      if (matches.isNotEmpty) {
        matches.first.purchased = saved['purchased'];
      }
    }

    updateCakesPerSecond();
  }});
    selectedSkin = cakeSkins[0];
    gameLoop();
    startAutoSave();
  }

  @override
  Widget build(BuildContext context) {
    final infoStyle = TextStyle(
      fontSize: 10,
      fontFamily: 'PressStart2P',
      color: Colors.black,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
      'Cookie Clicker',
      style: TextStyle(
        fontFamily: 'PressStart2P', // 👾 or your pixel font
        fontSize: 14,
        color: Colors.black,
      ),
    ),
      ),
    
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            repeat: ImageRepeat.repeat, // ✅ this tiles the image
            alignment: Alignment.topLeft,
          ),
        ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
              color: Colors.black.withAlpha((0.6 * 255).toInt()),
            ),
          ),
          Column(
              children: [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpecialUpgradePage(
                    upgrades: specialUpgrades,
                    cakes: cakes,
                    onBuy: buySpecialUpgrade,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF8D9D6),
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.black, width: 1.5),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(
              'Special Upgrades',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'PressStart2P',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SkinShopPage(
                    skins: cakeSkins,
                    cakes: cakes,
                    selectedSkin: selectedSkin,
                    onBuyOrSelect: buyOrSelectSkin,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF8D9D6),
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.black, width: 1.5),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(
              'Skin Shop',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'PressStart2P',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    onSave: () {
                      saveGame(
                        cakes: cakes,
                        cakesPerClick: cakesPerClick,
                        cakesPerSecond: cakesPerSecond,
                        selectedSkinName: selectedSkin.name,
                        upgrades: upgrades,
                        specialUpgrades: specialUpgrades,
                        cakeSkins: cakeSkins,
                      );
                    },
                    onReset: () {
                      setState(() {
                        cakes = 0;
                        cakesPerClick = 1;
                        baseCakesPerSecond = 0;
                        cakesPerSecond = 0;
                        cookieAccumulator = 0;

                        for (var u in upgrades) {
                          u.count = 0;
                          u.cost = u.baseCost; // Optional: reset cost if you have baseCost
                        }

                        for (var s in specialUpgrades) {
                          s.purchased = false;
                        }

                        for (var skin in cakeSkins) {
                          skin.purchased = skin.name == "Classic Cookie"; // only default owned
                        }

                        selectedSkin = cakeSkins.first;
                        updateCakesPerSecond();
                      });
            }),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF8D9D6),
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.black, width: 1.5),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'PressStart2P',
              ),
            ),
          ),
        ],
      ),
    ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8D9D6), // light pink/beige background
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20),  
                    ),
                    child: Text(
                      '${cakes.toStringAsFixed(1)} cakes',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PressStart2P', // or remove this line if you’re not using a pixel font yet
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cakes += cakesPerClick;
                      });
                    },
                    child: Image.asset(
                      selectedSkin.imagePath,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8D9D6),
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Per second: ${cakesPerSecond.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PressStart2P', // or any pixel font you're using
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Upgrades section
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200], // ✅ moved inside here
              image: DecorationImage(
                image: AssetImage('assets/background2.jpg'),
                  repeat: ImageRepeat.repeat,
                  alignment: Alignment.topLeft,
              ),
            ),
            child: ListView.builder(
              itemCount: upgrades.length,
              itemBuilder: (context, index) {
                final upgrade = upgrades[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 👵 Icon
                      Image.asset(
                        upgrade.iconPath,
                        width: 40,
                        height: 40,
                      ),

                      SizedBox(width: 8),

                      // 🧁 Name label
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFF8D9D6),
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          upgrade.name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PressStart2P',
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(width: 8),

                      // 📄 Info box
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
                              Text('Custo: ${upgrade.cost} bolos', style: infoStyle),
                              Text('Produção: ${upgrade.cps} bps → Total: ${(upgrade.count * upgrade.cps).toStringAsFixed(1)} bps', style: infoStyle),
                              Text('Quantidade: ${upgrade.count}', style: infoStyle),
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
                            side: BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        onPressed: () => buyUpgrade(upgrade),
                        child: Text(
                          'COMPRAR',
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
          ),
        ],
      ),
            ],
    )));
  }
}