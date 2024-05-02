import 'package:flutter_test/flutter_test.dart';
import 'package:ipray/controllers/pray_controller.dart';

import 'package:ipray/models/praies_models.dart';

import '../mock/mock_app_navigator.dart';
import '../mock/mock_supabase_controller.dart';

void main() {
  late PrayController controller;
  late MockSupabaseController supabaseController;
  late MockAppNavigator appNavigator;

  setUp(() {
    appNavigator = MockAppNavigator();
    supabaseController = MockSupabaseController();

    controller = PrayControllerImp(
      appNavigator: appNavigator,
      supabaseController: supabaseController,
    );
  });

  test("PrayController.createPray()", () async {
    // Arrange
    bool notifyListener = false;
    controller.addListener(() {
      notifyListener = true;
    });

    DateTime date = DateTime(
      2024,
      4,
      18,
      0,
      0,
      0,
      0,
    );

    Praies pray = Praies(id: 0, idUser: 0, date: date);

    bool onCreatePrayCalled = false;
    supabaseController.onCreatePray = (DateTime dateSelected, int idUser) async {
      onCreatePrayCalled = true;
      return pray;
    };

    // Act
    final response = await controller.createPray(date, 0);

    // Assert
    expect(response, pray);
    expect(notifyListener, false);
    expect(onCreatePrayCalled, true);
    expect(controller.cache[date].toString(), pray.toString());
  });

  test("PrayController.createPray(erro)", () async {
    // Arrange
    bool notifyListener = false;
    controller.addListener(() {
      notifyListener = true;
    });

    DateTime date = DateTime(
      2024,
      4,
      18,
      0,
      0,
      0,
      0,
    );

    bool onCreatePrayCalled = false;
    supabaseController.onCreatePray = (DateTime dateSelected, int idUser) async {
      onCreatePrayCalled = true;
      throw Error;
    };

    bool onShowError = false;
    appNavigator.onShowError = (String error) {
      onShowError = true;
    };

    // Act
    final response = await controller.createPray(date, 0);

    // Assert
    expect(response, null);
    expect(notifyListener, false);
    expect(onCreatePrayCalled, true);
    expect(onShowError, true);
  });

  test("PrayController.deletePray()", () async {
    // Arrange
    bool notifyListener = false;
    controller.addListener(() {
      notifyListener = true;
    });

    DateTime date = DateTime(
      2024,
      4,
      18,
      0,
      0,
      0,
      0,
    );

    Praies pray = Praies(id: 0, idUser: 0, date: date);

    controller.cache[date] = pray;

    bool onDeletePrayCalled = false;
    supabaseController.onDeletePray = (DateTime dateSelected, int idUser) async {
      onDeletePrayCalled = true;
      return pray;
    };

    // Act
    final response = await controller.deletePray(date, 0);

    // Assert
    expect(response, true);
    expect(notifyListener, false);
    expect(onDeletePrayCalled, true);
    expect(controller.cache[date], null);
  });

  test("PrayController.deletePray(erro)", () async {
    // Arrange
    bool notifyListener = false;
    controller.addListener(() {
      notifyListener = true;
    });

    DateTime date = DateTime(
      2024,
      4,
      18,
      0,
      0,
      0,
      0,
    );

    bool onDeletePrayCalled = false;
    supabaseController.onDeletePray = (DateTime dateSelected, int idUser) async {
      onDeletePrayCalled = true;
      throw Error;
    };

    bool onShowError = false;
    appNavigator.onShowError = (String error) {
      onShowError = true;
    };

    // Act
    final response = await controller.deletePray(date, 0);

    // Assert
    expect(response, false);
    expect(notifyListener, false);
    expect(onDeletePrayCalled, true);
    expect(onShowError, true);
  });

  test("PrayController.existsPray(Pray existe no banco)", () async {
    // Arrange
    bool notifyListener = false;
    controller.addListener(() {
      notifyListener = true;
    });

    DateTime date = DateTime(
      2024,
      4,
      18,
      0,
      0,
      0,
      0,
    );

    Praies pray = Praies(id: 0, idUser: 0, date: date);

    bool onGetPrayCalled = false;
    supabaseController.onGetPray = (DateTime dateSelected, int idUser) async {
      onGetPrayCalled = true;
      List<Map<String, dynamic>> data = [
        {
          "id": 0,
          "idUser": 0,
          "date": date.toString(),
        }
      ];
      return data;
    };

    // Act
    final response = await controller.existsPray(date, 0);

    // Assert
    expect(response, true);
    expect(notifyListener, false);
    expect(onGetPrayCalled, true);
    expect(controller.cache[date].toString(), pray.toString());
  });

  test("PrayController.existsPray(Pray não existe)", () async {
    // Arrange
    bool notifyListener = false;
    controller.addListener(() {
      notifyListener = true;
    });

    DateTime date = DateTime(
      2024,
      4,
      18,
      0,
      0,
      0,
      0,
    );

    bool onGetPrayCalled = false;
    supabaseController.onGetPray = (DateTime dateSelected, int idUser) async {
      onGetPrayCalled = true;
      List<Map<String, dynamic>> data = [];
      return data;
    };

    // Act
    final response = await controller.existsPray(date, 0);

    // Assert
    expect(response, false);
    expect(notifyListener, false);
    expect(onGetPrayCalled, true);
    expect(controller.cache[date], null);
  });

  test("PrayController.existsPray(Pray existe no cache)", () async {
    // Arrange
    bool notifyListener = false;
    controller.addListener(() {
      notifyListener = true;
    });

    DateTime date = DateTime(2024, 4, 18, 0, 0, 0, 0);
    Praies pray = Praies(id: 0, idUser: 0, date: date);
    controller.cache[date] = pray;

    // Act
    final response = await controller.existsPray(date, 0);

    // Assert
    expect(response, true);
    expect(notifyListener, false);
  });

  test("PrayController.existsPrayInCache(Pray existe no cache)", () {
    // Arrange
    bool notifyListener = false;
    controller.addListener(() {
      notifyListener = true;
    });

    DateTime date = DateTime(2024, 4, 18, 0, 0, 0, 0);
    Praies pray = Praies(id: 0, idUser: 0, date: date);
    controller.cache[date] = pray;

    // Act
    final response = controller.existsPrayInCache(date);

    // Assert
    expect(response, true);
    expect(notifyListener, false);
  });

  test("PrayController.existsPrayInCache(Pray não existe no cache)", () {
    // Arrange
    DateTime date = DateTime(2024, 4, 18, 0, 0, 0, 0);

    // Act
    final response = controller.existsPrayInCache(date);

    // Assert
    expect(response, false);
  });
}
