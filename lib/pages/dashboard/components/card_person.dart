import 'package:flutter/material.dart';
import 'package:pokebankv2/models/provider/informacoes_conta.dart';
import 'package:provider/provider.dart';

class CardPerson extends StatelessWidget {
  bool isMasculinho;

  String namePerson;

  double money;

  int pokedexCatch;

  String timeInGame = "${DateTime.now().minute}";

  List<int> listaCapturadosDex = [];

  CardPerson({this.isMasculinho = true, this.pokedexCatch = 0, this.money = 0, this.namePerson = "Red"});

  @override
  Widget build(BuildContext context) {
    return _cardPerson(context);
  }

  Widget _cardPerson(BuildContext context) {
    this.namePerson = Provider.of<InformacoesConta>(context).namePerson;
    this.isMasculinho = Provider.of<InformacoesConta>(context).isMasculino;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54, width: 4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          _headerCard(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoPerson(context),
              _spritePerson(context),
            ],
          ),
          _insignias()
        ],
      ),
    );
  }

  Widget _insignias() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, right: 8.0, left: 8.0, top: 8.0),
      child: SizedBox(
        height: 75,
        child: Container(
          decoration: BoxDecoration(color: Colors.lightBlue[100]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Insignias",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _boxInsignia(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _boxInsignia() {
    List<Widget> listInsignia = [];
    for (int i = 0; i <= 8; i++) {
      listInsignia.add(SizedBox(
        width: 32,
        height: 32,
        child: Container(
          alignment: Alignment.bottomRight,
          child: Text("$i"),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black87,
              ),
              borderRadius: BorderRadius.circular(5)),
        ),
      ));
    }
    return listInsignia;
  }

  Widget _spritePerson(context) {
    return Container(
        //apague o ! para a validação ficar correta
        child: Image.asset(
      Provider.of<InformacoesConta>(context).isMasculino ? "images/red.png" : "images/leaf.png",
      width: 150,
      height: 150,
    ));
  }

  Widget _infoPerson(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _rowInfo(),
    );
  }

  List<Widget> _rowInfo() {
    List<String> keys = ["NAME", "MONEY", "POKEDEX", "TIME"];
    List<String> values = [
      this.namePerson,
      this.money.toString(),
      this.pokedexCatch.toString(),
      this.timeInGame.toString()
    ];
    List<Widget> listRowInfo = [];
    for (int i = 0; i <= 3; i++) {
      Key cardPersonRowInfoPersonKey = Key("cardPersonRowInfoPerson" + keys[i] + "Key");
      listRowInfo.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              Icons.circle,
              color: Colors.blue[200],
            ),
            Container(
              child: Text("${keys[i]}: ${values[i]}",
                  key: cardPersonRowInfoPersonKey, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ));
    }
    return listRowInfo;
  }

  Widget _headerCard() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        right: 4.0,
        left: 4.0,
        bottom: 16.0,
      ),
      child: SizedBox(
        width: double.maxFinite,
        height: 56.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue[800],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "TRAINER CARD",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.orange[500],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.orange, width: 2),
                        bottom: BorderSide(color: Colors.orange, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40.0,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      " IDNo. 99999 ",
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
