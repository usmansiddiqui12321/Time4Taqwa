import 'package:time4taqwa/exportall.dart';

class MasjidScreen extends StatefulWidget {
  const MasjidScreen({super.key});

  @override
  State<MasjidScreen> createState() => _MasjidScreenState();
}

class _MasjidScreenState extends State<MasjidScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(AllMasjidController());

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
              scaffoldKey.currentState?.openDrawer();
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
      drawer: const CustomDrawer(currentPage: "splash"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          GetBuilder(
              init: controller,
              builder: (controller) {
                return NeumorphicSearchField(
                    searchController: controller.searchController,
                    onSearchChanged: (result) {
                      controller.updatesearchresult(result);
                    });
              }),
          15.h.verticalSpace,
          SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: FutureBuilder(
              future: controller.getall(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  CustomWidgets.customsnackbar(
                      message: "NO DATA", isError: true);

                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.lightTextColor,
                  ));
                } else {
                  return GetBuilder(
                      init: controller,
                      builder: (controller) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data?.data?.mosques!.length ?? 0,
                          itemBuilder: (context, index) {
                            var name = snapshot
                                    .data?.data?.mosques?[index].mosqueName ??
                                "";
                            var timings =
                                snapshot.data?.data?.mosques?[index].timings ??
                                    [];
                            return snapshot
                                    .data!.data!.mosques![index].mosqueName!
                                    .toLowerCase()
                                    .contains(
                                        controller.searchresult.toLowerCase())
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => MasjidDetailPage(
                                              masjidname: name,
                                              masjidtimings: timings,
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
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 5,
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
                                              children: [
                                                const Icon(
                                                  Icons.access_time,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                                8.w.horizontalSpace,
                                                const Text(
                                                  'Prayer Timings:',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: timings
                                                  .map((timing) => Text(
                                                        timing,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          },
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
