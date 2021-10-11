import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokebankv2/models/provider/informacoes_conta.dart';
import 'package:pokebankv2/pages/dashboard/components/card_person.dart';
import 'package:pokebankv2/pages/dashboard/page/dashboard_container.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets("Deve mudar o nome do personagem, trocar a cor  e a foto do personagem", (WidgetTester tester) async {
    final Key malePersonContainerKey = Key("containerPersonagemMasculinoKey");
    final Key femalePersonContainerKey = Key("containerPersonagemFemininoKey");
    final Color blueColor = Colors.blue[100]!;
    final Color redColor = Colors.red[100]!;
    final Image femaleImage = Image.asset("images/leaf.png", width: 150, height: 150);
    final Image maleImage = Image.asset("images/red.png", width: 150, height: 150);
    final String textFemaleName = "LEAF";
    final String textMaleName = "RED";
    final Key cardPersonRowInfoPersonKey = Key("cardPersonRowInfoPersonNAMEKey");

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => InformacoesConta(isMasculino: false, namePerson: textFemaleName),
          ),
        ],
        child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: DashboarContainer()),
      ),
    );
    final cardPerson = await findCardPerson();
    findImageOf(femaleImage);
    findNamePerson(cardPersonRowInfoPersonKey, textFemaleName);
    await tester.tap(cardPerson);

    await tester.pumpAndSettle();

    final textField = findTextFieldByName();
    await tester.enterText(textField, textMaleName);

    final maleContainer = findContainer(malePersonContainerKey);
    final femaleContainer = findContainer(femalePersonContainerKey);
    isCorrectColor(redColor, malePersonContainerKey);
    await tester.tap(maleContainer);

    await tester.pumpAndSettle();

    isCorrectColor(blueColor, malePersonContainerKey);
    isCorrectColor(redColor, femalePersonContainerKey);
    await tester.tap(femaleContainer);

    await tester.pumpAndSettle();

    isCorrectColor(blueColor, femalePersonContainerKey);
    await tester.tap(maleContainer);

    await tester.pumpAndSettle();

    final buttonWithChangeCircle = find.byIcon(Icons.change_circle);
    expect(buttonWithChangeCircle, findsOneWidget);
    await tester.tap(buttonWithChangeCircle);

    await tester.pumpAndSettle();

    findImageOf(maleImage);
    findNamePerson(cardPersonRowInfoPersonKey, textMaleName);
  });
}











Finder findNamePerson(Key cardPersonRowInfoPersonKey, String insertInTextField) {
  final findNamePerson = find.byWidgetPredicate((widget) {
    if (widget is Text){
      return widget.key == cardPersonRowInfoPersonKey && widget.data == "NAME: $insertInTextField";
    }
    return false;
  });
  expect(findNamePerson, findsOneWidget);
  return findNamePerson;
}










void isCorrectColor(Color color, Key containerPersonKey) {
  final container = find.byWidgetPredicate((widget) {
    if (widget is Material) {
      return widget.color == color && widget.key == containerPersonKey;
    }
    return false;
  });
  expect(container, findsOneWidget);
}

Finder findContainer(Key containerPersonagemMasculinoKey) {
  final containerMasculino = find.byKey(containerPersonagemMasculinoKey);
  expect(containerMasculino, findsOneWidget);
  return containerMasculino;
}

Finder findTextFieldByName() {
  final textField = find.byWidgetPredicate((widget) {
    if (widget is TextField) {
      return widget.decoration!.labelText == "Nome que deseja ser chamado";
    }
    return false;
  });
  expect(textField, findsOneWidget);
  return textField;
}

void findImageOf(Image leafImage) {
  final personImage = find.byWidgetPredicate((widget) {
    return predicateImage(widget, leafImage);
  });
  expect(personImage, findsOneWidget);
}

Future<Finder> findCardPerson() async {
  final cardPerson = find.byType(CardPerson);
  expect(cardPerson, findsOneWidget);
  return cardPerson;
}




bool predicateImage(Widget widget, Image leafImage) {
  if (widget is Image) {
    if (widget.image is AssetImage) {
      final assetImage = widget.image;
      return assetImage == leafImage.image;
    }
  }
  return false;
}
