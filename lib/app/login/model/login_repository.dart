import 'package:momentum_bank/app/utils/app_constants.dart';
import 'package:momentum_bank/app/utils/app_preferences.dart';

import 'login_request.dart';
import 'login_response.dart';
import 'login_service.dart';

class LoginRepository {
  LoginService _loginService = LoginService();

  Future<LoginResponse> loginUser({LoginRequest loginRequest}) async {
    dynamic response = await _loginService.loginUser(loginRequest: loginRequest);
    LoginResponse _loginResponse = LoginResponse.fromJson(response);
    if (_loginResponse.registered) {
      appPreferences.save(key: AppConstants.PREF_LOGIN_RESPONSE, value: _loginResponse);
    }
    return _loginResponse;
  }
}
