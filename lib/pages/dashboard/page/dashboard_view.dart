import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokebankv2/blocs/bloc_container.dart';
import 'package:pokebankv2/models/provider/informacoes_conta.dart';
import 'package:pokebankv2/pages/dashboard/components/card_person.dart';
import 'package:pokebankv2/pages/dashboard/page/transferidos_component.dart';
import 'package:pokebankv2/pages/name.dart';
import 'package:pokebankv2/pages/transfer_list/transfers_list.dart';
import 'package:pokebankv2/routes.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext contextBloc) {
    return Scaffold(
      appBar: AppBar(
        title: Container(width: 1000, child: Text("Pokemon")),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                      color: Colors.lightBlue[500],
                      child: InkWell(
                        child: Consumer<InformacoesConta>(
                          builder: (BuildContext context, informacoes, Widget? child) {
                            return CardPerson(
                                isMasculinho: informacoes.isMasculino,
                                pokedexCatch: informacoes.pokedexCatch,
                                money: informacoes.money,
                                namePerson: informacoes.namePerson);
                          },
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, Routes.name_view_route);
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: transferidos(contextBloc),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timePokemon() {
    return Container(
        //Pokemons a partir de uma transição horizontal
        );
  }

  Widget transferidos(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () {
          push(context, TransactionsListContainer());
        },
        child: TransferidosFeature(AppLocalizations.of(context)!.transfers),
      ),
    );
  }
}
