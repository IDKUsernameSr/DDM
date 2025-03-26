import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Add this constructor
  
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
  CookieClickerGameState createState() => CookieClickerGameState(); // Fixed state class name
}

class CookieClickerGameState extends State<CookieClickerGame> {
  int cookies = 0;
  int cookiesPerClick = 1;
  int cookiesPerSecond = 0;
  List<Upgrade> upgrades = [
    Upgrade(name: "Cursor", cost: 15, cps: 0.1),
    Upgrade(name: "Grandma", cost: 100, cps: 1),
    Upgrade(name: "Farm", cost: 1100, cps: 8),
    Upgrade(name: "Mine", cost: 12000, cps: 47),
  ];

  @override
  void initState() {
    super.initState();
    // Game loop that adds cookies per second
    Future.delayed(Duration.zero, () {
      gameLoop();
    });
  }

  void gameLoop() async {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        cookies += cookiesPerSecond;
      });
    }
  }

  void buyUpgrade(Upgrade upgrade) {
    if (cookies >= upgrade.cost) {
      setState(() {
        cookies -= upgrade.cost;
        cookiesPerSecond += upgrade.cps.toInt();
        upgrade.cost = (upgrade.cost * 1.15).toInt(); // Increase cost for next purchase
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cookie Clicker'),
      ),
      body: Column(
        children: [
          // Cookie display and click area
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$cookies cookies',
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
                      'assets/images.jpg',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Per second: $cookiesPerSecond',
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
                  subtitle: Text('Cost: ${upgrade.cost} cookies\nProduces: ${upgrade.cps} per second'),
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

class Upgrade {
  String name;
  int cost;
  double cps;

  Upgrade({required this.name, required this.cost, required this.cps});
}