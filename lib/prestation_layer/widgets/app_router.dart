import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traelling_app/bessnes_logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:traelling_app/bessnes_logic/uploding_data/uploding_data_cubit.dart';
import 'package:traelling_app/costanse/pages.dart';
import 'package:traelling_app/prestation_layer/screns/OTP.dart';
import 'package:traelling_app/prestation_layer/screns/adding.dart';
import 'package:traelling_app/prestation_layer/screns/posters.dart';

import '../screns/PosterDetals.dart';
import '../screns/login.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;
  UplodingDataCubit? uplodingDataCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
    uplodingDataCubit = UplodingDataCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case logain:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PhoneAuthCubit>.value(
                  value: phoneAuthCubit!,
                  child: const LoginScreen(),
                ));
      case Optpage:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PhoneAuthCubit>.value(
                  value: phoneAuthCubit!,
                  child: OPTverify(phoneNumber: phoneNumber),
                ));
      case posters:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PhoneAuthCubit>.value(
                  value: phoneAuthCubit!,
                  child: const Posters(),
                ));

      case postersDetals:
        return MaterialPageRoute(builder: (_) => const PosterDetals());

      case addingPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => uplodingDataCubit!,
                  child: const Addingpage(),
                ));
    }
    return null;
  }
}
