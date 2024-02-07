import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Point source = const Point(
    latitude: 41.2858305,
    longitude: 69.2035464,
  );

  Point destination = const Point(latitude: 40.54781, longitude: 70.98142);

  YandexMapController? mapController;

  var route = const PolylineMapObject(
      mapId: MapObjectId('route'), polyline: Polyline(points: []));

  Future<void> getRoute() async {
    final routeRequest = YandexDriving.requestRoutes(
        points: [
          RequestPoint(
              point: source, requestPointType: RequestPointType.wayPoint),
          RequestPoint(
              point: destination, requestPointType: RequestPointType.wayPoint)
        ],
        drivingOptions: const DrivingOptions(
          initialAzimuth: 0,
          routesCount: 1,
          avoidTolls: true,
        ));
    final result = await routeRequest.result;
    print("Length: ${result.routes?.first}");
    print(result.routes?.first);
    route = PolylineMapObject(
      mapId: const MapObjectId("route"),
      strokeColor: Colors.red,
      strokeWidth: 3,
      polyline: Polyline(
        points: result.routes?.first.geometry ?? [],
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        mapObjects: [
          CircleMapObject(
            mapId: const MapObjectId('source'),
            fillColor: Colors.blue.withOpacity(.3),
            circle: Circle(center: source, radius: 20),
          ),
          PlacemarkMapObject(
            mapId: MapObjectId("destination"),
            point: destination,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage("assets/rasm.jpg"),
                scale: .05,
              ),
            ),
          ),
          route,
        ],
        onMapCreated: (controller) async {
          mapController = controller;
          await controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: source, zoom: 17),
            ),
          );
          await getRoute();
        },
      ),
    );
  }
}
