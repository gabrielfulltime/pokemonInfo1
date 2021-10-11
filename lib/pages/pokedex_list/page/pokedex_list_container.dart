import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokebankv2/app_dependencies/app_dependencies.dart';
import 'package:pokebankv2/pages/pokedex_list/page/pokedex_list_cubit.dart';
import 'package:pokebankv2/pages/pokedex_list/page/pokedex_list_view.dart';

class PokedexListContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contextBloc) => PokedexListCubit(AppDependencies.of(context)!.pokemonsWeb),
      child: PokedexListView()
    );
  }

}