import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kasambahayko/src/common_widgets/distance_calculator/calculator.dart';

class LocationService {
  static Future<Map<String, dynamic>> loadJsonData() async {
    final jsonString = await rootBundle
        .loadString('assets/data/region-viii-with-coordinates.json');
    final jsonData = json.decode(jsonString);
    return jsonData;
  }

  static Future<Map<String, dynamic>> getCoordinates(
      String province, String municipality) async {
    final regionVIIIJson = await loadJsonData();
    final municipalityData =
        regionVIIIJson[province]['municipality_list'][municipality];
    final double lat = municipalityData['lat'];
    final double long = municipalityData['long'];
    return {'lat': lat, 'long': long};
  }

  static Future<List<Map<String, dynamic>>>
      calculateDistancesToAllMunicipalities(
          String province, String municipality) async {
    final regionVIIIJson = await loadJsonData();
    final municipalityData =
        regionVIIIJson[province]['municipality_list'][municipality];
    final double lat = municipalityData['lat'];
    final double long = municipalityData['long'];
    final distances = <Map<String, dynamic>>[];
    for (final municipality
        in regionVIIIJson[province]['municipality_list'].keys) {
      final municipalityData =
          regionVIIIJson[province]['municipality_list'][municipality];
      final double lat2 = municipalityData['lat'];
      final double long2 = municipalityData['long'];
      final double distanceVal =
          DistanceCalculator.calculateDistance(lat, long, lat2, long2);
      distances
          .add({'municipality': municipality, 'distance_val': distanceVal});
    }
    return distances;
  }

  static Future<double> calculateDistanceToMunicipality(
      String province, String fromMunicipal, String toMunicipal) async {
    final regionVIIIJson = await loadJsonData();
    final fromMunicipalData =
        regionVIIIJson[province]['municipality_list'][fromMunicipal];
    final toMunicipalData =
        regionVIIIJson[province]['municipality_list'][toMunicipal];
    final double lat = fromMunicipalData['lat'];
    final double long = fromMunicipalData['long'];
    final double lat2 = toMunicipalData['lat'];
    final double long2 = toMunicipalData['long'];
    final double distanceVal =
        DistanceCalculator.calculateDistance(lat, long, lat2, long2);
    return distanceVal;
  }

  static double getDistance(
      String cityMunicipality, List<Map<String, dynamic>> distances) {
    for (final distance in distances) {
      if (distance['municipality'] == cityMunicipality) {
        return distance['distance_val'];
      }
    }
    return 0.0;
  }

  static Future<List<Map<String, dynamic>>> fetchUserDistances(userInfo) async {
    const String province = 'LEYTE';
    final String municipality = userInfo['city'].toString();

    final distances =
        await LocationService.calculateDistancesToAllMunicipalities(
            province, municipality);

    return distances;
  }
}
