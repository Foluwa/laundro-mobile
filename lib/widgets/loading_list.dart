import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/constants.dart';

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({Key? key}) : super(key: key);
  @override
  _LoadingListPageState createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Loading List'),
      // ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Constants.silver, //Color(0xFFE0E0E0),
                highlightColor: Constants.silverhighlight,
                enabled: _enabled,
                child: ListView.builder(
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 48.0,
                          height: 48.0,
                          color: Constants.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Constants.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Constants.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: 40.0,
                                height: 8.0,
                                color: Constants.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: 6,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //   child: FlatButton(
            //       onPressed: () {
            //         setState(() {
            //           _enabled = !_enabled;
            //         });
            //       },
            //       child: Text(
            //         _enabled ? 'Stop' : 'Play',
            //         style: Theme.of(context).textTheme.button!.copyWith(
            //             fontSize: 18.0,
            //             color: _enabled ? Colors.redAccent : Colors.green),
            //       )),
            // )
          ],
        ),
      ),
    );
  }
}
