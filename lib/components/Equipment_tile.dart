import 'package:flutter/material.dart';
import '../models/equipments.dart';

// CLASS FOR EQUIPMENT
class EquipmentTile extends StatelessWidget{
  Equipments equip;
  EquipmentTile({super.key, required this.equip});

  // EquipmentTile build
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children:[

        ],
      ),
    );
  }
  
}