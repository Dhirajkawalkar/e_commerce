import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cart/bloc/cart_bloc.dart';

class OrderSummaryList extends StatelessWidget {
  const OrderSummaryList({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.product.imageUrl),
                ),
                title: Text(item.product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text('Qty: ${item.quantity}'),
                trailing: Text('\$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
              );
            },
          ),
        ),
      ],
    );
  }
}

