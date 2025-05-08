import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookie Clicker',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: CookieClickerGame(),
    );
  }
}

class CookieClickerGame extends StatefulWidget {
  const CookieClickerGame({super.key});

  @override
  CookieClickerGameState createState() => CookieClickerGameState();
}

class CookieClickerGameState extends State<CookieClickerGame> {
  double cookies = 0.0;
  int baseCookiesPerClick = 1;
  double cookiesPerClick = 1.0;
  double cookiesPerSecond = 0.0;
  double cookieAccumulator = 0.0;
  double baseCookiesPerSecond = 0.0;
  late CookieSkin selectedSkin;

  List<Upgrade> upgrades = [
    Upgrade(name: "Cursor", cost: 15, cps: 0.1),
    Upgrade(name: "Grandma", cost: 100, cps: 1),
    Upgrade(name: "Farm", cost: 1100, cps: 8),
    Upgrade(name: "Mine", cost: 12000, cps: 47),
  ];

  List<SpecialUpgrade> specialUpgrades = [
    SpecialUpgrade(name: "Golden Cookie", cost: 1, percentBoost: 0.2),
    SpecialUpgrade(name: "Golden Finger", cost: 15, clickBoost: 0.5), // +50% click
    SpecialUpgrade(name: "Super Oven", cost: 5000, percentBoost: 0.5),
  ];  

  @override
  void initState() {
    super.initState();
    selectedSkin = cookieSkins[0]; // default skin
    gameLoop(); // ✅ Correct way to start the loop
  }

  void gameLoop() async {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        cookies += cookiesPerSecond; // ✅ adds fractions too
      });
    }
  }

void updateCookiesPerClick() {
  double totalBoost = 0.0;

  for (var upgrade in specialUpgrades) {
    if (upgrade.purchased) {
      totalBoost += upgrade.clickBoost;
    }
  }

  cookiesPerClick = baseCookiesPerClick * (1 + totalBoost);
}

void updateCookiesPerSecond() {
  double totalBoost = 0.0;

  for (var upgrade in specialUpgrades) {
    if (upgrade.purchased) {
      totalBoost += upgrade.percentBoost;
    }
  }

  cookiesPerSecond = baseCookiesPerSecond * (1 + totalBoost);
}


void buyUpgrade(Upgrade upgrade) {
  if (cookies >= upgrade.cost) {
    setState(() {
      cookies -= upgrade.cost;
      cookiesPerSecond += upgrade.cps;
      upgrade.count++; // ✅ add 1 to the count
      upgrade.cost = (upgrade.cost * 1.15).toInt(); // increase cost

      baseCookiesPerSecond += upgrade.cps;
      updateCookiesPerSecond(); // ✅ recompute with bonuses
    });
  }
}

void buySpecialUpgrade(SpecialUpgrade upgrade) {
  if (!upgrade.purchased && cookies >= upgrade.cost) {
    setState(() {
      cookies -= upgrade.cost;
      cookiesPerSecond *= (1 + upgrade.percentBoost);
      upgrade.purchased = true;
      updateCookiesPerSecond();
      updateCookiesPerClick(); // ✅ apply new boost
    });
  }
}

void updateSkinBoost() {
  updateCookiesPerSecond(); // recompute base CPS with specialUpgrades

  if (selectedSkin.purchased && selectedSkin.cpsBoost > 0) {
    cookiesPerSecond *= (1 + selectedSkin.cpsBoost);
  }
}

List<CookieSkin> cookieSkins = [
  CookieSkin(
    name: "Classic Cookie",
    imagePath: "assets/images.jpg",
    cost: 0,
  ),
  CookieSkin(
    name: "Chocolate Cookie",
    imagePath: "assets/boloMinion.jpg",
    cost: 100,
    cpsBoost: 0.2, // +20% CPS
  ),
];

void buyOrSelectSkin(CookieSkin skin) {
  setState(() {
    if (!skin.purchased && cookies >= skin.cost) {
      cookies -= skin.cost;
      skin.purchased = true;
    }
    if (skin.purchased) {
      selectedSkin = skin;
      updateSkinBoost(); // update CPS with skin
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cookie Clicker'),
      ),
      body: Column(
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
                    cookies: cookies,
                    onBuy: (upgrade) {
                      buySpecialUpgrade(upgrade);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            child: Text('Special Upgrades'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SkinShopPage(
                    skins: cookieSkins,
                    cookies: cookies,
                    selectedSkin: selectedSkin,
                    onBuyOrSelect: buyOrSelectSkin,
                  ),
                ),
              );
            },
            child: Text('Skin Shop'),
          ),
        ],
      ),
    ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${cookies.toStringAsFixed(1)} cookies',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cookies += cookiesPerClick;
                      });
                    },
                    child: Image.asset(
                      selectedSkin.imagePath,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Per second: ${cookiesPerSecond.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          // Upgrades section
          Container(
            height: 200,
            color: Colors.grey[200],
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: upgrades.length,
              itemBuilder: (context, index) {
                final upgrade = upgrades[index];
                return ListTile(
                  title: Text(upgrade.name),
                  subtitle: Text(
                    'Owned: ${upgrade.count}\n'
                    'Cost: ${upgrade.cost} cookies\n'
                    'Each: ${upgrade.cps} cps → Total: ${(upgrade.count * upgrade.cps).toStringAsFixed(1)} cps',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => buyUpgrade(upgrade),
                    child: Text('Buy'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SpecialUpgradePage extends StatelessWidget {
  final List<SpecialUpgrade> upgrades;
  final double cookies;
  final Function(SpecialUpgrade) onBuy;

  const SpecialUpgradePage({
    super.key,
    required this.upgrades,
    required this.cookies,
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
          return ListTile(
            title: Text(upgrade.name),
            subtitle: Text(
              upgrade.purchased
                  ? 'Purchased'
                  : 'Cost: ${upgrade.cost} cookies\nBoosts total CPS by ${(upgrade.percentBoost * 100).toStringAsFixed(0)}%',
            ),
            trailing: ElevatedButton(
              onPressed: (!upgrade.purchased && cookies >= upgrade.cost)
                  ? () => onBuy(upgrade)
                  : null,
              child: Text(upgrade.purchased ? '✔' : 'Buy'),
            ),
          );
        },
      ),
    );
  }
}

class SkinShopPage extends StatelessWidget {
  final List<CookieSkin> skins;
  final double cookies;
  final CookieSkin selectedSkin; // ✅ Make sure this is declared
  final Function(CookieSkin) onBuyOrSelect;

  const SkinShopPage({
    super.key,
    required this.skins,
    required this.cookies,
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
          return ListTile(
            leading: Image.asset(
              skin.imagePath,
              width: 50,
              height: 50,
            ),
            title: Text(skin.name),
            subtitle: Text(skin.purchased
                ? (skin == selectedSkin ? 'Currently Selected' : 'Purchased')
                : 'Cost: ${skin.cost} cookies'),
            trailing: ElevatedButton(
              onPressed: () {
                onBuyOrSelect(skin);
                Navigator.pop(context);
              },
              child: Text(
                skin.purchased
                    ? (skin == selectedSkin ? '✓' : 'Select')
                    : 'Buy',
              ),
            ),
          );
        },
      ),
    );
  }
}



class Upgrade {
  String name;
  int cost;
  double cps;
  int count;

  Upgrade({
    required this.name,
    required this.cost,
    required this.cps,
    this.count = 0, // starts at 0
  });
}

class SpecialUpgrade {
  String name;
  int cost;
  double percentBoost;
  double clickBoost;
  bool purchased;

  SpecialUpgrade({
    required this.name,
    required this.cost,
    this.percentBoost = 0.0, // ✅ default value
    this.clickBoost = 0.0,   // ✅ default value
    this.purchased = false,
  });
}

class CookieSkin {
  String name;
  String imagePath;
  int cost;
  double cpsBoost;
  bool purchased;

  CookieSkin({
    required this.name,
    required this.imagePath,
    required this.cost,
    this.cpsBoost = 0.0,
    this.purchased = false,
  });
}
