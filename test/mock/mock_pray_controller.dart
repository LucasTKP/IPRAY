import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/models/praies_models.dart';

class MockPrayController extends PrayController{
  @override
  Future<Praies?> createPray(DateTime dateSelected, int idUser)=> onCreatePray(dateSelected, idUser);
  Future<Praies?> Function(DateTime dateSelected, int idUser) onCreatePray = (dateSelected, idUser) => throw UnimplementedError();

  @override
  Future<bool> deletePray(DateTime dateSelected, int idUser) => onDeletePray(dateSelected, idUser);
  Future<bool> Function(DateTime dateSelected, int idUser) onDeletePray = (dateSelected, idUser) => throw UnimplementedError();


  @override
  Future<bool> existsPray(DateTime dateSelected, int idUser) => onExistsPray(dateSelected, idUser);
  Future<bool> Function (DateTime dateSelected, int idUser) onExistsPray = (dateSelected, idUser) => throw UnimplementedError();

  @override
  bool existsPrayInCache(DateTime dateSelected) => onExistsPrayInCache(dateSelected);
  bool Function (DateTime dateSelected) onExistsPrayInCache = (dateSelected) => throw UnimplementedError();
  
}