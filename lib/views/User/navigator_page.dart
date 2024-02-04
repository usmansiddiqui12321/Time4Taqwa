import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/views/User/search_masjid_screen.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  final controller = Get.put(RoutingController());
  final List<Widget> screens = [
    const HomePage(),
    const SearchMasjidScreen(),
    const DonationPage(),
    const MapRoutingPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: RoutingController(),
        builder: (controller) {
          return screens[controller.currentbottom];
        },
      ),
      bottomNavigationBar: GetBuilder(
        init: RoutingController(),
        builder: (controller) {
          return BottomNavigationBar(
            // type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xff121931),
            unselectedIconTheme:
                const IconThemeData(color: AppColors.lightTextColor),
            unselectedLabelStyle:
                const TextStyle(color: AppColors.lightTextColor),
            selectedIconTheme: const IconThemeData(color: Colors.white),
            selectedLabelStyle: const TextStyle(color: Colors.white),
            selectedItemColor: Colors.white,
            unselectedItemColor: AppColors.lightTextColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: (index) {
              controller.setCurrentBottom(index);
              controller.setCurrentDrawer(index);
            },

            currentIndex: controller.currentbottom,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/donation.png')),
                label: 'Donations',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/mosque.png')),
                label: 'Mosques',
              ),
            ],
          );
        },
      ),
    );
  }
}
