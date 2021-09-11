import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/constants.dart';
import '../utils/size_config.dart';

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({Key? key}) : super(key: key);
  @override
  _LoadingListPageState createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  final bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(SizeConfig.safeBlockHorizontal * 33.4);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child: Shimmer.fromColors(
                  baseColor: Constants.silver,
                  highlightColor: Constants.silverhighlight,
                  enabled: _enabled,
                  child: ListView.builder(
                    itemBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height:
                                SizeConfig.safeBlockHorizontal * 33.4, //120.0,
                            color: Constants.white)),
                    itemCount: 8,
                  )))
        ],
      ),
    );
  }
}
