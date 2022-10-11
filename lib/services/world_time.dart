import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime{
  late String location;  //location name for the ui
  late String time;  // the time in that location
  late String flag;  // url for the flag
  late String url;  // location url for api endpoint
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{  //future is used as we are using await in loading.dart and this is void function

    try{
      final response = await http.get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from the data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      print(offset);

      // create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print(e);
      time = 'Could not get time data';
    }
  }

}


