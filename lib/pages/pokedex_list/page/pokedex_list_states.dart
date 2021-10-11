import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokebankv2/models/class/pokedex_item.dart';
import 'package:pokebankv2/models/class/pokemon.dart';
import 'package:pokebankv2/pages/pokedex_list/page/pokedex_list_cubit.dart';

@immutable // Abstract State
abstract class PokedexListState extends Equatable {
  const PokedexListState();
}

@immutable // Initial state
class InitialPokedexListState extends PokedexListState {
  const InitialPokedexListState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@immutable // Loading state
class LoadingPokedexListState extends PokedexListState {
  const LoadingPokedexListState();

  @override
  // TODO: implement props
  List<Object?> get props => [this.runtimeType];
}

class OngoingPokedexListState extends PokedexListState {
  const OngoingPokedexListState();

  @override
  // TODO: implement props
  List<Object?> get props => [this.runtimeType];
}

@immutable // Loaded state
class LoadedPokedexListState extends PokedexListState {
  const LoadedPokedexListState({this.pokedex = const [], this.hasReachedMax = false});

  final List<PokedexItem> pokedex;
  final bool hasReachedMax;

  @override
  // TODO: implement props
  List<Object?> get props => [pokedex];
}

@immutable // Fatal error State (Imprevisto)
class FatalErrorPokedexListState extends PokedexListState {
  const FatalErrorPokedexListState();

  @override
  // TODO: implement props
  List<Object?> get props => [this.runtimeType];
}

// PokedexListState copyWith({PokedexListStatus? status, List<PokedexItem>? pokedex, bool? hasReachedMax}) =>
//     PokedexListState(
//         pokedex: pokedex ?? this.pokedex,
//         status: status ?? this.status,
//         hasReachedMax: hasReachedMax ?? this.hasReachedMax);
// final List<PokedexItem> pokedex;
// final PokedexListStatus status;
// final bool hasReachedMax;
