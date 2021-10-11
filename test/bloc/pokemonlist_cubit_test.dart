import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokebankv2/models/class/pokemon.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_cubit.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_states.dart';

import '../mocks/mocks.dart';

class Mockaaaa extends Mock implements PokemonListCubit {}

// TODO Começar a imlementar testes com Bloc/Cubit usando bloc_test
void main() {

  group("PokemonListCubit", () {
    final PokemonsDaoMock pokemonsDaoMock = PokemonsDaoMock();
    setUpAll(() async {
      print("Aqui no setUp");
      when(() => pokemonsDaoMock.findAll()).thenAnswer((_) {
        return Future.delayed(Duration(seconds: 2), () => [Pokemon("pokeNome", 1)]);
      });
    });
    blocTest<PokemonListCubit, PokemonListState>(
      "sei la",
      build: () => PokemonListCubit(pokemonsDaoMock),
      skip: 0,
      act: (cubit) => cubit.load(),
      expect: () => [LoadingPokemonListState(), LoadedPokemonListState([Pokemon("PokemonTest", 100), Pokemon
        ("PokemonTest", 12)])]
    );
  });
}
