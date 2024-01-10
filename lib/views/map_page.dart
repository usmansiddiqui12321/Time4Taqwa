import 'dart:async';

import '../exportall.dart';

class MapRoutingPage extends StatefulWidget {
  const MapRoutingPage({super.key});

  @override
  State<MapRoutingPage> createState() => _MapRoutingPageState();
}

class _MapRoutingPageState extends State<MapRoutingPage> {
  //! WE WILL NEED THIS DATA FROM BACKEND
  List<Marker> markers = [];
  List<Marker> multipleLocations = const [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(24.937751837795904, 67.09412395096632),
      infoWindow: InfoWindow(title: "My Postion"),
    ),
  ];
  static CameraPosition initialposition = const CameraPosition(
    target: LatLng(24.937751837795904, 67.09412395096632),
    zoom: 14,
  );
  Completer<GoogleMapController> mapcontroller = Completer();
  @override
  void initState() {
    super.initState();
    markers.addAll(multipleLocations);
    loadData();
  }

  Future<void> loadData() async {
    // Add your custom marker icon
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/mosque_small.png', // Replace with your asset image path
    );
    getUserLocation().then((location) async {
      if (kDebugMode) {
        print('lat ${location.latitude} long ${location.longitude}');
      }
      markers.add(
        Marker(
          icon: customIcon,
          markerId: const MarkerId("6"),
          position: LatLng(location.latitude, location.longitude),
        ),
      );
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(location.latitude, location.longitude), zoom: 14);
      final GoogleMapController controller = await mapcontroller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
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
      body: GoogleMap(
        initialCameraPosition: initialposition,
        markers: Set<Marker>.of(markers),
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          mapcontroller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          // GoogleMapController controller = await mapcontroller.future;
          // controller.animateCamera(
          //   CameraUpdate.newCameraPosition(
          //     const CameraPosition(
          //         target: LatLng(24.910423161326893, 67.09737518036468),
          //         zoom: 14),
          //   ),
          // );
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
