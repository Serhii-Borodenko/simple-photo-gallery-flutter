import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery_flutter/modules/photo_view_widget.dart';
import 'photo_view_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _controller;
  late bool isTop = false;
  late int initialCountGridView;
  late int initialCountListView;

  @override
  void initState() {
    initialCountGridView = 10;

    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.position.atEdge) {
      isTop = _controller.position.pixels == 0;

      if (!isTop) {
        changeShowMore();
      }
    }
  }

  changeShowMore() {
    setState(() {
      if (initialCountGridView < 100) {
        initialCountGridView = initialCountGridView + 10;
        print(initialCountGridView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("images")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        controller: _controller,
                        itemCount: 1,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: GridView.builder(
                            physics:
                                const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 7 / 6,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: snapshot.data!.docs[0].get('$index'),
                                imageBuilder: (context, imageProvider) =>
                                    RawMaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewScreen(
                                          snapshot: snapshot,
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: 'logo$index',
                                    child: PhotoViewWidget(
                                        imageProvider: imageProvider),
                                  ),
                                ),
                                placeholder: (context, url) => Container(),
                                errorWidget: (context, url, error) =>
                                    const PhotoViewWidget(
                                  imageProvider: AssetImage('images/img.png'),
                                ),
                              );
                            },
                            itemCount: initialCountGridView,
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            (initialCountGridView < 100 && !isTop)
                ? const Center(
                    child: Text(''),
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('En story'),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
