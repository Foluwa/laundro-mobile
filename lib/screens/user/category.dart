import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundro/utils/constants.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Constants.primaryColor,
          title: const Text('Laundro'),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.of(context).pushNamed('/search');
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.of(context).pushNamed('/order_history');
                },
                icon: const Icon(Icons.history)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/account');
                },
                icon: const Icon(Icons.person)),
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicatorWeight: 10.0,
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.person),
                text: 'Incoming Call',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Outgoing Call',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Missed Call',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Missed Call1',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Missed Call',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Missed Call3',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildListViewWithName('Incoming Call'),
            _buildListViewWithName('Outgoing Call'),
            _buildListViewWithName('Missed Call0'),
            _buildListViewWithName('Missed Call1'),
            _buildListViewWithName('Missed Call2'),
            _buildListViewWithName('Missed Call3'),
          ],
        ),
      ),
    );
  }

  ListView _buildListViewWithName(String s) {
    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
              title: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/category_details');
                  },
                  child: Text(s + ' $index')),
            ));
  }
}
