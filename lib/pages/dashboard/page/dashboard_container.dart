import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokebankv2/blocs/bloc_container.dart';
import 'package:pokebankv2/models/cubit/name.dart';
import 'package:pokebankv2/pages/dashboard/page/dashboard_view.dart';

class DashboarContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Red"),
      child: DashboardView(),
    );
  }
}