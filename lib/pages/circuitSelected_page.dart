import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartf1/models/circuits.dart';
import 'package:map_launcher/map_launcher.dart';

// SELECTED CIRCUIT CLASS
class CircuitSelectedPage extends StatelessWidget {
  
  // Allows the user to open a map application based on the circuit
  openMapsSheet(context, lat, lon, name) async {
    try {
      final coords = Coords(lat, lon);
      final title = "$name";
      final availableMaps = await MapLauncher.installedMaps;
        
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: coords,
                        title: title,
                      ),
                      title: Text(map.mapName),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // CIRCUIT PAGE
  const CircuitSelectedPage({super.key, required this.c});

  final Circuits c;

  // Circuit build
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(c.name),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 24, 
          color: Colors.black),
      ),

      backgroundColor: Colors.white,

      body: Column(
        children: [
          Image.network("https://pacou.pythonanywhere.com${c.img}"),

          Text(c.name),

          Text(c.body),

          MaterialButton(
              onPressed: () => openMapsSheet(context, c.latitude, c.longitude, c.name),
              child: const Text('Show Maps'),
          ),
        ],  
      ),
    );
  }
}