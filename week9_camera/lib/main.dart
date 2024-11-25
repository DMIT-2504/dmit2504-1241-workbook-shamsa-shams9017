import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:week9_camera/camera_page.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(CameraApp(description: _cameras[0]));
}

/// CameraApp is the Main Application.
class CameraApp extends StatelessWidget {
  const CameraApp({required this.description, super.key});

  final CameraDescription description;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Application',
      home: CameraPage(
        description: description,
      ),
    );
  }
}
