import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class OpenCamera extends StatefulWidget {
  @override
  _OpenCameraState createState() => _OpenCameraState();
}

class _OpenCameraState extends State<OpenCamera> {
  CameraController controllerCamera;

  Future<void> initializeCamera() async {
    var cameras = await availableCameras();
    controllerCamera = CameraController(cameras[0], ResolutionPreset.medium);
    await controllerCamera.initialize();
  }

  @override
  void dispose() {
    controllerCamera.dispose();
    super.dispose();
  }

  Future<File> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String directoryPath = '${root.path}/Guided_Camera';
    await Directory(directoryPath).create(recursive: true);
    String filePath = '$directoryPath/${DateTime.now()}.jpg';

    try {
      controllerCamera.takePicture(filePath);
    } catch (e) {
      return null;
    }

    return File(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: initializeCamera(),
        builder: (_, snapshot) =>
            (snapshot.connectionState == ConnectionState.done)
                ? Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width /
                            controllerCamera.value.aspectRatio,
                        child: CameraPreview(controllerCamera),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.2),
                        child: RaisedButton(
                          onPressed: () async {
                            if (!controllerCamera.value.isTakingPicture) {
                              File result = await takePicture();
                              Navigator.pop(context, result);
                            }
                          },
                          shape: CircleBorder(),
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}
