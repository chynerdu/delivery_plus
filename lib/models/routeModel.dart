class SearchRoute {
  final int? id;
  final String? startLatitude;
  final String? endLatitude;
  final String? startLongitude;
  final String? endLongitude;
  final String? startLocationText;
  final String? endLocationText;
  final int? weight;

  SearchRoute(
      {this.id,
      this.startLatitude,
      this.endLatitude,
      this.startLocationText,
      this.endLocationText,
      this.startLongitude,
      this.endLongitude,
      this.weight});

  SearchRoute.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        startLatitude = item["startLatitude"],
        endLatitude = item['endLatitude'],
        startLocationText = item["startLocationText"],
        endLocationText = item['endLocationText'],
        startLongitude = item['startLongitude'],
        endLongitude = item['endLongitude'],
        weight = item['weight'];

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'endLatitude': endLatitude,
      'startLatitude': startLatitude,
      'startLongitude': startLongitude,
      'endLongitude': endLongitude,
      'startLocationText': startLocationText,
      'endLocationText': endLocationText,
      'weight': weight
    };
  }
}
