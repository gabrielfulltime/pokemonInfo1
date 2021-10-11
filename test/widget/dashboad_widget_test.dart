import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokebankv2/main.dart';
import 'package:pokebankv2/models/provider/informacoes_conta.dart';
import 'package:pokebankv2/pages/dashboard/components/card_person.dart';
import 'package:pokebankv2/pages/dashboard/page/dashboard_container.dart';
import 'package:pokebankv2/pages/dashboard/page/transferidos_component.dart';
import 'package:pokebankv2/pages/home/page/homescreen_view.dart';
import 'package:pokebankv2/services/http/transferidos/transfers_api_web.dart';

import 'package:provider/provider.dart';

import '../mocks/mocks.dart';

void main() {
  group("Testes voltados ao widget Dashboard", () {
    testWidgets("Deve Mostrar o cardPerson quando o dashboard é aberto", (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => InformacoesConta(),
              ),
            ],
            child: PokebankApp(
              transfersWeb: TransfersWeb(),
              pokemonsDao: PokemonsDaoMock(),
              pokemonsWeb: FetchPokemonsWebMock(),
              child: HomeScreen(),
            )),
      );
      final cardPerson = find.byType(CardPerson);
      expect(cardPerson, findsOneWidget);
    });
    testWidgets("Deve Mostrar a feature transfer_list quando o Dashboard é aberto", (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => InformacoesConta(),
              ),
            ],
            child: DashboarContainer(),
          ),
        ),
      );
      final featureTransferidos = find.byType(TransferidosFeature);
      expect(featureTransferidos, findsOneWidget);
    });
  });
}
