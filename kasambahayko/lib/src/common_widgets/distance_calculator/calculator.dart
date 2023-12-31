import 'dart:math';

class DistanceCalculator {
  static calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // km
    double dLat = toRadians(lat2 - lat1);
    double dLon = toRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(toRadians(lat1)) *
            cos(toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = R * c;

    return double.parse(distance.toStringAsFixed(2));
  }

  static double toRadians(double degrees) {
    return degrees * (pi / 180);
  }
}
