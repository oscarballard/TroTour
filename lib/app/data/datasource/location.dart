const String tableLocations = 'Location';

class LocationField {
  static final List<String> value = [
    id,
    title,
    descripcion,
    lat,
    lng,
    pathImage,
  ];

  static const String id = "_id";
  static const String title = "_title";
  static const String descripcion = "_descripcion";
  static const String lat = "_lat";
  static const String lng = "_lng";
  static const String pathImage = "_pathImage";
}

class Locations {
  const Locations(
      {this.id,
      required this.title,
      required this.descripcion,
      required this.lng,
      required this.lat,
      required this.pathImage});
  final int? id;
  final String title;
  final String descripcion;
  final double lng;
  final double lat;
  final String pathImage;

  Locations copy({
    int? id,
    String? title,
    String? descripcion,
    double? lng,
    double? lat,
    String? pathImage,
  }) =>
      Locations(
        id: id ?? this.id,
        title: title ?? this.title,
        descripcion: descripcion ?? this.descripcion,
        lng: lng ?? this.lng,
        lat: lat ?? this.lat,
        pathImage: pathImage ?? this.pathImage,
      );

  Map<String, Object?> toJson() => {
        LocationField.id: id,
        LocationField.title: title,
        LocationField.descripcion: descripcion,
        LocationField.lng: lng,
        LocationField.lat: lat,
        LocationField.pathImage: pathImage,
      };

  static Locations fromJson(Map<String, Object?> json) => Locations(
        id: json[LocationField.id] as int?,
        title: json[LocationField.title] as String,
        descripcion: json[LocationField.descripcion] as String,
        lng: double.tryParse(json[LocationField.lng].toString()) ?? 0.0,
        lat: double.tryParse(json[LocationField.lat].toString()) ?? 0.0,
        pathImage: json[LocationField.pathImage] as String,
      );
}
