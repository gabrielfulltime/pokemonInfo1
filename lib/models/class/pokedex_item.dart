import 'package:flutter/material.dart';
import 'package:pokebankv2/models/class/pokemon.dart';
import 'package:pokebankv2/models/class/type_relations_class.dart';

class PokedexItem {
  late final Pokemon pokemon;
  bool found = true;
  TypeRelations? typeRelations;
  List<dynamic>? type = [];
  List<dynamic>? status = [];
  List<String> evolutions = [];

  static Map<dynamic, Color?> colorsType = {
    "normal": Colors.grey[100],
    "fighting": Colors.orange[700] ,
    "flying": Colors.blue[100],
    "poison": Colors.deepPurple[400],
    "ground": Colors.brown[500],
    "rock": Colors.grey[400],
    "bug": Colors.green[800],
    "ghost": Colors.purple[300],
    "steel": Colors.blueGrey[500],
    "fire": Colors.red[400],
    "water": Colors.lightBlue[500],
    "grass": Colors.lightGreen[700],
    "electric": Colors.yellow[300],
    "psychic": Colors.pink[400],
    "ice": Colors.blue[300],
    "dragon": Colors.red[600],
    "dark": Colors.black54,
    "fairy": Colors.pink[300]
  };

  @override
  String toString() {
    return 'PokedexItem{name: ${pokemon.pokemonName}, id: ${pokemon.pokedexId}, type: $type, urlImage: '
        '${pokemon.urlImage}, status: '
        '$status}';
  }

  PokedexItem({
    this.found = true,
    required this.pokemon,
    this.type,
  }) {
    if (!this.found) {
      this.pokemon.pokemonName = "????????????????????????";
    }
  }

  PokedexItem.fromJson({required Map<String, dynamic> json, int? i, bool achado = true}) {
    this.pokemon = Pokemon.fromJson(json: json, i: i);
    for (dynamic types in json["types"]) {
      this.type!.add(types["type"]["name"]);
    }
    this.status = json["stats"];
  }
}

// Links interessantes
//
// Foto dos pokemons em forma de icone
// https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/icons/10.png
// Pokemons em sua forma Shyny
// https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png
// Pokemons imagem em SVG
// https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/10.svg
// Pokemons imagem comum
// https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/10.png
