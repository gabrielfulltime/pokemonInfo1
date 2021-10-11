
import 'package:flutter/material.dart';
import 'package:pokebankv2/models/class/pokedex_item.dart';

@immutable
abstract class PokemonFormState {
  const PokemonFormState();
}


@immutable
class InitialPokemonFormState extends PokemonFormState {
  const InitialPokemonFormState();
}

@immutable
class FindingPokemonFormState extends PokemonFormState {
  const FindingPokemonFormState();
}

@immutable
class FindedPokemonFormState extends PokemonFormState {
  final PokedexItem pokeInformacao;

  const FindedPokemonFormState(this.pokeInformacao);
}

@immutable
class NotFindedPokemonFormState extends PokemonFormState {
  const NotFindedPokemonFormState();
}

@immutable
class SendingPokemonFormState extends PokemonFormState {
  const SendingPokemonFormState();
}

@immutable
class LoadedPokemonFormState extends PokemonFormState {
  const LoadedPokemonFormState();
}
