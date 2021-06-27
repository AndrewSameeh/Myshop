import 'dart:convert';
import 'package:my_shop/Utility/PagedList.dart';
import 'package:my_shop/Utility/constant.dart';
import 'package:my_shop/models/utility/KeyValueItem.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UtiltiyService {
  String _token;

  Future<String> get token async {
    return _token ?? await getToken();
  }

  void setToken(String token) async {
    _token = token;
    var pref = await SharedPreferences.getInstance();
    var userData = json.encode({'UID': token});
    pref.setString('userData', userData);
  }

  Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      _token = null;
      return null;
    }
    final userdata =
        json.decode(pref.getString('userData')) as Map<String, dynamic>;
    _token = userdata['UID'];
    return _token;
  }

  Future<void> clearToken() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('userData');
    _token = null;
  }

  Future<List<KeyValueItem>> getBrands(int count) async {
    var item = await getListFromhttpAuthorizationGet<KeyValueItem>(
        GetBrands + '$count', (e) => KeyValueItem.fromJson(e));
    return (item).toMyList();
  }

  Future<List<KeyValueItem>> getGoverenment() async {
    var item = await getListFromhttpAuthorizationGet<KeyValueItem>(
        GetGoverenmentes, (e) => KeyValueItem.fromJson(e));

    return item.toMyList();
  }

  Future<List<KeyValueItem>> getCities(int goverenmentId) async {
    var item = await getListFromhttpAuthorizationGet<KeyValueItem>(
        GetCities + '$goverenmentId', (e) => KeyValueItem.fromJson(e));

    return item.toMyList();
  }

  Future<PagedList<T>> getListFromhttpAuthorizationGet<T>(
      String url, T convert(dynamic e)) async {
    final response = await _httpAuthorizationGet(url);
    PagedList<T> items = _checkResponse(response).toPagedList(convert);
    return items;
  }

  Future<List<T>> getListFromhttpAuthorizationPost<T>(String url, dynamic data,
      {T convert(dynamic e)}) async {
    final response = await httpAuthorizationPost(url, data);
    if (convert == null) return null;
    List<T> items = _checkResponse(response).toPagedList(convert).data;
    return items;
  }

  Future<http.Response> _httpAuthorizationGet(url) async {
    var mytoken = 'zHyNELvr6AM2nBLR3YfJZ6aHWAZ2'; //await token;
    http.Response response = await http.get(url, headers: {
      "Authorization": "Bearer  $mytoken",
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return _checkResponse(response);
  }

  Future<http.Response> httpAuthorizationPost(url, dynamic data) async {
    var mytoken = 'zHyNELvr6AM2nBLR3YfJZ6aHWAZ2'; //await token;
    http.Response response =
        await http.post(url, body: json.encode(data), headers: {
      "Authorization": "Bearer  $mytoken",
      'Content-Type': 'application/json; charset=UTF-8'
    });
    return _checkResponse(response);
  }

  http.Response _checkResponse(http.Response response) {
    if (response.statusCode == 200) {
      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
