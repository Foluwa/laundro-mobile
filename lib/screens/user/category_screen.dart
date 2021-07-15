import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String title = 'title';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel)),
          title: Text(title),
          pinned: true,
          floating: true,
          flexibleSpace: const Placeholder(),
          // Make the initial height of the SliverAppBar larger than normal.
          expandedHeight: 200,
        ),
        // Next, create a SliverList
        SliverList(
          // Use a delegate to build items as they're scrolled on screen.
          delegate: SliverChildBuilderDelegate(
            // The builder function returns a ListTile with a title that
            // displays the index of the current item.
            (context, index) => ListTile(title: Text('Item #$index')),
            // Builds 1000 ListTiles
            childCount: 1000,
          ),
        ),
      ],
    ));
  }
}
