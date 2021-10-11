import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokebankv2/app_dependencies/app_dependencies.dart';
import 'package:pokebankv2/models/class/pokemon.dart';
import 'package:pokebankv2/models/class/transferidos.dart';
import 'package:pokebankv2/blocs/bloc_container.dart';
import 'package:pokebankv2/pages/pokemon_transfer_form/page/new_transfer_view.dart';
import 'package:pokebankv2/routes.dart';
import 'package:pokebankv2/services/http/transferidos/transfers_api_web.dart';


//Estados da screen TransactionsList
@immutable
abstract class TransactionListState {
  const TransactionListState();
}

@immutable
class InitTransactionListState extends TransactionListState {
  const InitTransactionListState();
}
@immutable
class LoadingTransactionListState extends TransactionListState {
  const LoadingTransactionListState();
}

@immutable
class LoadedTransactionListState extends TransactionListState {
  final List<Transfers> _transferidos;
  const LoadedTransactionListState(this._transferidos);
}

@immutable
class FatalErrorTransactionListState extends TransactionListState {
  const FatalErrorTransactionListState();
}


class TransactionsListContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    final TransfersWeb transfersWeb = AppDependencies.of(context)!.transfersWeb;
    return BlocProvider<TransactionsListCubit>(
      create: (BuildContext context) {
        final cubit = TransactionsListCubit();
        cubit.load(transfersWeb);
        return cubit;
      },
       child: TransactionsList(transfersWeb),);
  }
}

class TransactionsListCubit extends Cubit<TransactionListState> {
  TransactionsListCubit() : super(InitTransactionListState());

  void load(TransfersWeb transfersWeb)  async{
    emit(LoadingTransactionListState());
    await transfersWeb.findAll().then((transfers) => emit(LoadedTransactionListState(transfers)));
  }
}

class TransactionsList extends StatelessWidget {
  final transferidosWeb;
  TransactionsList(this.transferidosWeb);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.pushNamed(context, Routes.new_transfer_route);

            _updateScreen(context);
          }),
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: BlocBuilder<TransactionsListCubit, TransactionListState>(
          builder: (BuildContext context, state) {
            if (state is InitTransactionListState || state is LoadingTransactionListState){

              return CircularProgressIndicator();
            }
            if (state is LoadedTransactionListState){
                final List<Transfers>? transactions = state._transferidos;
                if (transactions == null) {
                  return Container();
                }
                if (transactions.isEmpty) {
                  return Container();
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Transfers transaction = transactions[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.monetization_on),
                        title: Text(
                          transaction.nomeTransferidos,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          transaction.idTransferidos.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: transactions.length,
                );
            }
            return Container();
          }),
    );
  }

  void _updateScreen(BuildContext context) {
    context.read<TransactionsListCubit>().load(transferidosWeb);
  }
}

class Transaction {
  final double value;
  final Pokemon pokemon;

  Transaction(this.value,
      this.pokemon,);

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $pokemon}';
  }
}
