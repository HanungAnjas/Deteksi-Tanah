import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_page.dart';
import 'soil.dart';

class SoilCard extends StatelessWidget {
  final Soil soil;
  SoilCard ({Key? key, required this.soil}) : super(key: key);

  List<Detail> details = [
    Detail(name: 'Black Soil',
      about: 'Black soil atau tanah hitam terkenal karena kemampuannya dalam mempertahankan kelembapan sehingga sangat cocok untuk budidaya kapas. Warna tanah hitam berkisar dari hitam pekat hingga abu-abu dan disebabkan oleh tingginya konsentrasi zat besi, bahan organik, dan kalium. Biasanya, tanah-tanah ini mempunyai kapasitas menahan air yang baik, yang berguna pada musim kemarau, namun tanah ini dapat menjadi tergenang air ketika hujan lebat.',
      found: 'Black soil ersebar di beberapa daerah di Indonesia, terutama di daerah-daerah dengan iklim tropis basah. Contohnya termasuk daerah-daerah seperti Jawa Tengah, Jawa Timur, dan sebagian Sumatera.',
      character: 'Tanah ini dicirikan oleh kandungan liatnya yang tinggi, yang menyebabkan sifat lengketnya saat basah dan teksturnya yang keras saat kering. Kaya akan nutrisi tanah seperti kalsium karbonat, magnesium, kalium, dan kapur, tanah hitam dianggap subur dan ideal untuk pertanian.',
      photo: Image.asset('assets/images/black.jpg',fit: BoxFit.contain,)
    ),
    Detail(name: 'Cinder Soil',
      about: 'Cinder soil, atau sering disebut juga sebagai tanah vulkanik, merupakan jenis tanah yang terbentuk dari endapan material vulkanik seperti abu vulkanik dan lapili (batu-batu kecil). Tanah cinder kaya akan mineral-mineral vulkanik seperti silika, alumina, dan oksida besi, yang membuatnya potensial untuk pertanian karena kesuburannya.',
      found: 'Persebarannya luas di Indonesia, terutama di daerah-daerah dengan aktivitas vulkanik tinggi seperti Jawa, Sumatera, dan pulau-pulau di Nusa Tenggara. Contohnya, daerah sekitar Gunung Merapi di Jawa Tengah dan Gunung Bromo di Jawa Timur.',
      character: 'Karakteristik utamanya meliputi warna abu-abu hingga kehitaman, tekstur bervariasi dari halus hingga kasar tergantung pada ukuran partikel abu dan lapili, serta struktur tanah yang cenderung rapat dan padat dengan potensi drainase yang baik tergantung pada kondisi pembentukannya.',
      photo: Image.asset('assets/images/cinder.jpg',fit: BoxFit.contain,)
    ),
    Detail(name: 'Laterite Soil',
      about: 'Tanah laterit atau laterite soil adalah jenis tanah yang terbentuk dari proses pelapukan batuan induk oleh air hujan yang panas dan lembap. Proses ini mengakibatkan pengikisan mineral-mineral seperti silika, alumina, dan oksida besi, yang kemudian terendapkan di lokasi tersebut.',
      found: 'Tanah laterit tersebar luas di berbagai wilayah di Indonesia, terutama di daerah-daerah dengan aktivitas pelapukan yang intensif. Contoh daerahnya termasuk di Jawa, Sumatera, Kalimantan, dan Sulawesi, di mana tanah ini menjadi karakteristik utama dalam lanskap dan pembentukan tanah.',
      character: 'Tanah laterit biasanya memiliki warna yang bervariasi dari merah hingga kuning, tergantung pada komposisi mineralnya. Selain itu, tanah ini memiliki tekstur yang keras dan padat, dengan kemampuan drainase yang baik. Strukturnya cenderung keras dan kompak karena mineral-mineralnya yang terkristalisasi.',
      photo: Image.asset('assets/images/laterite.jpg',fit: BoxFit.contain,)
    ),
    Detail(name: 'Peat Soil',
      about: 'Tanah gambut, atau peat soil, adalah jenis tanah organik yang terbentuk dari proses akumulasi material tumbuhan yang terdekomposisi secara parsial di lingkungan yang tergenang air atau lembab. Proses ini terjadi dalam waktu yang sangat lambat, di mana material tumbuhan seperti lumut, gambut, dan serasah mengendap dan mengalami dekomposisi yang terbatas karena kurangnya oksigen di dalam air atau kondisi lingkungan yang asam. Akibatnya, tanah gambut memiliki kandungan organik yang tinggi, umumnya lebih dari 50%, yang membuatnya sangat berbeda dengan jenis tanah lainnya.',
      found: 'Persebarannya luas di Indonesia terutama di wilayah-wilayah dengan kondisi lahan basah seperti Kalimantan, Sumatera, Papua, dan bagian-bagian dari Sulawesi, yang sering kali memiliki hutan rawa gambut yang luas.',
      character: 'Tanah ini umumnya berwarna coklat hingga hitam dengan tekstur yang ringan dan mudah terbakar karena kandungan tinggi serat tumbuhan yang belum terdekomposisi sepenuhnya. Kandungan airnya tinggi karena sifat gambut yang menyerap dan menyimpan air dengan baik. Meskipun awalnya tanah gambut bisa kurang subur karena kandungan nutrisi yang rendah, dengan pengelolaan yang tepat seperti pengapuran dan pemupukan, tanah gambut dapat menjadi subur untuk pertanian.',
      photo: Image.asset('assets/images/peat.jpg',fit: BoxFit.contain,)
    ),
    Detail(name: 'Yellow Soil',
      about: 'Tanah kuning atau yellow soil adalah jenis tanah yang umumnya terbentuk dari endapan mineral seperti oksida besi yang teroksidasi di lingkungan tropis dan subtropis. Awalnya, tanah kuning mungkin memiliki kesuburan yang rendah karena kandungan mineral yang teroksidasi dan mungkin kurangnya bahan organik. Namun, dengan pemupukan dan manajemen tanah yang baik, tanah kuning dapat menjadi cukup subur untuk pertanian.',
      found: 'Tanah kuning tersebar luas di berbagai wilayah Indonesia, terutama di daerah-daerah dengan iklim tropis dan subtropis seperti Jawa, Sumatera, dan Kalimantan. Contoh daerah dengan tanah kuning yang cukup khas adalah daerah sekitar Gunung Merapi di Jawa Tengah dan daerah pedalaman Kalimantan.',
      character: 'Tanah kuning memiliki warna yang bervariasi dari kuning ke kecoklatan hingga merah kekuningan, tergantung pada kandungan mineralnya dan kondisi lingkungan pembentukannya. Teksturnya bervariasi dari kasar hingga halus, tergantung pada ukuran partikel mineral yang terkandung di dalamnya. Struktur tanah kuning biasanya cukup padat, namun memiliki drainase yang baik.',
      photo:Image.asset('assets/images/yellow.jpg',fit: BoxFit.contain,)
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          color: Colors.blue[400],
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    soil.title,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),

                Container(
                  height: 175,
                  width: 300,
                  child: soil.image
                ),

                const SizedBox(height: 5.0,),
                const Padding(padding: EdgeInsets.fromLTRB(4.0,4.0,4.0,20.0),),
              ],
            ),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => DetailPage(detail: details[soil.index],)),
              );
            },
          ),
        ),
      ),
    );
  }
}
