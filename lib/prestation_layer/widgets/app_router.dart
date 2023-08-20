import 'package:flutter/material.dart';
import 'package:traelling_app/prestation_layer/screns/posters.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Posters());
    }
  }
}
