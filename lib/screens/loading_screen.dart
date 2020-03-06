import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  var apiKey = 'b8614dbae3677ffbdac9dc4336b3fb66';

  @override
  void initState() {
    super.initState();
    fetchLocationAndData();
  }

  void fetchLocationAndData() async {
    Location location = new Location();
    await location.getCurrentLocation();
    //print([location.latitude, location.longitude]);
    latitude = location.latitude;
    longitude = location.longitude;
    NetworkManager networkManager = NetworkManager(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    var weatherData = await networkManager.getWeatherData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
