import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  bool pop() {
    return _navigationKey.currentState.pop() as bool;
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateTopopAndPushNamed(String routeName,
      {dynamic arguments}) {
    return _navigationKey.currentState
        .popAndPushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateTopushReplacementNamed(String routeName,
      {dynamic arguments}) {
    return _navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> myarguments() {
    if (_navigationKey == null) if (_navigationKey.currentContext == null)
      return ModalRoute.of(_navigationKey.currentState.overlay.context)
          .settings
          .arguments;
    //final context = _navigationKey.currentState.overlay.context;
    return ModalRoute.of(_navigationKey.currentState.overlay.context)
        .settings
        .arguments;
  }
}
