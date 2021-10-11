import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokebankv2/models/provider/informacoes_conta.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_view.dart';
import 'package:provider/provider.dart';

void main(){
  group("Testes se a lista de pokemons esta sendo exibida", (){
    final appBarText = "Seus pokemons";
    testWidgets("Deve mostrar AppBar com texto definido quando for aberto", (WidgetTester tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => InformacoesConta(),
          ),
        ],
        child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: PokemonListView()),
      ),);
      final appBar = find.widgetWithText(AppBar, appBarText);
      expect(appBar, findsOneWidget);
    });

  });
}