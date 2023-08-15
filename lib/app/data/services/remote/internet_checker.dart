import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class InternetChecker {
  Future<bool> hasInternet() async {

    String pingDomain = 'google.com';
    try {
      if (kIsWeb) {
        final response = await get(Uri.parse(pingDomain));
        return response.statusCode == 200;
      } else {
        final list = await InternetAddress.lookup(pingDomain);
        return list.isNotEmpty && list.first.rawAddress.isNotEmpty;
      }
    } catch (e) {
      return false;
    }
  }
}
