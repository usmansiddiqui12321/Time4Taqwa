import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/views/admin/create_post.dart';
import 'package:time4taqwa/views/admin/your_posts.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage>
    with SingleTickerProviderStateMixin {
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
      body: TabBarView(
        controller: _tabController,
        children: [
          // Content of Tab 1
          YourPosts(tabController: _tabController),
          // Content of Tab 2
          CreatePost(),

          // Content of Tab 3
          Center(
            child: Text('Tab 3 Content'),
          ),
        ],
      ),
    );
  }
}
