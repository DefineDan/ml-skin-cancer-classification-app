import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/services.dart' show rootBundle;

enum imgSrc { camera, gallery }

class Pick extends StatefulWidget {
  @override
  _Pick createState() => _Pick();
}

class _Pick extends State<Pick> {
  File _image;
  final picker = ImagePicker();
  bool _modelLoading;
  bool _modelPredicting;
  List _output;
  String _infotxt;

  ///loads a txt file from assets to string variable
  Future<void> getText(String path) async {
    final _loadedData = await rootBundle.loadString(path);
    setState(() {
      _infotxt = _loadedData;
    });
  }

  Future loadModel() async {
    await Tflite.loadModel(
        model: "assets/scc_model.tflite", labels: "assets/labels.txt");
  }

  ///Tries to load image from either gallery or camera depening on [scr]. If successfull, calls classify function on image.
  Future getImagePrediction(imgSrc src) async {
    // get image file via picker
    final pickedFile = (src == imgSrc.gallery)
        ? await picker.getImage(source: ImageSource.gallery)
        : await picker.getImage(source: ImageSource.camera);
    // change state and call classify if successfull
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _modelPredicting = true;
      }
    });
    if (_image != null) {
      classifyImg(_image);
    }
  }

  /// classifies image on tensor flow lite model and loads infotext file based on prediction
  Future classifyImg(File image) async {
    // predict with tflite model
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 7,
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.5,
    );
    // load custom txt file and set state
    getText('assets/${output[0]["index"]}.txt').then((value) {
      setState(() {
        _modelPredicting = false;
        _output = output;
      });
    });
  }

  //init state
  @override
  void initState() {
    super.initState();
    _modelLoading = true;
    _modelPredicting = false;
    //load tflite model
    loadModel().then((value) {
      setState(() {
        _modelLoading = false;
      });
    });
  }

  // widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (_modelLoading || _modelPredicting)
            // loading screen
            ? Container(
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              )
            // classify screen
            : SafeArea(
                child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    children: <Widget>[
                    SizedBox(height: 20),
                    _image == null
                        // select image screen
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                                SizedBox(height: 200.0),
                                Image.asset(
                                  'assets/upload_icon.png',
                                  height: 150,
                                ),
                                SizedBox(height: 30),
                                Text(
                                  'Please select an image of your skin lesion from your gallery or take a picture right now!',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ])

                        // display prediction screen
                        : Column(children: <Widget>[
                            // prediction result card
                            Container(
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.black,
                                    elevation: 10,
                                    child: Column(children: <Widget>[
                                      SizedBox(height: 10),
                                      Text(
                                        '${_output[0]["label"]}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 35,
                                          color: [0, 1, 4]
                                                  .contains(_output[0]["index"])
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                                width: 180.0,
                                                height: 180.0,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: [
                                                          0,
                                                          1,
                                                          4
                                                        ].contains(_output[0]
                                                                ["index"])
                                                            ? Colors.red
                                                            : Colors.green,
                                                        width: 2),
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: FileImage(
                                                            _image)))),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  '${(_output[0]["confidence"] * 100).toStringAsFixed(2)}%',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 40,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  'confidence',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ]),
                                      SizedBox(height: 15),
                                      // alert to see doctor card
                                      Container(
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: [
                                                0,
                                                1,
                                                4
                                              ].contains(_output[0]["index"])
                                                  ? Colors.red
                                                  : Colors.green,
                                              elevation: 10,
                                              child: Column(children: <Widget>[
                                                SizedBox(height: 10),
                                                Text(
                                                  [0, 1, 4].contains(
                                                          _output[0]["index"])
                                                      ? 'Please see a doctor immediatly to get your lesion checked out professionally!'
                                                      : 'Not dangerous. Please still get lesions checked out by a doctor regularily! ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ]))),
                                      SizedBox(
                                        height: 15,
                                      )
                                    ]))),
                            SizedBox(height: 30),
                            // diagnosis info card
                            Card(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.info),
                                    title: Text(
                                      '${_output[0]["label"]}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      _infotxt,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ])),
                            SizedBox(
                              height: 15,
                            ),
                          ])
                  ])),
        // image select buttons
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 31),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () => getImagePrediction(imgSrc.gallery),
                  tooltip: 'Pick Image from your gallery',
                  child: Icon(Icons.add_photo_alternate),
                  backgroundColor: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: () => getImagePrediction(imgSrc.camera),
                tooltip: 'Take photo with your camera',
                child: Icon(Icons.camera_alt),
                backgroundColor: Colors.black,
              ),
            ),
          ],
        ));
  }
}
