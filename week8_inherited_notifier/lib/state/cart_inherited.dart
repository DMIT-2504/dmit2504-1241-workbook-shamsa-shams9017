import 'package:flutter/material.dart';
import 'package:week8_inherited_notifier/state/cart_state.dart';

// InheritedNotifier is a type of widget that listens to a Listenable object 
// and propagates changes to its descendants. 
// Whenever the Listenable object notifies that its state has changed, 
// the InheritedNotifier can trigger a rebuild of its descendant widgets that depend on it.
// it is typically used to allow parts of the widget tree to listen for state changes 
// without explicitly passing data down through constructors.
//  When CartStateHandler calls notifyListeners(), the InheritedNotifier listens for that change 
//  and, if appropriate, rebuilds its descendant widgets.
class CartNotifier extends InheritedNotifier<CartStateHandler> {
  const CartNotifier({
    Key? key,
    required CartStateHandler notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static CartStateHandler of(BuildContext context) {
    // this method finds the nearest CartNotifier widget in the widget tree and then retrieves its notifier.
    return context.dependOnInheritedWidgetOfExactType<CartNotifier>()!.notifier!;
  }

  @override
  // this method determines whether widgets that 
  // depend on this InheritedNotifier should rebuild when the notifier changes.
  bool updateShouldNotify(InheritedNotifier<CartStateHandler> oldWidget) {
    return true;
  }
}
