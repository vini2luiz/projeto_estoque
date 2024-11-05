import 'package:flutter/material.dart';

class StockStatusIndicator extends StatelessWidget {
  final int quantity;

  const StockStatusIndicator({
    Key? key,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    if (quantity > 10) {
      color = Colors.green;
      label = 'Normal';
    } else if (quantity > 5) {
      color = Colors.orange;
      label = 'Médio';
    } else {
      color = Colors.red;
      label = 'Baixo';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$quantity',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
