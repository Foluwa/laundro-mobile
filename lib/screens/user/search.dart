import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/laundry_provider.dart';

// https://www.youtube.com/watch?v=oFZIwBudIj0
// https://www.youtube.com/watch?v=oFZIwBudIj0
// https://www.youtube.com/watch?v=oFZIwBudIj0
// https://www.youtube.com/watch?v=oFZIwBudIj0
// https://www.youtube.com/watch?v=oFZIwBudIj0
// https://www.youtube.com/watch?v=oFZIwBudIj0
class GridSearchScreen extends StatefulWidget {
  const GridSearchScreen({Key? key}) : super(key: key);
  @override
  _GridSearchScreenState createState() => _GridSearchScreenState();
}

class _GridSearchScreenState extends State<GridSearchScreen> {
  List<String> productListSearch = [];
  final FocusNode _textFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  LaundryProvider _laundryProvider = LaundryProvider();

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _laundryProvider = Provider.of<LaundryProvider>(context);

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.blue.shade300,
            title: Container(
              decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: _textEditingController,
                focusNode: _textFocusNode,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Search here',
                    contentPadding: EdgeInsets.all(8)),
                onChanged: (value) {
                  setState(() {
                    productListSearch = _laundryProvider.getProducts!
                        .where((element) =>
                            element.name.contains(value.toLowerCase()))
                        .cast<String>()
                        .toList();
                    if (_textEditingController.text.isNotEmpty &&
                        productListSearch.length == 0) {
                      print(
                          'productListSearch length ${productListSearch.length}');
                    }
                  });
                },
              ),
            )),
        body: _textEditingController.text.isNotEmpty &&
                productListSearch.length == 0
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search_off,
                          size: 160,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'No results found,\nPlease try different keyword',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 12,
                ),
                itemCount: _textEditingController.text.isNotEmpty
                    ? productListSearch.length
                    : _laundryProvider.getProducts!.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          child: Icon(Icons.food_bank),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(_textEditingController.text.isNotEmpty
                            ? productListSearch[index]
                            : _laundryProvider.getProducts![index].name),
                      ],
                    ),
                  );
                }));
  }
}
