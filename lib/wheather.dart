import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WeatherState();
  }
}

class WeatherState extends State<Weather> {
  List<current> weather = [];

  int hour = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID');

    return Scaffold(
      body: FutureBuilder<List<forecast>>(
        future: getweather(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              )
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: getcolor()
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("Cuaca",style: GoogleFonts.poppins(fontSize: 40,color: Colors.white,fontWeight: FontWeight.w500),)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: Image.asset(getWeatherIcon(weather[0].id),fit: BoxFit.fill,)
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${(weather[0].temp-273.15).toStringAsFixed(1)}°",style: GoogleFonts.poppins(fontSize: 60,color: Colors.white),),
                          Text(weather[0].weather,style: GoogleFonts.poppins(color: Colors.white,fontSize: 24),),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Kelembapan',style: GoogleFonts.poppins(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600),),
                          Text("${(weather[0].humidity).toStringAsFixed(1)}%",style: GoogleFonts.poppins(fontSize: 50,color: Colors.white),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Tekanan',style: GoogleFonts.poppins(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600),),
                          Text("${(weather[0].pressure)}",style: GoogleFonts.poppins(fontSize: 46,color: Colors.white),),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text('Prediksi :',style: GoogleFonts.poppins(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600),)
                    ),
                  ),
                  Expanded(
                    child: GridView(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.5,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5.0
                      ),
                      children: snapshot.data!.map((document){
                        return Column(
                          children: [
                            Text(DateFormat('EEEE', 'id_ID').format(DateTime.fromMillisecondsSinceEpoch(document.dt*1000)),style: GoogleFonts.poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height:70,
                                  child: Image.asset(getWeatherIcon(document.desc)),
                                ),
                                Column(
                                  children: [
                                    Text('Maks:  ${(document.max-273.15).toStringAsFixed(1)}°',style: GoogleFonts.poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text('Min:  ${(document.min-273.15).toStringAsFixed(1)}°',style: GoogleFonts.poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      }).toList()
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            );
          }
        }
      ),
    );
  }

  List<Color> getcolor() {
    if (hour >= 6 && hour <= 11) {
      return [const Color(0xFF83eaf1), const Color(0xFF3eadcf)];
    } else if (hour > 11 && hour <= 16) {
      return [const Color(0xFFFFDF00), const Color(0xFFF6D108)];
    } else if (hour > 16 && hour < 19) {
      return [Color(0xFF4e54c8), const Color(0xFF9795ef),];
    } else {
      return [const Color(0xFF001D37), const Color(0xFF01162E)];
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'assets/images/ic_storm_weather.png';
    } else if (condition < 400) {
      return 'assets/images/ic_rainy_weather.png';
    } else if (condition < 600) {
      return 'assets/images/ic_rainy_weather.png';
    } else if (condition < 700) {
      return 'assets/images/ic_snow_weather.png';
    } else if (condition < 800) {
      return 'assets/images/ic_mostly_cloudy.png';
    } else if (condition == 800) {
      return 'assets/images/ic_clear_day.png';
    } else if (condition <= 804) {
      return 'assets/images/ic_cloudy_weather.png';
    } else {
      return 'assets/images/ic_unknown.png';
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
  Future<List<forecast>> getweather() async
  {
    Position p=await _determinePosition();
    Response r=await get(Uri.parse("https://api.openweathermap.org/data/2.5/onecall?lat=${p.latitude}&lon=${p.longitude}&exclude=hourly,minutely&appid=8cb6386fe572b5b0befe4eba9bfa7c2f"));
    Map<String, dynamic> x = jsonDecode(r.body);
    weather.add(current(x['current']['temp'], x['current']['weather'][0]['description'], x['current']['weather'][0]['main'], x['current']['humidity'],x['current']['weather'][0]['id'] , x['current']['pressure']));
    var y=x['daily'];
    print(y);

    List<forecast> z=[];
    for(var i=1;i<5;i++ )
    {
      z.add( forecast(y[i]['dt'], y[i]['humidity'], y[i]['temp']['max'], y[i]['temp']['min'], y[i]['weather'][0]['main'],y[i]['weather'][0]['id']));
    }

    return z;
  }
}
class current
{
  var temp;
  var pressure;
  var humidity;
  var weather;
  var id;
  var desc;
  current(this.temp,this.desc,this.weather,this.humidity,this.id,this.pressure);
}
class forecast{
  var dt;
  var max;
  var humidity;
  var min;
  var weather;
  var desc;
  forecast( this.dt,this.humidity,this.max,this.min,this.weather,this.desc);
}
