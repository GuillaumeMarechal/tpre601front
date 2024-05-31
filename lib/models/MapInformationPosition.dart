import 'package:geolocator/geolocator.dart';

class MapInformationPosition{
  double latitude;
  double longitude;

  MapInformationPosition(this.latitude, this.longitude);

  MapInformationPosition.fromPosition(Position position):
    this.latitude = position.latitude,
    this.longitude = position.longitude;
}