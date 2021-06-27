import 'dart:convert';

import 'package:http/http.dart';

class PagedList<T> {
  int totalPages;
  List<T> data;
  PagedList(this.data, this.totalPages);
}

extension ToPagedList on Response {
  PagedList<T> toPagedList<T>(T convert(dynamic e)) {
    var data = jsonDecode(this.body);
    var list = data['data'] as List;
    var totalPages = data['TotalPages'] as int;
    List<T> items = list.map((e) => convert(e)).cast<T>().toList();
    return PagedList(items, totalPages);
  }
}

extension ToMyList on PagedList {
  List<T> toMyList<T>() {
    return this.data;
  }
}
