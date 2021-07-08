import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tabs Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: const TabBar(
              isScrollable: true,
              indicatorWeight: 10.0,
              indicatorColor: Colors.black,
              tabs: <Widget>[
                Tab(
                  text: 'Incoming Call',
                ),
                Tab(
                  text: 'Outgoing Call',
                ),
                Tab(
                  text: 'Missed Call',
                ),
                Tab(
                  text: 'Missed Call1',
                ),
                Tab(
                  text: 'Missed Call',
                ),
                Tab(
                  text: 'Missed Call3',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              _buildListViewWithName('Incoming Call'),
              _buildListViewWithName('Outgoing Call'),
              _buildListViewWithName('Missed Call'),
              _buildListViewWithName('Missed Call1'),
              _buildListViewWithName('Missed Call2'),
              _buildListViewWithName('Missed Call3'),
            ],
          )),
    );
  }

  ListView _buildListViewWithName(String s) {
    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
              title: Text(s + ' $index'),
            ));
  }
}
