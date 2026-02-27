import 'dart:convert';
import 'package:flutter/services.dart';

import '../data/models/category_model.dart';


class StaticDataService {
  StaticDataService._();
  static final StaticDataService instance = StaticDataService._();

  MessagesResponse? _cachedData;

  Future<MessagesResponse> loadMessages() async {
    if (_cachedData != null) return _cachedData!;

    final jsonStr = await rootBundle.loadString('assets/json/caption.json');
    final jsonMap = json.decode(jsonStr);

    _cachedData = MessagesResponse.fromJson(jsonMap);

    return _cachedData!;
  }
}

class MessagesResponse {
  final List<CategoryModel> categories;

  MessagesResponse({required this.categories});

  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    return MessagesResponse(
      categories: (json['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
    );
  }
}