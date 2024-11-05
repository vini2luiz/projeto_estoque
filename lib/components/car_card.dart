import 'package:flutter/material.dart';
import '../models/car.dart';
import 'stock_status_indicator.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const CarCard({
    Key? key,
    required this.car,
    required this.onTap,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text('${car.brand} ${car.model}'),
        subtitle: Text(
          'Ano: ${car.year}\nPreço: R\$ ${car.price.toStringAsFixed(2)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StockStatusIndicator(quantity: car.quantity),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
