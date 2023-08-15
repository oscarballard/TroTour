import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../data/datasource/Location.dart';
import '../../../../data/datasource/database.dart';
import '../../../global/widgets/image.dart';
import '../../../routes/routes.dart';
import '../viewmodel/location_edit_arguments.dart';

class LocationEditView extends StatefulWidget {
  const LocationEditView({super.key});

  @override
  _LocationFormState createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationEditView> {
  late int id;
  late String title;
  late double lat;
  late double lng;
  late String description;
  late File image;
  late TimeOfDay time;
  TextEditingController titleController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
  }

  void _imageController(File image) {
    image = image;
  }

  Future<void> _submitForm() async {
    final location = Locations(
      title: titleController.text,
      descripcion: descripcionController.text,
      lat: lat,
      lng: lng,
      pathImage: '',
    );

    await LocationDatabase.instance.create(location);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, Routes.map);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      final args =
          ModalRoute.of(context)!.settings.arguments as LocationEditArguments;
      lat = args.lat;
      lng = args.lng;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Form'),
      ),
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
              ),
              ImageSaveWidget(_imageController),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
