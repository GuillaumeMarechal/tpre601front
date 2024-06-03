import 'dart:convert';

import 'package:arosaje/models/MapInformationPosition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

import '../models/MapInformations.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Future<MapInformations> mapInformation = getMapInformation();

  static Future<MapInformations> getMapInformation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final response = await http.post(
        Uri.parse("http://localhost:8080/plantes/position"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "latitude" : position.latitude,
          "longitude" : position.longitude,
          "portee" : 4,
        })
    );
    if(response.statusCode == 200){
      List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
      List<Marker> markers = json.map((e) => Marker(
          point: LatLng(e["latitude"], e["longitude"]),
          child: const Icon(Icons.pin_drop)
      )).toList();
      return MapInformations(MapInformationPosition.fromPosition(position), markers);
    }
    else{
      throw Exception('Failed to get markers');
    }
  }
  
  static Widget getMap(MapInformations mapInformations){
    return FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(mapInformations.position.latitude, mapInformations.position.longitude),
          initialZoom: 18,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.epsi',
          ),
          SuperclusterLayer.immutable(
            initialMarkers: mapInformations.markers,
            clusterWidgetSize: const Size(40, 40),
            indexBuilder: IndexBuilders.computeWithOriginalMarkers,
            builder: (context, _, markerCount, extraClusterData) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    markerCount.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
          CurrentLocationLayer(),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              )
            ]
          )
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mapInformation,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              final data = snapshot.data as MapInformations;
              return Center(
                child: getMap(data),
              );
            }
          }
          return getMap(MapInformations(MapInformationPosition(0,0), []));
        });
  }
}
