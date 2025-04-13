import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services.dart';
import '../Models/news_model.dart';

class NewsController extends GetxController {
  final items = <NewsDataModel>[].obs;
  final loading = true.obs, isEmpty = false.obs;
  final page = 1.obs;
  final query = ''.obs;
  final _debouncer = Debouncer(milliseconds: 700);
  final scrollCtrl = ScrollController();

  final Dio dio = Dio();
  final String apiKey = 'eacbd9334a5d42389dc8133ed16cf3f2';

  @override
  void onInit() {
    getNews();
    scrollCtrl.addListener(_scrollListener);
    super.onInit();
  }

  void getNews({bool reset = true}) async {
    if (reset) {
      items.clear();
      page.value = 1;
    }
    loading(true);
    isEmpty(false);
    try {
      final response = await dio.get('https://newsapi.org/v2/everything', queryParameters: {
        'q': query.value.isEmpty ? 'flutter' : query.value,
        'apiKey': apiKey,
        'language': 'en',
        'sortBy': 'publishedAt',
        'page': page.value,
        'pageSize': 10,
      });

      final List articles = response.data['articles'];
      if (articles.isEmpty && reset) {
        isEmpty(true);
      } else {
        items.addAll(articles.map((e) => NewsDataModel.fromJson(e)).toList());
        page.value++;
      }
    } catch (e) {
      isEmpty(true);
    } finally {
      loading(false);
    }
  }

  void onSearchChanged(String value) {
    _debouncer.run(() {
      query(value);
      getNews();
    });
  }

  void _scrollListener() {
    if (scrollCtrl.position.pixels >= scrollCtrl.position.maxScrollExtent - 200) {
      if (page.value <= 20) getNews(reset: false);
    }
  }
}
