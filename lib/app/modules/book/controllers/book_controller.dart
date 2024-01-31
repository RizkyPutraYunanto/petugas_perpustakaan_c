import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petugas_perpustakaan_c/app/data/model/respon_book.dart';

import '../../../data/konstan/end_point.dart';
import '../../../data/provider/api_provider.dart';
import '../../add_book/controllers/add_book_controller.dart';

class BookController extends GetxController with StateMixin<List<DataBook>>{

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  getData() async {
    change(null, status: RxStatus.loading());

    try {
      final response = await ApiProvider.instance().get(Endpoint.book,

      );
      if (response.statusCode == 200) {
        final ResponBook responBook = ResponBook.fromJson(response.data);
        if (responBook.data!.isEmpty){
          change(null, status: RxStatus.empty());
        } else {
          change(responBook.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal megambil data"));
      }
    } on DioException catch (e) {

      if (e.response != null) {
        if (e.response?.data != null) {
          change(null, status: RxStatus.error(" dio ${e.response?.data['message']}"));
        }
      } else {
    change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
