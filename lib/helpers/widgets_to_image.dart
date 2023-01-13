import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/markers/markers.dart';
import 'dart:ui' as ui;


Future<BitmapDescriptor> getStartCustomMarker(int minuts, String destination) async{


final recoder = ui.PictureRecorder();

final canvas= ui.Canvas(recoder);

const size=  ui.Size(350,150);

final startMarker= StartMarkerPainter(minuts: minuts, destination: destination);

startMarker.paint(canvas, size);

final picture= recoder.endRecording();

final image= await picture.toImage(size.width.toInt(), size.height.toInt());

final byteData= await image.toByteData(format: ui.ImageByteFormat.png);


return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

}


Future<BitmapDescriptor> getEndCustomMarker(int km, String destination) async{


final recoder = ui.PictureRecorder();

final canvas= ui.Canvas(recoder);

const size=  ui.Size(350,150);

final endMarker= EndMarkerPainter(kilometers: km, destination: destination);

endMarker.paint(canvas, size);

final picture= recoder.endRecording();

final image= await picture.toImage(size.width.toInt(), size.height.toInt());

final byteData= await image.toByteData(format: ui.ImageByteFormat.png);


return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

}