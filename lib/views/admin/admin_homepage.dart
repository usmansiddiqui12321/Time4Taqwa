import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/views/admin/create_post.dart';
import 'package:time4taqwa/views/admin/detail_page.dart';
import 'package:time4taqwa/views/admin/your_posts.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});
  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage>
    with SingleTickerProviderStateMixin {
  final caretakerController = Get.put(AuthController());
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this); // Number of tabs

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        centerTitle: true,
        title: const Text(lsk.appname),
        actions: [
          InkWell(
            onTap: () {
              CustomDialogBox.logoutDialogBox(context);
            },
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.transparent),
              child: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
            ).paddingOnly(right: 15.w),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Your Posts',
            ),
            Tab(text: 'Create Posts'),
            Tab(text: 'Details'),
          ],
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (_tabController.index != 0) {
            _tabController.animateTo(0);
          } else {}
        },
        child: TabBarView(
          controller: _tabController,
          children: [
            YourPosts(tabController: _tabController),
            CreatePost(
              masjidname: caretakerController
                      .caretakerloginmodel.value.data?.mosque?.mosqueName ??
                  "",
              tabController: _tabController,
            ),
            DetailPage(
              tabController: _tabController,
            )
          ],
        ),
      ),
    );
  }
}
