import 'package:time4taqwa/exportall.dart';

class SearchMasjidScreen extends StatefulWidget {
  const SearchMasjidScreen({super.key});

  @override
  State<SearchMasjidScreen> createState() => _SearchMasjidScreenState();
}

class _SearchMasjidScreenState extends State<SearchMasjidScreen> {
  // var scaffoldKey = GlobalKey<ScaffoldState>();
  final getAllmasjidcontroller = Get.put(AllMasjidController());
  late Position currentPosition;
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    currentPosition = Position(
        longitude: 0.0,
        latitude: 0.0,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0);
    initial();

    super.initState();
  }

  Future<void> initial() async {
    currentPosition = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {});
    }
  }

  double calculateDistance(
      {required double startLatitude,
      required double startLongitude,
      required double endLatitude,
      required double endLongitude}) {
    double distance = Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
    double distanceInKm = distance / 1000;
    return distanceInKm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: GestureDetector(
            onTap: () {
              // scaffoldKey.currentState?.openDrawer();
              Scaffold.of(context).openDrawer();
              // }); // scaffoldKey.currentState?.openDrawer();
            },
            child: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage("assets/drawer.png")),
          ),
        ),
        title: Text(
          lsk.appname,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      drawer: const CustomDrawer(currentPage: dkeys.searchMasjid),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            GetBuilder(
                init: getAllmasjidcontroller,
                builder: (controller) {
                  return NeumorphicSearchField(
                      searchController: controller.searchController,
                      onSearchChanged: (result) {
                        controller.updatesearchresult(result);
                      });
                }),
            15.h.verticalSpace,
            getAllmasjidcontroller.isloading.value
                ? Center(
                    child: Padding(
                    padding: EdgeInsets.only(top: 0.3.sh),
                    child: CustomWidgets.isloading,
                  ))
                : SizedBox(
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: GetBuilder(
                        init: getAllmasjidcontroller,
                        builder: (controller) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: getAllmasjidcontroller.getallmasjidmodel
                                    .value.data?.mosques!.length ??
                                0,
                            itemBuilder: (context, index) {
                              var data = getAllmasjidcontroller
                                  .getallmasjidmodel
                                  .value
                                  .data
                                  ?.mosques?[index];
                              var name = data?.mosqueName ?? "";
                              var fajartime = data?.fajar ?? "";
                              var zuhrtime = data?.zuhr ?? "";
                              var asarTime = data?.asar ?? "";
                              var maghribTime = data?.maghrib ?? "";
                              var ishaTime = data?.esha ?? "";
                              var jummahTime = data?.jummah ?? "";
                              var distancelong = data?.longitude ?? 0.0;
                              var distancelang = data?.latitude ?? 0.0;
                              var distance = calculateDistance(
                                startLatitude: currentPosition.latitude,
                                startLongitude: currentPosition.longitude,
                                endLatitude: distancelang,
                                endLongitude: distancelong,
                              );

                              return getAllmasjidcontroller.getallmasjidmodel
                                      .value.data!.mosques![index].mosqueName!
                                      .toLowerCase()
                                      .contains(
                                          controller.searchresult.toLowerCase())
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => MasjidDetailPage(
                                                masjidname: name,
                                                fajar: fajartime,
                                                isha: ishaTime,
                                                jummah: jummahTime,
                                                maghrib: maghribTime,
                                                zuhar: zuhrtime,
                                                asar: asarTime,
                                              ));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(16.r),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF121931),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                spreadRadius: 2.r,
                                                blurRadius: 5.r,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              20.h.verticalSpace,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.place,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                      8.w.horizontalSpace,
                                                      Text(
                                                        '${distance.toStringAsFixed(2)} km Away',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text(
                                                    "View Details",
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            },
                          );
                        }))
          ],
        ),
      ),
    );
  }
}
