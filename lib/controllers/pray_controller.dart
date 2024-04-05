import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ipray/models/praies_models.dart';
import 'package:ipray/service/dio_service.dart';

class PrayController extends ChangeNotifier {
  final DioService dioService;
  PrayController(this.dioService);

  Future<Praies?> createPray(String dateSelected, int idUser) async {
    try {
      final response = await dioService
          .getDio()
          .post('/praies', data: {"id_user": idUser, "date": dateSelected});
      final dataPray = Praies.fromJson(response.data);

      return dataPray;
    } catch (e) {
      String errorMessage = 'Algo deu errado, tente novamente mais tarde.';
      if (e is DioException) {
        if (e.error is SocketException) {
          errorMessage = 'Sem internet, por favor reconecte';
        }
      }
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  Future<bool> deletePray(int id) async {
    try {
      await dioService.getDio().delete('/praies/$id');

      return true;
    } catch (e) {
      String errorMessage = 'Algo deu errado, tente novamente mais tarde.';
      if (e is DioException) {
        if (e.error is SocketException) {
          errorMessage = 'Sem internet, por favor reconecte';
        }
      }
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }
}
