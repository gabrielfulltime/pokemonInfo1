import 'package:flutter/cupertino.dart';
import 'package:pokebankv2/services/data_base/capturados_dao/pokemons_dao.dart';
import 'package:pokebankv2/services/http/pokemon_api_web/pokemon_api_web.dart';
import 'package:pokebankv2/services/http/transferidos/transfers_api_web.dart';

class AppDependencies extends InheritedWidget {
  final PokemonsDao pokemonsDao;
  final PokemonWebApi pokemonsWeb;
  final TransfersWeb transfersWeb;

  AppDependencies({
    required this.pokemonsDao,
    required this.transfersWeb,
    required this.pokemonsWeb,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return pokemonsDao != oldWidget.pokemonsDao ||
        pokemonsWeb != oldWidget.pokemonsWeb ||
        transfersWeb != oldWidget.transfersWeb ;
  }

  static AppDependencies? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppDependencies>();
}
