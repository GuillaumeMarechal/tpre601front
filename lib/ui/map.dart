import 'package:arosaje/models/MapInformationPosition.dart';
import 'package:arosaje/ui/services/PlanteService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import '../models/map_informations.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  late Future<MapInformations> mapInformation;
  PlanteService planteService = PlanteService();
  late Future<String> locationPermissionResult;

  @override
  void initState() {
    super.initState();
    mapInformation = planteService.fetchMapInformation();
    locationPermissionResult = LocationPermissionCheck();
  }

  Future<String> LocationPermissionCheck() async{
    LocationPermission permission;
    bool serviceEnabled;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
      return 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
        return 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print('Location permissions are permanently denied, we cannot request permissions.');
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }
    return "ok";
  }
  
  Widget getMap(MapInformations mapInformations){
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
        future: locationPermissionResult,
        builder: (context, snapshot){
          if(snapshot.hasData){
            if(snapshot.data! == "ok"){
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
            else{
              return Text(snapshot.data!);
            }
          }
          else if(snapshot.hasError){
            return Text('Une erreur s\'est produite : ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }
    );
  }
}
