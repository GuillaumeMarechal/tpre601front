import 'package:flutter_map/flutter_map.dart';
import 'MapInformationPosition.dart';

class MapInformations{
  MapInformationPosition position;
  List<Marker> markers;

  MapInformations(this.position, this.markers);
}