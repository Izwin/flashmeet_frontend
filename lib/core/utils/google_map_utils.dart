import 'dart:typed_data';
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoogleMapUtils {
  static Future<BitmapDescriptor> getMarkerIcon(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    Uint8List bytes = response.bodyBytes;

    Codec codec = await instantiateImageCodec(bytes,targetWidth: 100);
    FrameInfo frameInfo = await codec.getNextFrame();
    Uint8List circleBytes = await convertToCircle(frameInfo.image);

    BitmapDescriptor bitmapDescriptor = BitmapDescriptor.bytes(circleBytes,width: 40,height: 40,);
    return bitmapDescriptor;
  }

  static Future<Uint8List> convertToCircle(Image image) async {
    final int size = 100;
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);

    final Paint paint = Paint()..isAntiAlias = true;
    double radius = size / 2;

    canvas.drawCircle(Offset(radius, radius), radius, paint);
    paint.blendMode = BlendMode.srcIn;

    Rect rect = Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble());
    canvas.drawImageRect(image, rect, rect, paint);

    Image newImage = await recorder.endRecording().toImage(size, size);
    ByteData? byteData = await newImage.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}