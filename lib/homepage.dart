import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double appBarOpacity = 1.0; // Initial opacity for smooth transition
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_updateAppBarOpacity);
  }

  @override
  void dispose() {
    scrollController.removeListener(_updateAppBarOpacity);
    scrollController.dispose();
    super.dispose();
  }

  void _updateAppBarOpacity() {
    setState(() {
      appBarOpacity = scrollController.hasClients &&
              scrollController.offset > (120 - kToolbarHeight)
          ? 0.0
          : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            collapsedHeight: 60,
            backgroundColor: Colors.orange.shade200,
            expandedHeight: 150,
            leading: const Icon(Icons.picture_in_picture_alt),
            actions: const [Icon(Icons.menu)],
            centerTitle: true,
            flexibleSpace: Stack(
              children: [
                AnimatedOpacity(
                  opacity: appBarOpacity,
                  duration: const Duration(milliseconds: 800),
                  child: Align(
                    alignment: Alignment.center,
                    child: Transform.scale(
                      scale: appBarOpacity,
                      child: Image.asset('assets/img/notification-removebg-preview.png'),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 60,
                    width: 200,
                    alignment: Alignment.center,
                    child:  Text(
                      'Notification',
                      style: TextStyle(fontSize:(appBarOpacity==0.0)?20 : 25),
                    ),
                  ),
                ),
              ],
            ),
            onStretchTrigger: () {
            print("fsd");
              return Future<void>.value();
            },
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              itemCount: 50,
              shrinkWrap: true, 
              physics: const NeverScrollableScrollPhysics(), 
              itemBuilder: (context, index) {
                return Text('index ==> ${index + 1}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
