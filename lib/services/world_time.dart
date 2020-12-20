import 'package:http/http.dart';
import 'dart:convert'; // to use decode json
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //make the request
      Response response =
          await get('https://www.worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties from json

      String dateTime = data['utc_datetime'];

      final String offset1 = data['utc_offset'].substring(0, 3); // hours
      final String offset2 = data['utc_offset'].substring(4, 6); // minutes

      DateTime now = DateTime.parse(dateTime);

      now = now.add(
          Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      // time = now.toString();
      time = DateFormat.jm().format(now);
      print(time);
    } catch (e) {
      print("caught error : $e");
      time = 'could not load the time';
      isDayTime = true;
    }
  }
}
