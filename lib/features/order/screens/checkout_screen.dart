import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../cart/bloc/cart_state.dart';
import '../widgets/order_summary_list.dart';
import '../widgets/order_total.dart';
import '../widgets/shipping_address.dart';

/// [CheckoutScreen] manages the final steps of a purchase.
/// It displays the shipping address, a summary of items being purchased,
/// and the total cost. It relies on [CartBloc] to get the current items.
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          // If the cart is empty, we shouldn't be here, but we handle it just in case.
          if (state.items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Displays and allows editing the shipping address.
                ShippingAddress(),
                SizedBox(height: 24),
                /// Lists all items in the current cart.
                Expanded(child: OrderSummaryList()),
                /// Shows the final price breakdown and the "Place Order" button.
                OrderTotal(),
              ],
            ),
          );
        },
      ),
    );
  }
}
