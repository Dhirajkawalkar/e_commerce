/// The Cart screen of the application.
/// 
/// This screen displays the list of items the user has added to their cart.
/// It uses a [BlocBuilder] to listen to [CartBloc] and shows an empty state
/// view if the cart is empty, or a list of items and a summary if not.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_list.dart';
import '../widgets/cart_summary.dart';
import '../widgets/empty_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          // Show empty cart view if no items are present.
          if (state.items.isEmpty) {
            return const EmptyCart();
          }

          // Show the list of cart items and the price summary.
          return const Column(
            children: [
              Expanded(
                child: CartList(),
              ),
              CartSummary(),
            ],
          );
        },
      ),
    );
  }
}
