import 'dart:async';

import 'package:time4taqwa/exportall.dart';

class MapRoutingPage extends StatefulWidget {
  const MapRoutingPage({super.key});

  @override
  State<MapRoutingPage> createState() => _MapRoutingPageState();
}

class _MapRoutingPageState extends State<MapRoutingPage> {
  final allmasjidcontroller = Get.put(AllMasjidController());
  List<Marker> markers = [];

  Completer<GoogleMapController> mapcontroller = Completer();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/mosque_small.png',
    );
    final allMasjids = await allmasjidcontroller.getall();
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
                        fajar: mosque.fajar,
                        isha: mosque.esha,
                        jummah: mosque.jummah,
                        maghrib: mosque.maghrib,
                        zuhar: mosque.zuhr,
                        asar: mosque.asar,
                      ));
                }),
          ),
        );
      }
    }

    // Move camera to a position based on user location
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(userLocation.latitude, userLocation.longitude),
      zoom: 14,
    );
    final GoogleMapController controller = await mapcontroller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    setState(() {});
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {});
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 1,
            ),
            markers: Set<Marker>.of(markers),
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapcontroller.complete(controller);
            },
          ),
          Positioned(
            left: 130.w,
            top: 40.h,
            child: Center(
              child: Container(
                height: 50.h,
                width: 140.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.primaryColor),
                child: Center(
                    child: Text(
                  "Mosques",
                  style: TextStyle(fontSize: 20.sp),
                )),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          loadData();
        },
        child: const Icon(
          Icons.location_pin,
          color: Colors.white,
        ),
      ),
    );
  }
}
