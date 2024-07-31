import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'about_us.dart';
import 'crop_recommendation_page.dart';
import 'recommendation.dart';
import 'helper.dart';
import 'soil.dart';
import 'wheather.dart';

class DeteksiTanah extends StatefulWidget {
  const DeteksiTanah({Key? key}) : super(key: key);

  @override
  _DeteksiTanahState createState() => _DeteksiTanahState();
}

class _DeteksiTanahState extends State<DeteksiTanah> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    Weather(),
    SoilList(),
    Crop_Recommend(),
    Helper(),
    AboutUs(),
  ];

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Stack(
        children: [
          Center(
            child: _pages[currentIndex],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 70,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: FloatingActionButton(
                        backgroundColor: Colors.blue[700],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 36),
                            Text('Deteksi', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        onPressed: () {
                          setBottomBarIndex(2);
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.cloudSunRain,
                                color: currentIndex == 0 ? Colors.white : Colors.black,
                              ),
                              onPressed: () {
                                setBottomBarIndex(0);
                              },
                              splashColor: Colors.white,
                            ),
                            Text(
                              'Cuaca',
                              style: GoogleFonts.didactGothic(
                                fontSize: 14,
                                color: currentIndex == 0 ? Colors.white : Colors.black,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.photo,
                                color: currentIndex == 1 ? Colors.white : Colors.black,
                              ),
                              onPressed: () {
                                setBottomBarIndex(1);
                              },
                            ),
                            Text(
                              'Galeri',
                              style: GoogleFonts.didactGothic(
                                fontSize: 14,
                                color: currentIndex == 1 ? Colors.white : Colors.black,
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: size.width * 0.20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.bots,
                                color: currentIndex == 3 ? Colors.white : Colors.black,
                              ),
                              onPressed: () {
                                setBottomBarIndex(3);
                              },
                            ),
                            Text(
                              'ChoiceBot',
                              style: GoogleFonts.didactGothic(
                                fontSize: 14,
                                color: currentIndex == 3 ? Colors.white : Colors.black,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.person,
                                color: currentIndex == 4 ? Colors.white : Colors.black,
                              ),
                              onPressed: () {
                                setBottomBarIndex(4);
                              },
                            ),
                            Text(
                              'Kontak',
                              style: GoogleFonts.didactGothic(
                                fontSize: 14,
                                color: currentIndex == 4 ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 30);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 30);
    path.quadraticBezierTo(size.width, 0, size.width - 30, 0);
    path.lineTo(30, 0);
    path.quadraticBezierTo(0, 0, 0, 30);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
