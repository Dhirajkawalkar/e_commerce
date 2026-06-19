/// A scrollable list that displays all items currently in the cart.
/// 
/// This widget uses a [ListView.builder] to efficiently render the list
/// of [CartItemWidget]s based on the items provided by the [CartBloc].
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import 'cart_item_widget.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    // Watches the CartBloc for changes and rebuilds when items are updated.
    final state = context.watch<CartBloc>().state;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final cartItem = state.items[index];
        return CartItemWidget(cartItem: cartItem);
      },
    );
  }
}

