import 'package:flutter/material.dart';
import 'package:pokebankv2/pages/dashboard/page/dashboard_container.dart';
import 'package:pokebankv2/pages/pokedex_list/page/pokedex_list_container.dart';
import 'package:pokebankv2/pages/pokedex_list/page/pokedex_list_view.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_container.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_view.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indexAt = 0;

  final List<Widget> _indexList = [
    DashboarContainer(),
    PokemonListContainer(),
    PokedexListView()
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        body: _indexList[_indexAt],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex: _indexAt,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset("images/casaPallet.png", height: 30,),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("images/pokebola.png", height: 30),
              label: "Pokémon",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("images/logo_pokedex.png", height: 30,),
              label: "Pokédex",
            ),
          ],
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _indexAt = index;
    });
  }
}
