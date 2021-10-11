import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokebankv2/app_dependencies/app_dependencies.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_cubit.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_view.dart';

class PokemonListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contextBloc) => PokemonListCubit(AppDependencies.of(context)!.pokemonsDao),
      child: PokemonListView(),
    );
  }
}
