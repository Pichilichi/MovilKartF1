import 'package:flutter/material.dart';
import '../models/equipments.dart';

class EquipmentTile extends StatelessWidget{
  Equipments equip;
  EquipmentTile({super.key, required this.equip});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 25),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children:[

        ],
      ),
    );
  }
  
}