import 'package:flutter_riverpod/flutter_riverpod.dart';

/// logic class < State type>
class NavbarNotifier extends Notifier<String>{
  @override
  String build() {
    /// initial State
    return  'home';
  }

  /// Change active nav item
  void changeNavItem(String item) {
    state =  item;
  }
}

/// Global navbar state
final navbarProvider =
NotifierProvider<NavbarNotifier,String>(
    NavbarNotifier.new
);