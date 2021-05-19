import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:midtermstiw2044_272834/main.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:midtermstiw2044_272834/product.dart';

class NewProduct extends StatefulWidget {
  final Product product;

  const NewProduct({Key key, this.product}) : super(key: key);
  @override
  _NewProduct createState() => _NewProduct();
}

class _NewProduct extends State<NewProduct> {
  ProgressDialog pr;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _typeController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _qtyController = new TextEditingController();
  File _image;
  double screenHeight, screenWidth;
  String pathAsset = 'assets/images/camera.png';

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: Visibility(
          child: FloatingActionButton.extended(
              onPressed: _postDialog, label: Text('Post'))),
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(50, 0, 50, 10),
            child: Column(
              children: [
                Text("Post Product",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () => {_onPictureSelection()},
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _image == null
                              ? AssetImage(pathAsset)
                              : FileImage(_image),
                          fit: BoxFit.scaleDown,
                        ),
                      )),
                ),
                SizedBox(height: 5),
                Text("Click image to open camera.",
                    style: TextStyle(fontSize: 12.0, color: Colors.black)),
                SizedBox(height: 15),
                SizedBox(height: 10),
                Row(children: [
                  Column(
                    children: [
                      Text(
                        'Product Name',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ]),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(13),
                  ),
                ),
                SizedBox(height: 5),
                Row(children: [
                  Column(
                    children: [
                      Text(
                        'Product Type',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ]),
                TextField(
                  controller: _typeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(13),
                  ),
                ),
                SizedBox(height: 5),
                Row(children: [
                  Column(
                    children: [
                      Text(
                        'Product Price',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ]),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(13),
                  ),
                ),
                SizedBox(height: 5),
                Row(children: [
                  Column(
                    children: [
                      Text(
                        'Product Quantity',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ]),
                TextField(
                  controller: _qtyController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 200,
      maxWidth: 200,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }

    //_cropImage();
  }

  _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 200,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }

    //_cropImage();
  }

  /*_cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.black87,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }*/

  _onPictureSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: new Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Take picture from:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                SizedBox(height: 5),
                Row(
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      minWidth: 40,
                      height: 40,
                      child: Text('Camera',
                          style: TextStyle(
                            color: Colors.black87,
                          )),
                      color: Theme.of(context).accentColor,
                      elevation: 10,
                      onPressed: () =>
                          {Navigator.pop(context), _chooseCamera()},
                    ),
                    SizedBox(width: 20),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      minWidth: 40,
                      height: 40,
                      child: Text('Gallery',
                          style: TextStyle(
                            color: Colors.black87,
                          )),
                      color: Theme.of(context).accentColor,
                      elevation: 10,
                      onPressed: () =>
                          {Navigator.pop(context), _chooseGallery()},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _postDialog() {
    if (_image == null ||
        _nameController.text.toString() == "" ||
        _typeController.text.toString() == "" ||
        _priceController.text.toString() == "" ||
        _qtyController.text.toString() == "") {
      Fluttertoast.showToast(
          msg: "Image/Textfield is empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.blue,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Post your product?"),
            content: Text("Confirm?"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _postProduct();
                },
              ),
              TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future<void> _postProduct() async {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Posting...',
      borderRadius: 5.0,
      backgroundColor: Colors.grey,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await pr.show();

    String base64Image = base64Encode(_image.readAsBytesSync());
    String prname = _nameController.text.toString();
    String prtype = _typeController.text.toString();
    String prprice = _nameController.text.toString();
    String prqty = _qtyController.text.toString();

    print(prname);
    print(prtype);
    print(prprice);
    print(prqty);

    http.post(
        Uri.parse("https://nurulida1.com/272834/myshop/php/newproduct.php"),
        body: {
          "prname": prname,
          "prtype": prtype,
          "prprice": prprice,
          "prqty": prqty,
          "encoded_string": base64Image,
        }).then((response) {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.black,
            fontSize: 16.0);
        setState(() {
          _image = null;
          _nameController.text = "";
          _priceController.text = "";
          _typeController.text = "";
          _qtyController.text = "";
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (content) => MainScreen()));
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    });
  }
}
