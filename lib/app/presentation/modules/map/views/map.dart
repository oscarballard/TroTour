import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

import '../../../../data/datasource/Location.dart';
import '../../../../data/datasource/database.dart';
import '../../../../my_app.dart';
import '../../../routes/routes.dart';
import '../../location/viewmodel/location_edit_arguments.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _controller;
  TextEditingController controller = TextEditingController();
  late List<Locations> locations;
  final Map<String,Marker> _marker = {};

  late LatLng _center;
  late bool _loading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TropiTour"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ink(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.person),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.signIn);
                },
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child:
            _loading ? const CircularProgressIndicator() : builderMap(context),
      ),
    );
  }

  Future<void> _init() async {
    _center   = await Injector.of(context).geolocationRepository.geoLocation;
    locations = await LocationDatabase.instance.readAll();
    await _buildMarkers();
    setState(() {
      _loading = false;
    });
  }

  Stack builderMap(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(target: _center, zoom: 14),
          onMapCreated: (controller) async {
            _controller = controller;
          },
          markers: _marker.values.toSet(),
          onTap: (position) async {
            // Obtener detalles de la ubicación tocada
            List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude,
              position.longitude,
            );

            // Mostrar cuadro de diálogo con información de ubicación
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Información del lugar'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'Dirección: ${placemarks.first.street ?? 'Desconocida'}'),
                      Text(
                          'Ciudad: ${placemarks.first.locality ?? 'Desconocida'}'),
                      Text(
                          'País: ${placemarks.first.country ?? 'Desconocido'}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.locationEdit,
                              arguments: LocationEditArguments(
                                lat: position.latitude,
                                lng: position.longitude,
                              ));
                        },
                        child: const Text('Guardar Ubicacion'),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          top: 30.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: GooglePlaceAutoCompleteTextField(
              textEditingController: controller,
              inputDecoration: const InputDecoration(
                hintText: "Introduzca la Direccion",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                // suffixIcon: IconButton(
                //   icon: const Icon(Icons.search),
                //   onPressed: searchChadNavigate,
                //   iconSize: 30.0,
                // ),
              ),
              googleAPIKey: 'AIzaSyBm-8eqT2bnnir55JVccwcsqd61HNDFYq4',
              countries: const ["dom"],
            ),
          ),
        )
      ],
    );
  }

  addMarker(String id, LatLng location, String title, String descripcion, String img) {
    return Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(
        title: title,
        snippet: descripcion,
        onTap: () {
          // Mostrar la imagen en un cuadro de diálogo cuando se toca la ventana de información
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title),
                    Image.network(img),  // Mostrar la imagen desde la URL
                    Text(descripcion),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _buildMarkers() async{

    for(var location in locations){
      var marker = addMarker(location.id.toString(), LatLng(location.lat, location.lng), location.title, location.descripcion,location.pathImage);
      _marker[location.id.toString()] = marker;
    }
  }
}
