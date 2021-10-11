import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokebankv2/app_dependencies/app_dependencies.dart';
import 'package:pokebankv2/components/pokebank_theme.dart';
import 'package:pokebankv2/models/provider/informacoes_conta.dart';
import 'package:pokebankv2/pages/home/page/homescreen_view.dart';
import 'package:pokebankv2/routes.dart';
import 'package:pokebankv2/services/data_base/capturados_dao/pokemons_dao.dart';
import 'package:pokebankv2/services/http/pokemon_api_web/pokemon_api_web.dart';
import 'package:pokebankv2/services/http/transferidos/transfers_api_web.dart';
import 'package:pokebankv2/tela%20aleatoria.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => InformacoesConta(),
          ),
        ],
        child: PokebankApp(transfersWeb: TransfersWeb(), pokemonsDao: PokemonsDao(), pokemonsWeb:
        PokemonWebApi(), child: HomeScreen(),)
    ),
  );
}

class PokebankApp extends StatelessWidget {
  final PokemonsDao pokemonsDao;
  final TransfersWeb transfersWeb;
  final PokemonWebApi pokemonsWeb;
  final Widget child;

  PokebankApp({required this.pokemonsWeb, required this.transfersWeb, required this.pokemonsDao, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
        transfersWeb: transfersWeb,
        pokemonsDao: pokemonsDao,
        pokemonsWeb: pokemonsWeb,
        child: MaterialApp(
        onGenerateRoute: Routes.generateRoute,
        initialRoute: Routes.home_screen_route,
        theme: pokebankTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // home: PagedInfinitScroll(repository: PokemonWebApi(),)),
    ));
  }
}


// Excluir um pokemon_list
// http://www.macoratti.net/19/11/flut_dismiss1.htm

// Trazer images
// https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokeId.png"

// Trazer Gifs
// https://www.pkparaiso.com/imagenes/xy/sprites/animados/$pokeId.gif
