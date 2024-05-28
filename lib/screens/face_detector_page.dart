// import 'dart:developer';

import 'dart:developer';

// import 'package:app/util/face_detector_painter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'camera_view.dart';

// import 'util/face_detector_painter.dart';

class FaceDetectorPage extends StatefulWidget {
  const FaceDetectorPage({Key? key}) : super(key: key);

  @override
  State<FaceDetectorPage> createState() => _FaceDetectorPageState();
}

class _FaceDetectorPageState extends State<FaceDetectorPage> {
  //create face detector object
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: false,
      enableClassification: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  // CustomPaint? _customPaint;
  String? _text;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Face Detector',
      // customPaint: _customPaint,
      text: _text,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      initialDirection: CameraLensDirection.front,
    );
  }

  Future<void> processImage(final InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = "";
    });
    final faces = await _faceDetector.processImage(inputImage);

    // ignore: unused_local_variable
    String text = 'face found ${faces.length}\n\n';
    for (final face in faces) {
      text += 'face ${face.boundingBox}\n';

      // log(face.landmarks.toString());
      // log(face.smilingProbability.toString());
      log(face.leftEyeOpenProbability.toString());
      // double rotationY = face.headEulerAngleY!;
      // double rotationX = face.headEulerAngleX!;
      // double rotationZ = face.headEulerAngleZ!;

      // Print face bounding box and rotation
      // log("Face bounding box: ${face.boundingBox}");
      // log("Face rotation (Y-axis): $rotationY");
      // log("Face rotation (X-axis): $rotationX");'
      // log("Face rotation (Z-axis): $rotationZ");
    }

    // if (inputImage.inputImageData?.size != null &&
    //     inputImage.inputImageData?.imageRotation != null) {
    //   // final painter = FaceDetectorPainter(
    //   //     faces,
    //   //     inputImage.inputImageData!.size,
    //   //     inputImage.inputImageData!.imageRotation);
    //   // _customPaint = CustomPaint(painter: painter);
    // } else {
    //   String text = 'face found ${faces.length}\n\n';
    //   for (final face in faces) {
    //     text += 'face ${face.boundingBox}\n\n';
    //   }

    //   _text = text;
    //   // _customPaint = null;
    // }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
