import 'package:ipray/shared/app_navigator.dart';

class MockAppNavigator extends AppNavigator {
  @override
  navigatePop() => onNavigatePop();
  Function() onNavigatePop = () => throw UnimplementedError();

  @override
  navigateToSignin() => onNavigateToSignin();
  Function() onNavigateToSignin = () => throw UnimplementedError();

  @override
  navigateToSignup() => onNavigateToSignup();
  Function() onNavigateToSignup = () => throw UnimplementedError();

  @override
  navigateToRoutes() => onNavigateToRoutes();
  Function() onNavigateToRoutes = () => throw UnimplementedError();

  @override
  showError(String error) => onShowError(error);
  Function(String error) onShowError = (error) => throw UnimplementedError();
}
