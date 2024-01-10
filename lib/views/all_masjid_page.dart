import 'package:time4taqwa/controllers/allmasjid_controller.dart';
import 'package:time4taqwa/exportall.dart';

class MasjidScreen extends StatefulWidget {
  const MasjidScreen({super.key});

  @override
  State<MasjidScreen> createState() => _MasjidScreenState();
}

class _MasjidScreenState extends State<MasjidScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final themecontroller = ThemeController();
  final searchController = TextEditingController();
  final controller = Get.put(AllMasjidController());
  final List resultData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        physics: const BouncingScrollPhysics(),
        children: [
          const NeumorphicSearchField(),
          15.h.verticalSpace,
          // Expanded(
          //   child: ListTile(
          //     title: AuthField(
          //       title: "Search",
          //       hintText: "🔍  Search restaurant by Name, Km, Rating ",
          //       controller: searchController,
          //       isPassword: false,
          //       titleColor: Colors.transparent,
          //     ),
          //     trailing: IconButton(
          //         icon: const Icon(
          //           Icons.clear,
          //           color: Colors.white,
          //         ),
          //         onPressed: () {}),
          //   ),
          // ),
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
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.data?.mosques?.length,
                    itemBuilder: (context, index) {
                      var name =
                          snapshot.data?.data?.mosques?[index].mosqueName;
                      // var id = snapshot.data?.data?.mosques?[index].id;
                      var timings =
                          snapshot.data?.data?.mosques?[index].timings;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: const Color(0xFF121931),
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: timings
                                        ?.map((timing) => Text(
                                              timing,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class NeumorphicSearchField extends StatelessWidget {
  const NeumorphicSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: TextField(
        onChanged: (value) {},
        style: const TextStyle(fontSize: 16, color: Colors.white),
        textAlignVertical: TextAlignVertical.center,
        controller: TextEditingController(),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 3),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: 'Search',
            suffixIcon: Container(
              width: 70,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color(0XFF5E5E5E),
                    Color(0XFF3E3E3E),
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  borderRadius: BorderRadius.circular(30)),
              child: const Icon(Icons.search, color: AppColors.lightTextColor),
            ),
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey)),
      ),
    );
  }
}

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Color? color;
  const PrimaryContainer({
    super.key,
    this.radius,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 30),
        boxShadow: [
          BoxShadow(
            color: color ?? const Color(0XFF1E1E1E),
          ),
          const BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 0,
            color: AppColors.kGrey100,
            // inset: true,
          ),
        ],
      ),
      child: child,
    );
  }
}
