import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // get properties from json
      String datetime = data['datetime'];
      String hourOffset = data['utc_offset'].substring(1, 3);
      String minuteOffset = data['utc_offset'].substring(4, 6);

      //print(datetime);
      //print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(hourOffset), minutes: int.parse(minuteOffset)));

      // set time property
      time = DateFormat.jm().format(now);
    } catch (error) {
      print('caught error: $error');
      time = 'time failed';
    }
  }
}
