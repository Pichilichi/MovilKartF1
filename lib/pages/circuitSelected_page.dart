import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartf1/models/circuits.dart';
import 'package:map_launcher/map_launcher.dart';

class circuitSelectedPage extends StatelessWidget {
  // map
  openMapsSheet(context, lat, lon, name) async {
    try {
      final coords = Coords(lat, lon);
      final title = "${name}";
      final availableMaps = await MapLauncher.installedMaps;
        

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
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
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }


  // In the constructor, require a Todo.
  const circuitSelectedPage({super.key, required this.c});

  // Declare a field that holds the Todo.
  final Circuits c;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(c.name),
      ),
      body: Column(
        children: [
          Image.network("https://pacou.pythonanywhere.com${c.img}"),

          Text(c.name),

          Text(c.body),

          MaterialButton(
              onPressed: () => openMapsSheet(context, c.latitude, c.longitude, c.name),
              child: Text('Show Maps'),
            ),
        ],  
      ),
    );
  }
}