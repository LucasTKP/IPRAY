import 'package:ipray/shared/app_navigator.dart';

class MockAppNavigator extends AppNavigator{
  @override
  navigatePop() => onNavigatePop();
  Function() onNavigatePop = () => throw UnimplementedError();

  @override
  navigateToHome() => onNavigateToHome();
  Function() onNavigateToHome = () => throw UnimplementedError();

  @override
  navigateToSignin() => onNavigateToSignin();
  Function() onNavigateToSignin = () => throw UnimplementedError();

  @override
  navigateToSignup() => onNavigateToSignup();
  Function() onNavigateToSignup = () => throw UnimplementedError();

  @override
  showError(String error) => onShowError(error);
  Function(String error) onShowError = (error) => throw UnimplementedError();
  
}