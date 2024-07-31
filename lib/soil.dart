import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'soil_card.dart';

class SoilList extends StatefulWidget {
  const SoilList({Key? key}) : super(key: key);
  @override
  _SoilListState createState() => _SoilListState();
}

class _SoilListState extends State<SoilList> {
  List<Soil> soils = [
    Soil(
      title: 'Black Soil',
      image: Image.asset('assets/images/black.jpg',fit: BoxFit.contain,),
      index: 0
    ),
    Soil(
      title: 'Cinder Soil',
      image: Image.asset('assets/images/cinder.jpg',fit: BoxFit.contain,),
      index: 1
    ),
    Soil(
      title: 'Laterite Soil',
      image: Image.asset('assets/images/laterite.jpg',fit: BoxFit.contain,),
      index: 2
    ),
    Soil(
      title: 'Peat Soil',
      image: Image.asset('assets/images/peat.jpg',fit: BoxFit.contain,),
      index: 3),
    Soil(
      title: 'Yellow Soil',
      image: Image.asset('assets/images/yellow.jpg',fit: BoxFit.contain,),
      index: 4
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: MediaQuery.of(context).size.height-80,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          backgroundColor: Colors.blue[200],
          appBar: AppBar(
            title: Text(
              'Galeri Tanah',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              )
            ),
            centerTitle: true,
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: soils.map((soil) {
                return SoilCard(soil: soil);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
class Soil{
  String title;
  Image image;
  int index;

  Soil({required this.title,required this.image,required this.index});
}

class Detail{
  String name;
  String about;
  String found;
  String character;
  Image photo;

  Detail({required this.name, required this.about, required this.found, required this.character, required this.photo});
}
