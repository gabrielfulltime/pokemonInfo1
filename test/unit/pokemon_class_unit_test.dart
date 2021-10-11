import 'package:flutter_test/flutter_test.dart';
import 'package:pokebankv2/models/class/pokemon.dart';

void main(){
  group("Classe Pokemon", (){
    test("Deve retornar o numero da pokedex_list do pokemon_list", (){
      final pokemon = Pokemon("", 10);
      expect(pokemon.pokedexId, 10);
    });
    test("Deve retornar erro quando criar um pokemon_list com numero menor que 1", (){
      expect(() => Pokemon("", 0), throwsAssertionError);
    });
  });
}