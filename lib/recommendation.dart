import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Crop_Recommend extends StatefulWidget {
  const Crop_Recommend({Key? key}) : super(key: key);

  @override
  State<Crop_Recommend> createState() => _Crop_RecommendState();
}

class _Crop_RecommendState extends State<Crop_Recommend> {
  late bool _loading = true;
  late File _image = File("");
  late List _outputs = [
    {"label": "Unlabelled Soil", "confidence": 0.8}
  ];

  Map cropRecommend = {
    0: ["assets/images/kapas.jpeg", "Kapas"],
    1: ["assets/images/mawar.jpg", "Mawar"],
    2: ["assets/images/teh.jpg", "Teh"],
    3: ["assets/images/carrot.jpg", "Wortel"],
    4: ["assets/images/corn.jpg", "Jagung"],
  };

  final _imagepicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    print("Loading Model Waiting....");
    await Tflite.loadModel(
      model: "assets/images/xcep2_model.tflite", labels: "assets/images/labels.txt");
    print("Model Loaded successfully !! ");
    print("Image is =========> ${_image}");
    print("Outputs is =========> ${_outputs}");
  }

  Future<void> pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Kamera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  var image = await _imagepicker.getImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _loading = true;
                      _image = File(image.path);
                    });
                    classifyImage(_image);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galeri'),
                onTap: () async {
                  Navigator.of(context).pop();
                  var image = await _imagepicker.getImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _loading = true;
                      _image = File(image.path);
                    });
                    classifyImage(_image);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  classifyImage(File image) async {
    print("Waiting for running the model .... ");
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print("Model Ran on image successfully !! ");
    print("After Selecting img is : ${_image}");
    setState(() {
      _loading = false;
      _outputs = output!;
    });
    print("Outputs is ============== ${_outputs}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: _loading
      ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
      : Container(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image.path == ""
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add_a_photo, size: 100, color: Colors.blue),
                  onPressed: pickImage,
                ),
                Text(
                  "Pilih gambar tanah",
                  style: GoogleFonts.lora(
                    color: Color.fromARGB(255, 33, 129, 209),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
            : GestureDetector(
              onTap: pickImage,
              child: Container(
                padding: EdgeInsets.all(20.0),
                height: 220,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: Color.fromARGB(255, 33, 129, 209),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue[100],
                ),
                child: Image.file(_image),
              ),
            ),
            SizedBox(height: 20,),
            _image.path != "" && _outputs.isNotEmpty &&
            double.parse("${_outputs[0]["confidence"]}") > 0.8
            ? Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Jenis Tanah : ${_outputs[0]["label"]}"
                      .replaceAll(RegExp(r'[0-9]'), ''),
                      style: GoogleFonts.lora(
                        color: Color.fromARGB(255, 33, 129, 209),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Akurasi : ${(_outputs[0]["confidence"] * 100).toStringAsFixed(2)}%",
                      style: GoogleFonts.lora(
                        color: Color.fromARGB(255, 33, 129, 209),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 300,
                      height: 2,
                      color: Color.fromARGB(255, 33, 129, 209),
                      margin: EdgeInsets.symmetric(vertical: 10),
                    ),
                    SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Tanaman yang Cocok",
                          style: GoogleFonts.lora(
                            color: Color.fromARGB(255, 33, 129, 209),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          height: 220,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 5,
                              color: Color.fromARGB(255, 33, 129, 209),
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue[100]
                          ),
                          child: Image(
                            image: AssetImage(
                              cropRecommend[int.parse("${_outputs[0]["index"]}")]![0],
                            ),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width - 20,
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text(
                          cropRecommend[int.parse("${_outputs[0]["index"]}")]![1],
                          style: GoogleFonts.lora(
                            color: Color.fromARGB(255, 33, 129, 209),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 100,),
                      ],
                    ),
                  ],
                ),
              ),
            )
            : (_image.path != ""
              ? Center(
                child: Text(
                  "Gambar tidak dikenali",
                  style: GoogleFonts.lora(
                    color: Color.fromARGB(255, 33, 129, 209),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
              : Container()
            ),
          ],
        ),
      ),
    );
  }
}
