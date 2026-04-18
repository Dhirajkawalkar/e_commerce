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
          if (state.items.isEmpty) {
            return const EmptyCart();
          }

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
