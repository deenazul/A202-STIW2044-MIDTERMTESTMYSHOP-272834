import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midtermstiw2044_272834/product.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'newproduct.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  final Product product;

  const MainScreen({Key key, this.product}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ProgressDialog pr;

  double screenHeight, screenWidth;
  List _productList;
  String _titlecenter = "Loading...";
  final df = new DateFormat('dd-MM-yyyy hh:mm a');

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onPress,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('MY SHOP'),
      ),
      body: GridView.count(
          crossAxisCount: 2,
         /* children: List.generate(_productList.length, (index) {
            return Padding(
              padding: EdgeInsets.all(5),
              child: Card(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _productList == null
                      ?  Flexible(child: Center(child: Text(_titlecenter)))
                : Flexible(
                    child: Container(
                        child: CachedNetworkImage(
                          imageUrl: "https://nurulida1.com/272834/myshop/images/productimages/${_productList[index]['prid']}.png",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(Icons.broken_image),),
                      ),), 
                        Row(
                          children: [
                              Text('PRODUCT NAME:'), Text(_productList[index]['prname']),
                              Text('PRODUCT TYPE:'),Text(_productList[index]['prtype']),
                      Text('PRODUCT PRICE: RM'),Text(_productList[index]['prprice']),
                     Text('PRODUCT QUANTITY:'), Text(_productList[index]['prqty']),
                          ],
                        )
                    ]),
                  ),
            ),);
          }),
    ),*/));
  }

  void onPress() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => NewProduct()));
  }

  void _loadProduct() {
    /* http.post(
        Uri.parse("https://nurulida1.com/272834/myshop/php/loadproduct.php"),
        body: {
          "prname": widget.product.prname,
          "prtype": widget.product.prtype,
          "prprice": widget.product.prprice,
          "prqty": widget.product.prqty,
        }).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Sorry, no data is available";
        return;
      } else {
        var jsondata = json.decode(response.body);
        _productList = jsondata["product"];
        setState(() {});
        print(_productList);
      }
    }); */
  }
}
