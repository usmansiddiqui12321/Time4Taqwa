import 'dart:async';
import 'package:time4taqwa/exportall.dart';

class MapRoutingController extends GetxController {
  final allMasjidController = AllMasjidController().obs;
  final markers = <Marker>[].obs;
  final mapController = Completer<GoogleMapController>().obs;

  Future<void> loadData() async {
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/mosque_small.png',
    );

    final allMasjids = await allMasjidController.value.getall();

    // Clear existing markers
    markers.clear();

    // Add user location marker
    final userLocation = await getUserLocation();
    markers.add(
      Marker(
        infoWindow: const InfoWindow(title: "My Location"),
        markerId: const MarkerId("0"),
        position: LatLng(userLocation.latitude, userLocation.longitude),
      ),
    );

    // Add markers from allMasjids data
    if (allMasjids?.data != null && allMasjids?.data?.mosques != null) {
      for (var mosque in allMasjids?.data?.mosques ?? []) {
        markers.add(
          Marker(
            icon: customIcon,
            markerId: MarkerId(mosque.id.toString()),
            position: LatLng(mosque.latitude, mosque.longitude),
            infoWindow: InfoWindow(
              title: mosque.mosqueName,
              onTap: () {
                Get.to(() => MasjidDetailPage(
                      masjidname: mosque.mosqueName,
                      fajar: mosque.Fajar,
                      isha: mosque.Esha,
                      jummah: mosque.Jummah,
                      maghrib: mosque.Maghrib,
                      zuhar: mosque.Zuhr,
                      asar: mosque.Asar,
                    ));
              },
            ),
            // Add other properties as needed
          ),
        );
      }
    }

    // Move camera to a position based on user location
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(userLocation.latitude, userLocation.longitude),
      zoom: 14,
    );

    final GoogleMapController controller = await mapController.value.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    update();
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {});
    return await Geolocator.getCurrentPosition();
  }
}
