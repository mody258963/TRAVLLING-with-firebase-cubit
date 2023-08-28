import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traelling_app/prestation_layer/screns/OTP.dart';
import 'package:traelling_app/prestation_layer/screns/posters.dart';

import '../screns/PosterDetals.dart';
import '../screns/login.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ,
                  child: LoginScreen(),
                ));
    }
    switch (settings.name) {
      case '/Poster':
        return MaterialPageRoute(builder: (_) => Posters());
    }
    switch (settings.name) {
      case '/Detals':
        return MaterialPageRoute(builder: (_) => PosterDetals());
    }
    switch (settings.name) {
      case '/OPT':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ,
                  child: OPTverify(),
                ));
    }
  }
}
