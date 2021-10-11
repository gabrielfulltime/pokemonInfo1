import 'package:flutter/material.dart';
import 'package:pokebankv2/pages/dashboard/components/card_person.dart';
import 'package:pokebankv2/pages/home/page/homescreen_view.dart';
import 'package:pokebankv2/pages/name.dart';
import 'package:pokebankv2/pages/pokemon_form/page/pokemon_form_view.dart';
import 'package:pokebankv2/pages/pokemon_transfer_form/page/new_transfer_view.dart';

class Routes {
  static const String home_screen_route = "/";
  static const String new_transfer_route = "/newTransfer";
  static const String pokemon_card_route = "/pokemonCard";
  static const String name_view_route = "/nameView";
  static const String pokemon_form_route = "/pokeForm";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case pokemon_form_route:
        return MaterialPageRoute(builder: (_) => PokemonForm());
      case home_screen_route:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case pokemon_card_route:
        return MaterialPageRoute(builder: (_) => NameView());
      case name_view_route:
        return MaterialPageRoute(builder: (_) => NameView());
      case new_transfer_route:
        return MaterialPageRoute(builder: (_) => NovaTransferencia());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text("No route defined "),
                  ),
                ));
    }
  }
}
