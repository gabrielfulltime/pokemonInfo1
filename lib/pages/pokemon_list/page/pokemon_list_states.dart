// Estados da screen Lista pokemon_list
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokebankv2/models/class/pokemon.dart';

@immutable // Abstract State
abstract class PokemonListState extends Equatable {
  const PokemonListState();
}

@immutable // Initial state
class InitialPokemonListState extends PokemonListState {
  const InitialPokemonListState();

  @override
  // TODO: implement props
  List<Object?> get props => [InitialPokemonListState];
}

@immutable // Loading state
class LoadingPokemonListState extends PokemonListState {
  const LoadingPokemonListState();

  @override
  // TODO: implement props
  List<Object?> get props => [this.runtimeType];
}

@immutable // Loaded state
class LoadedPokemonListState extends PokemonListState {
  final List<Pokemon> pokemonList;
  const LoadedPokemonListState(this.pokemonList);

  @override
  // TODO: implement props
  List<Object?> get props => [this.runtimeType];
}

@immutable // Loaded state
class LoadedEmptyPokemonListState extends PokemonListState {
  const LoadedEmptyPokemonListState();

  @override
  // TODO: implement props
  List<Object?> get props => [this.runtimeType];
}


@immutable // Fatal error State (Imprevisto)
class FatalErrorPokemonListState extends PokemonListState {
  const FatalErrorPokemonListState();

  @override
  // TODO: implement props
  List<Object?> get props => [this.runtimeType];
}
