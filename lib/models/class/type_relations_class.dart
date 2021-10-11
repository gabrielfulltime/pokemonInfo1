

class TypeRelations {
  static const damage_relations = "damage_relations";
  static const double_damage_from = "double_damage_from";
  static const double_damage_to = "double_damage_to";
  static const half_damage_from =  "half_damage_from";
  static const half_damage_to = "half_damage_to";
  static const no_damage_from = "no_damage_from";
  static const no_damage_to = "no_damage_to";

  List<String> doubleDamageFrom = [];
  List<String> doubleDamageTo = [];
  List<String> halfDamageTo = [];
  List<String> halfDamageFrom = [];
  List<String> noDamageFrom = [];
  List<String> noDamageTo = [];

  TypeRelations.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> relations = json[damage_relations];
    doubleDamageFrom = relations[double_damage_from];
    doubleDamageTo = relations[double_damage_to];
    halfDamageFrom = relations[half_damage_from];
    halfDamageTo = relations[half_damage_to];
    noDamageFrom = relations[no_damage_from];
    noDamageTo = relations[no_damage_to];
  }
  List<dynamic> getAdvantages() {
    return [doubleDamageTo, halfDamageFrom, noDamageFrom];
  }

  List<dynamic> getWeaknesses() {
    return [doubleDamageFrom, halfDamageTo, noDamageTo];
  }
  
}
