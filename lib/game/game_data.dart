import 'package:cookie_clicker/game/cake_skin.dart';
import 'package:cookie_clicker/game/upgrades.dart';
import 'package:hive_flutter/hive_flutter.dart';

void saveGame({
  required double cakes,
  required double cakesPerClick,
  required double cakesPerSecond,
  required String selectedSkinName,
  required List<Upgrade> upgrades,
  required List<SpecialUpgrade> specialUpgrades,
  required List<CakeSkin> cakeSkins,
}) {
  final box = Hive.box('gameData');

  box.put('cakes', cakes);
  box.put('cakesPerClick', cakesPerClick);
  box.put('cakesPerSecond', cakesPerSecond);
  box.put('selectedSkin', selectedSkinName);

  box.put('upgrades', upgrades.map((u) => {
    'name': u.name,
    'count': u.count,
  }).toList());

  box.put('specialUpgrades', specialUpgrades.map((u) => {
    'name': u.name,
    'purchased': u.purchased,
  }).toList());

  box.put('skins', cakeSkins.map((s) => {
    'name': s.name,
    'purchased': s.purchased,
  }).toList());
}

Map<String, dynamic> loadGame() {
  final box = Hive.box('gameData');
  return {
    'cakes': box.get('cakes', defaultValue: 0.0),
    'cakesPerClick': box.get('cakesPerClick', defaultValue: 1),
    'selectedSkin': box.get('selectedSkin'),
    'upgrades': box.get('upgrades', defaultValue: []),
    'specialUpgrades': box.get('specialUpgrades', defaultValue: []),
    'skins': box.get('skins', defaultValue: []),
  };
}
