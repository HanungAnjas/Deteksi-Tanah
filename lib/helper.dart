import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HelperState();
  }
}

class HelperState extends State<Helper> {
  bool isLoading = false;
  bool result = false;
  int type_of_crop = 0;
  int count = 1;

  String getRecommendation() {
    switch (type_of_crop) {
      case 0:
        return "Tanaman yang cocok untuk Black Soil:\n"
                + "- Kapas\n"
                + "- Tebu\n"
                + "- Tembakau\n"
                + "- Buah jeruk\n"
                + "- Millet : jagung, jowar, dan\n"
                + "   sorgum\n"
                + "- Biji minyak : kacang tanah dan\n"
                + "   biji rami\n"
                + "";
      case 1:
        return "Tanaman yang cocok untuk Cinder Soil:\n"
                + "- Mawar\n"
                + "- Adenium\n"
                + "- Kaktus\n"
                + "- Tanaman sukulen\n"
                + "- Bonsai\n"
                + "";
      case 2:
        return "Tanaman yang cocok untuk Laterite Soil:\n"
                + "- Teh\n"
                + "- Kopi\n"
                + "- Kelapa sawit\n"
                + "- Kacang mete\n"
                + "";
      case 3:
        return "Tanaman yang cocok untuk Peat Soil:\n"
                + "- Sayuran : wortel, selada, dan\n"
                + "   bawang bombay\n"
                + "- Kacang-kacangan\n"
                + "- Umbi-umbian : kentang\n"
                + "- Semak dan pohon : azalea dan\n"
                + "   pohon lentera\n"
                + "- Tanaman rumput\n"
                + "";
      case 4:
        return "Menurut (Rahmida N et al., 2021), tanaman yang cocok untuk Yellow Soil:\n"
                + "- Jagung\n"
                + "- Umbi\n"
                + "- Kangkung\n"
                + "- Sawi\n"
                + "- Selada\n"
                + "";
      default:
        return "Pilih jenis tanah terlebih dahulu";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> questions = [
      SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  const CircleAvatar(
                    radius: 20,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.black,
                    backgroundImage: AssetImage('assets/images/bot.png'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 33, 129, 209),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Text(
                            'Apa jenis tanah anda?',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: DropdownButton<int>(
                      value: type_of_crop,
                      items: const [
                        DropdownMenuItem(child: Text("Black Soil"), value: 0),
                        DropdownMenuItem(child: Text("Cinder Soil"), value: 1),
                        DropdownMenuItem(child: Text("Laterite Soil"), value: 2),
                        DropdownMenuItem(child: Text("Peat Soil"), value: 3),
                        DropdownMenuItem(child: Text("Yellow Soil"), value: 4),
                      ],
                      onChanged: (int? value) {
                        setState(() {
                          type_of_crop = value!;
                          count = 1;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      count = 2;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[800],
                    onPrimary: Colors.white,
                  ),
                  child: const Text('Rekomendasi'),
                ),
              ),
            ),
          ],
        ),
      ),
      if (count > 1)
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  const CircleAvatar(
                    radius: 20,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.black,
                    backgroundImage: AssetImage('assets/images/bot.png'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 33, 129, 209),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getRecommendation(),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            if (type_of_crop == 0)
                            GestureDetector(
                              onTap: () {
                                launch('https://www.agrifarming.in/crops-suitable-for-black-soil-a-full-guide');
                              },
                              child: Text(
                                'Read More',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (type_of_crop == 1)
                            GestureDetector(
                              onTap: () {
                                launch('https://www.alkarty.com/Cinder-for-plants-khanger#:~:text=In%20indoor%20plant%20care%2C%20cinders,in%20a%20well%2Dbalanced%20environment.');
                              },
                              child: Text(
                                'Read More',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (type_of_crop == 2)
                            GestureDetector(
                              onTap: () {
                                launch('https://en.wikipedia.org/wiki/Laterite');
                              },
                              child: Text(
                                'Read More',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (type_of_crop == 3)
                            GestureDetector(
                              onTap: () {
                                launch('https://cropcareequipment.com/blog/types-of-soil/');
                              },
                              child: Text(
                                'Read More',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (type_of_crop == 4)
                            GestureDetector(
                              onTap: () {
                                launch('https://drive.google.com/file/d/1Q1CFW-6UbBzph1iqC8GaOeQo_c9pf-2l/view?usp=sharing');
                              },
                              child: Text(
                                'Read More',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ];

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: isLoading == false && result == false
      ? Column(
        children: [
          SizedBox(
            height: 275,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 90, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/bot.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Choice Bot',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: size.height - 275 - 80,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                ),
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: count,
                itemBuilder: (context, index) {
                  return questions[index];
                },
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 80,
          ),
        ],
      )
      : result == false
      ? const Center(child: CircularProgressIndicator())
      : Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 250,
              width: size.width,
              color: const Color.fromARGB(255, 33, 129, 209),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                          AssetImage('assets/images/bot.png'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
