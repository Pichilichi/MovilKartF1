import 'package:flutter/material.dart';
import 'package:kartf1/models/cart.dart';
import 'package:kartf1/models/equipments.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  Equipments equip;
  CartItem({super.key,
  required this.equip,
  });

  @override
  State<CartItem> createState() => _CAartItemState();
}

class _CAartItemState extends State<CartItem> {

  void removeItemFromCart(){
    Provider.of<Cart>(context, listen: false).removeItemFromCart(widget.equip);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(widget.equip.name),
        subtitle: Text(widget.equip.price.toString() + '\€'),
        trailing: IconButton(
          icon: Icon(Icons.delete), 
          onPressed: removeItemFromCart,
        ),
      ),
    );
  }
}